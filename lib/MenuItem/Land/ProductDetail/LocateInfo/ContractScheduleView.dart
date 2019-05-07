import 'package:bunyang/MenuItem/Land/ProductDetail/LocateInfo/ContractSchedulePresenter.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';

class ContractSchedule extends StatefulWidget
{
  ContractSchedule(this.ccrCnntSysDsCd, this.aisInfSn);

  final String ccrCnntSysDsCd;
  final String aisInfSn;

  @override
  State<StatefulWidget> createState() => ContractScheduleView(ccrCnntSysDsCd, aisInfSn);
}

class ContractScheduleView extends State<ContractSchedule>
{
  ContractScheduleView(this.ccrCnntSysDsCd, this.aisInfSn)
  {
    _format = NumberFormat('#,###');
  }

  final String ccrCnntSysDsCd;
  final String aisInfSn;
  NumberFormat _format;

  ContractSchedulePresenter _presenter;
  Map<String, String> cachedDatas;
  LoadingState _loadingState = LoadingState.LOADING;
  DateTime _checkDate = null;

  @override
  void initState() 
  {
    _presenter = new ContractSchedulePresenter(this);
    super.initState();

    _presenter.onRequestContractInfo(ccrCnntSysDsCd, aisInfSn);
  }

  void onComplete(Map<String, List<Map<String, String>>> res)
  {
    cachedDatas = res["dsList"].first;
    setState(() {
      _loadingState = LoadingState.DONE;
    });
  }

  void onError()
  {
    setState(() {
     _loadingState = LoadingState.ERROR; 
    });
  }

  void onCheckDate(DateTime time)
  {
    _checkDate = time;

    int nNot = int.parse(cachedDatas['XCPC_RCP_NOT']);
    double nCtrtAmt = int.parse(cachedDatas['SLLN_AMT']) * 0.1; //계약금액
    double nSllnAmt2 = int.parse(cachedDatas['SLLN_AMT']) - nCtrtAmt; //계약금액을 뺀 남은금액
    double nToyAmt = nSllnAmt2 / nNot; //분할금액
    double nToyInt =  (nToyAmt * (int.parse(cachedDatas['STPL_INT_RT']) / 100 )); //분할이자

    setState(() {
      _loadingState = LoadingState.DONE;
    });
  }

  Widget getContents(BuildContext context)
  {
    switch(_loadingState)
    {
      case LoadingState.DONE:
        return ListView
        (
          padding: EdgeInsets.only(bottom: 10),
          children: <Widget>
          [
            cachedDatas['SLLN_AMT'].isNotEmpty ? Align
            (
              alignment: Alignment.center,
              child: Text(sprintf('매각금액 %s', [_format.format(int.parse(cachedDatas['SLLN_AMT']))]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20, fontFamily: 'TmonTium'))
            ) : SizedBox(),
            cachedDatas['STL_PC_RCP_MD_DS_CD_NM'].isNotEmpty ? Align
            (
              alignment: Alignment.center,
              child: Text(sprintf('수납방법 %s', [cachedDatas['STL_PC_RCP_MD_DS_CD_NM']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20, fontFamily: 'TmonTium'))
            ) : SizedBox(),
            cachedDatas['XCPC_RCP_INTV_MCNT'].isNotEmpty ? Align
            (
              alignment: Alignment.center,
              child: Text(sprintf('수납간격 %s', [cachedDatas['XCPC_RCP_INTV_MCNT']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20, fontFamily: 'TmonTium'))
            ) : SizedBox(),
            cachedDatas['XCPC_RCP_NOT'].isNotEmpty ? Align
            (
              alignment: Alignment.center,
              child: Text(sprintf('수납횟수 %s', [cachedDatas['XCPC_RCP_NOT']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20, fontFamily: 'TmonTium'))
            ) : SizedBox(),
            cachedDatas['STPL_INT_RT'].isNotEmpty ? Align
            (
              alignment: Alignment.center,
              child: Text
              (
                sprintf('약정이율 %s', [cachedDatas['STL_PC_RCP_MD_DS_CD_NM'].contains('무이자') ? '0' : cachedDatas['STPL_INT_RT']]),
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20, fontFamily: 'TmonTium')
              )
            ) : SizedBox(),
            FlatButton
            (
              color: Colors.black.withOpacity(0.1),
              shape: RoundedRectangleBorder
              (
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.black)
              ),
              child: Row
              (
                children : <Widget>
                [
                  Icon
                  (
                    Icons.calendar_today,
                    color: Colors.black
                  ),
                  SizedBox(width: 5),
                  myText('계약가능일(예정)')
                ]
              ),
              onPressed: () => showDatePicker
              (
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2019),
                lastDate: DateTime(2030),
                builder: (BuildContext context, Widget child) 
                {
                  return Theme
                  (
                    data: ThemeData.dark(),
                    child: child,
                  );
                },
              ).then((date) => onCheckDate(date)),
            ),
            _checkDate != null ? Align
            (
              alignment: Alignment.center,
              child: Text
              (
                _checkDate.toString().substring(0, 10),
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20, fontFamily: 'TmonTium')
              )
            ) : SizedBox(),
          ],
        );
      case LoadingState.LOADING:
        return CircularProgressIndicator(backgroundColor: Colors.black);
      case LoadingState.ERROR:
        return Text('오류가 발생하여 내용을 불러올 수 없습니다.');
      default:
        return Container();
    }
  }
  
  @override
  Widget build(BuildContext context) 
  {
    return Container
    (
      alignment: Alignment.center,
      child: getContents(context),
    );
  }
}