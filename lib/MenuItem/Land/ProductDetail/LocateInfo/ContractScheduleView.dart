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

  Widget getContents()
  {
    switch(_loadingState)
    {
      case LoadingState.DONE:
        return ListView
        (
          children: <Widget>
          [
            cachedDatas['SLLN_AMT'].isNotEmpty ? Align
            (
              alignment: Alignment.center,
              child: Text(sprintf('매각금액 %s', [_format.format(int.parse(cachedDatas['SLLN_AMT']))]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20, fontFamily: 'TmonTium'))
            ) : SizedBox(),
            /*cachedDatas['STL_PC_RCP_MD_DS_CD_NM'].isNotEmpty ? Align
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
            ) : SizedBox()*/
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
      child: getContents(),
    );
  }
}