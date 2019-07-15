import 'package:bunyang/MenuItem/Land/ProductDetail/LocateInfo/ContractSchedulePresenter.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';

class ContractPay
{
  ContractPay(this.count, this.contractDay, this.contractMoney, this.contractInterest, this.totalMoney);

  final int count;
  final DateTime contractDay;
  final String contractMoney;
  final String contractInterest;
  final String totalMoney;
}

class ContractSchedule extends StatefulWidget
{
  ContractSchedule(this.ccrCnntSysDsCd, this.aisInfSn, this.lastDt, this.splXpcAmt);

  final String ccrCnntSysDsCd;
  final String aisInfSn;
  final DateTime lastDt;
  final String splXpcAmt;

  @override
  State<StatefulWidget> createState() => ContractScheduleView(ccrCnntSysDsCd, aisInfSn, lastDt, splXpcAmt);
}

class ContractScheduleView extends State<ContractSchedule>
{
  ContractScheduleView(this.ccrCnntSysDsCd, this.aisInfSn, this.lastDt, this.splXpcAmt)
  {
    _format = NumberFormat('#,###');
    _checkDate = null;
  }

  final String ccrCnntSysDsCd;
  final String aisInfSn;
  final DateTime lastDt;
  final String splXpcAmt;

  NumberFormat _format;

  ContractSchedulePresenter _presenter;
  Map<String, String> cachedDatas;
  LoadingState _loadingState = LoadingState.LOADING;
  
  DateTime _checkDate;
  List<DataRow> _contractPays = new List<DataRow>();

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

  void onError(dynamic err)
  {
    print(err);
    print(StackTrace.current);
    setState(() {
     _loadingState = LoadingState.ERROR; 
    });
  }

