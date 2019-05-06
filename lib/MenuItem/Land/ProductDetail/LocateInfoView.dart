import 'package:bunyang/Map/MyGoogleMapView.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';

class LocateInfoView extends StatelessWidget
{
  LocateInfoView(Map<String, String> data)
  {
    widgets.clear();
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

    if(data["BZDT_NM"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('사업지구명 : %s', [data["BZDT_NM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    if(data["BZDT_SS"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('상태 : %s', [data["BZDT_SS"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));
    
    if(data["LCT_ARA_NM"].isNotEmpty)
      widgets.add(MyGoogleMap("소재지", data["LCT_ARA_NM"]));

    if(data["LNO"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('지번 : %s', [data["LNO"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    if(data["IQY_TLNO"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('문의처 : %s', [data["IQY_TLNO"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));
    
    if(data["LNCT_CD_NM"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('지목 : %s', [data["LNCT_CD_NM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    if(data["AR"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('면적(㎡) : %s', [data["AR"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));
    
    if(data["STL_SPL_PP_CD_NM"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('공급용도 : %s', [data["STL_SPL_PP_CD_NM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));
    
    if(data["STL_PP_ARA_CD_NM"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('용도지역 : %s', [data["STL_PP_ARA_CD_NM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));
    
    if(data["BUK_RT"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('용적율(%) : %s', [data["BUK_RT"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));
    
    if(data["BTLR_RT"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('건폐율 : %s', [data["BUK_RT"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));
    
    if(data["CON_CCW_DT"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('공사준공일 : %s', [data["CON_CCW_DT"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    if(data["SPL_OTST_DT"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('공급개시일 : %s', [data["SPL_OTST_DT"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    var f = NumberFormat('#,###');
    if(data["SPL_XPC_AMT"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('공급(예정)금액(원) : %s', [f.format(int.parse(data["SPL_XPC_AMT"]))]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    // 분할납부조건

    if(data["STL_PR_STGY_DS_CD_NM"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('가격전략구분 : %s', [data["STL_PR_STGY_DS_CD_NM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));
  }
  
  final List<Widget> widgets = new List<Widget>();
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
          children: widgets,
        ),
        padding: EdgeInsets.only(left: 10, right: 10)
      )
    );
  }
}