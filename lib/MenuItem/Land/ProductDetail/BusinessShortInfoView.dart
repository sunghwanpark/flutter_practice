import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';

class BusinessShortInfoView extends StatelessWidget
{
  BusinessShortInfoView(Map<String, String> data)
  {
    widgets.clear();
    widgets.add(
      Row
      (
        children : <Widget>
        [
          Icon(Icons.date_range, color: Colors.black),
          SizedBox(width: 10),
          Text('사업개요', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium'))
        ]
      ));

    if(data["EPZ_NM"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('사업명 : %s', [data["EPZ_NM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    if(data["EPZ_PPLS_CTS"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('사업목적 : %s', [data["EPZ_PPLS_CTS"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));
    
    final f = NumberFormat("#,###.0");
    if(data["EPZ_AR"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('사업면적 : %s ㎡', [f.format(double.parse(data["EPZ_AR"]))]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    if(data["EPZ_XPS_CTS"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('사업비 : %s', [data["EPZ_XPS_CTS"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    if(data["EPZ_TR_ST_DT"].isNotEmpty && data["EPZ_TR_ED_DT"].isNotEmpty)
    {
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('사업기간 : %s ~ %s', [_getDate(data["EPZ_TR_ST_DT"]), _getDate(data["EPZ_TR_ED_DT"])]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));
    }
  }

  String _getDate(String dateString)
  {
    StringBuffer sb = new StringBuffer();
    sb.write(dateString.substring(0, 4));
    sb.write('.');
    sb.write(dateString.substring(4, 6));
    sb.write('.');
    sb.write(dateString.substring(6, 8));

    return sb.toString();
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