  void onCheckDate(DateTime time)
  {
    _checkDate = time;
    _contractPays.clear();
    int nNot = cachedDatas['XCPC_RCP_NOT'].isNotEmpty ? int.parse(cachedDatas['XCPC_RCP_NOT']) : 0;
    int nMCnt = cachedDatas['XCPC_RCP_INTV_MCNT'].isNotEmpty ? int.tryParse(cachedDatas['XCPC_RCP_INTV_MCNT']) : 0; // 수납간견
    double nCtrtAmt = splXpcAmt.isNotEmpty ? int.tryParse(splXpcAmt) * 0.1 : 0; //계약금액
    double nSllnAmt2 = splXpcAmt.isNotEmpty ? int.tryParse(splXpcAmt) - nCtrtAmt : 0; //계약금액을 뺀 남은금액
    double nToyAmt = nSllnAmt2 / nNot; //분할금액
    double intRt = cachedDatas['STL_PC_RCP_MD_DS_CD_NM'].contains('무이자') ? 0 : cachedDatas['STPL_INT_RT'].isNotEmpty ?
      double.tryParse(cachedDatas['STPL_INT_RT']) : 0;
    //double nToyInt =  (nToyAmt * intRt) / 100; //분할이자

    List<DateTime> payDates = new List<DateTime>();
    for(int i = 0; i <= nNot; i++)
    {
      if(i == 0)
      {
        payDates.add(_checkDate);
        _contractPays.add(DataRow
        (
          cells: <DataCell>
          [
            DataCell(myText(i.toString())),
            DataCell(myText(_checkDate.toString().substring(0, 10))),
            DataCell(myText(_format.format(nCtrtAmt.toInt()))),
            DataCell(myText('')),
            DataCell(myText(_format.format(nCtrtAmt.toInt())))
          ]
        ));
      }
      else
      {
        DateTime prevDateTime = payDates[i - 1];
        DateTime nextDateTime = DateTime(prevDateTime.year, prevDateTime.month + nMCnt, prevDateTime.day);

        // 토지사용가능일과 약정일(이전회차)중 큰날을 이자기준일로 삼는다.
        DateTime startDt = lastDt != null ? prevDateTime.isBefore(lastDt) ? lastDt : prevDateTime : prevDateTime;

        // 이자계산일수 = 이자기준일과 (회차의 약정일) 사이의 일수
        int dayCount = nextDateTime.isBefore(startDt) ? 0 : nextDateTime.difference(startDt).inDays;
        dayCount = dayCount <= 0 ? 0 : dayCount;
        int stplInt = (((nSllnAmt2 * intRt * dayCount) / 100) / 365).floor();
        double toyStoAmt = nToyAmt + stplInt;

        payDates.add(nextDateTime);
        _contractPays.add(DataRow
        (
          cells: <DataCell>
          [
            DataCell(myText(i.toString())),
            DataCell(myText(nextDateTime.toString().substring(0, 10))),
            DataCell(myText(_format.format(nToyAmt.toInt()))),
            DataCell(myText(_format.format(stplInt))),
            DataCell(myText(_format.format(toyStoAmt.toInt())))
          ]
        ));

        nSllnAmt2 = nSllnAmt2 - nToyAmt;
      }
    }

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
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(bottom: 10),
          children: <Widget>
          [
            cachedDatas['SLLN_AMT'].isNotEmpty ? Padding
            (
              padding: EdgeInsets.only(left: 20),
              child: Align
              (
                alignment: Alignment.centerLeft,
                child: Text(sprintf('매각금액 %s', [_format.format(int.parse(cachedDatas['SLLN_AMT']))]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20, fontFamily: 'TmonTium'))
              )
            ) : SizedBox(),
            cachedDatas['STL_PC_RCP_MD_DS_CD_NM'].isNotEmpty ? Padding
            (
              padding: EdgeInsets.only(left: 20),
              child: Align
              (
                alignment: Alignment.centerLeft,
                child: Text(sprintf('수납방법 %s', [cachedDatas['STL_PC_RCP_MD_DS_CD_NM']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20, fontFamily: 'TmonTium'))
              )
            ) : SizedBox(),
            cachedDatas['XCPC_RCP_INTV_MCNT'].isNotEmpty ? Padding
            (
              padding: EdgeInsets.only(left: 20),
              child: Align
              (
                alignment: Alignment.centerLeft,
                child: Text(sprintf('수납간격 %s', [cachedDatas['XCPC_RCP_INTV_MCNT']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20, fontFamily: 'TmonTium'))
              )
            ) : SizedBox(),
            cachedDatas['XCPC_RCP_NOT'].isNotEmpty ? Padding
            (
              padding: EdgeInsets.only(left: 20),
              child: Align
              (
                alignment: Alignment.centerLeft,
                child: Text(sprintf('수납횟수 %s', [cachedDatas['XCPC_RCP_NOT']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20, fontFamily: 'TmonTium'))
              )
            ) : SizedBox(),
            cachedDatas['STPL_INT_RT'].isNotEmpty ? Padding
            (
              padding: EdgeInsets.only(left: 20),
              child: Align
              (
                alignment: Alignment.centerLeft,
                child: Text
                (
                  sprintf('약정이율 %s', [cachedDatas['STL_PC_RCP_MD_DS_CD_NM'].contains('무이자') ? '0' : cachedDatas['STPL_INT_RT']]),
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20, fontFamily: 'TmonTium')
                )
              )
            ) : SizedBox(),
            Padding
            (
              padding: EdgeInsets.only(left: 10, right: 10),
              child: FlatButton
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
                    Icon(Icons.calendar_today, color: Colors.black),
                    SizedBox(width: 5),
                    myText('계약가능일 선택(예정)')
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
                  }
                ).then((date) => onCheckDate(date)),
              )
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
            _contractPays.length > 0 ? SingleChildScrollView
            (
              scrollDirection: Axis.horizontal,
              child: DataTable
              (
                columns: <DataColumn>
                [
                  DataColumn(label: myText('회차')),
                  DataColumn(label: myText('약정일')),
                  DataColumn(label: myText('약정금액(원)')),
                  DataColumn(label: myText('약정이자(원)')),
                  DataColumn(label: myText('합계(원)'))
                ],
                rows: _contractPays
              )
            ) : SizedBox()
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