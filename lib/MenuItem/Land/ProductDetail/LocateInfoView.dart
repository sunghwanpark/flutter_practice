import 'package:bunyang/Map/MyGoogleMapView.dart';
import 'package:bunyang/MenuItem/Land/ProductDetail/LocateInfo/ContractScheduleView.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';

class LocateInfoView extends StatelessWidget
{
  LocateInfoView(this.cachedData, this.ccrCnntSysDsCd, this.aisInfSn);

  List<Widget> _makeWidgets(BuildContext context)
  {
    List<Widget> widgets = new List<Widget>();
    
    String lastDt = cachedData["AR_EXA_DT"].isNotEmpty ? cachedData["AR_EXA_DT"] :
      cachedData["AR_EXA_XPC_DT"].isNotEmpty ? cachedData["AR_EXA_XPC_DT"] :
      cachedData["LND_US_PSB_DT"];
    
    widgets.add(
      Row
      (
        children : <Widget>
        [
          Icon(Icons.info_outline, color: Colors.black),
          SizedBox(width: 10),
          Text('필지안내', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium'))
        ]
      ));

    if(cachedData["BZDT_NM"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('사업지구명 : %s', [cachedData["BZDT_NM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    if(cachedData["BZDT_SS"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('상태 : %s', [cachedData["BZDT_SS"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));
    
    if(cachedData["LCT_ARA_NM"].isNotEmpty)
      widgets.add(MyGoogleMap("소재지", cachedData["LCT_ARA_NM"]));

    if(cachedData["LNO"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('지번 : %s', [cachedData["LNO"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    if(cachedData["IQY_TLNO"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('문의처 : %s', [cachedData["IQY_TLNO"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));
    
    if(cachedData["LNCT_CD_NM"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('지목 : %s', [cachedData["LNCT_CD_NM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    if(cachedData["AR"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('면적(㎡) : %s', [cachedData["AR"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));
    
    if(cachedData["STL_SPL_PP_CD_NM"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('공급용도 : %s', [cachedData["STL_SPL_PP_CD_NM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));
    
    if(cachedData["STL_PP_ARA_CD_NM"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('용도지역 : %s', [cachedData["STL_PP_ARA_CD_NM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));
    
    if(cachedData["BUK_RT"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('용적율(%) : %s', [cachedData["BUK_RT"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));
    
    if(cachedData["BTLR_RT"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('건폐율 : %s', [cachedData["BUK_RT"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));
    
    if(cachedData["CON_CCW_DT"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('공사준공일 : %s', [getDateFormat(cachedData["CON_CCW_DT"])]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    if(cachedData["SPL_OTST_DT"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('공급개시일 : %s', [getDateFormat(cachedData["SPL_OTST_DT"])]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    var f = NumberFormat('#,###');
    if(cachedData["SPL_XPC_AMT"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('공급(예정)금액(원) : %s', [f.format(int.parse(cachedData["SPL_XPC_AMT"]))]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    // 분할납부조건
    widgets.add(FlatButton
    (
      textTheme: ButtonTextTheme.accent,
      onPressed: () =>
      {
        showDialog
        (
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context)
          {
            return AlertDialog
            (
              title: Center(child: Text('예정약정사항', textAlign: TextAlign.left, style: TextStyle(color: Colors.deepPurpleAccent[800], fontWeight: FontWeight.w600, fontSize: 30, fontFamily: 'TmonTium'))),
              shape: RoundedRectangleBorder
              (
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(style: BorderStyle.solid, color: Colors.black.withOpacity(0.2))
              ),
              backgroundColor: Colors.white,
              elevation: 0.2,
              contentPadding: EdgeInsets.all(0),
              content: Container
              (
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height,
                child: ContractSchedule(ccrCnntSysDsCd, aisInfSn, DateTime.tryParse(lastDt), cachedData["SPL_XPC_AMT"])
              ),
              actions: <Widget>
              [
                FlatButton
                (
                  child: myText('확인'),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            );
          }
        )
      },
      child: Container
      (
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration
        (
          color: Colors.black.withOpacity(0.2),
          border: Border.all(color: Colors.black)
        ),
        child: Align
        (
          alignment: Alignment.center,
          child: Text('예정약정사항조회', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20, fontFamily: 'TmonTium'))
        )
      )
    ));

    if(cachedData["STL_PR_STGY_DS_CD_NM"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('가격전략구분 : %s', [cachedData["STL_PR_STGY_DS_CD_NM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    return widgets;
  }

  final String ccrCnntSysDsCd;
  final String aisInfSn;
  final Map<String, String> cachedData;

  @override
  Widget build(BuildContext context)
  {
    return Container
    (
      width: MediaQuery.of(context).size.width,
      child: Padding
      (
        child: Column
        (
          children: _makeWidgets(context),
        ),
        padding: EdgeInsets.only(left: 10, right: 10)
      )
    );
  }
}