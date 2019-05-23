import 'package:auto_size_text/auto_size_text.dart';
import 'package:bunyang/Util/PDFViewer.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';

class BusinessShortInfoView extends StatelessWidget
{
  BusinessShortInfoView(this._data, this._attachDatas);

  final Map<String, String> _data;
  final List<Map<String, String>> _attachDatas;

  _getContents(BuildContext context)
  {
    List<Widget> widgets = new List<Widget>();
    
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

    if(_data["EPZ_NM"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('사업명 : %s', [_data["EPZ_NM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    if(_data["EPZ_PPLS_CTS"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('사업목적 : %s', [_data["EPZ_PPLS_CTS"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));
    
    final doubleFormat = NumberFormat("#,###.0");
    final intFormat = NumberFormat("#,###");
    if(_data["EPZ_AR"].isNotEmpty)
    {
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('사업면적 : %s ㎡', [doubleFormat.format(double.parse(_data["EPZ_AR"]))]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));
    }

    if(_data["EPZ_XPS_CTS"].isNotEmpty)
    {
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('사업비 : %s', [intFormat.format(int.parse(_data["EPZ_XPS_CTS"]))]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));
    }

    widgets.add(
      Align
      (
        alignment: Alignment.centerLeft,
        child: Text(_data["EPZ_TR_ST_DT"].isNotEmpty && _data["EPZ_TR_ED_DT"].isNotEmpty ?
          sprintf('사업기간 : %s ~ %s', [getDateFormat(_data["EPZ_TR_ST_DT"]), getDateFormat(_data["EPZ_TR_ED_DT"])])
          : sprintf('사업기간 : %s ~', [getDateFormat(_data["EPZ_TR_ST_DT"])]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));

    if(_attachDatas.length > 0)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text('사업지구 홍보 팜플렛', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium', fontWeight: FontWeight.w500))
      ));

      _attachDatas.forEach((map)
      {
        if(map['CCR_CNNT_SYS_DS_CD'] == '01')
        {
          String pdfFileName = map['CMN_AHFL_NM'];
          String pdfSerialNum = map['CMN_AHFL_SN'];

          widgets.add(FlatButton
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
                Icon(Icons.picture_as_pdf, color: Colors.black),
                SizedBox(width: 5),
                Container
                (
                  width: MediaQuery.of(context).size.width - 100,
                  child: AutoSizeText(pdfFileName, maxLines: 1, textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
                )
              ]
            ),
            onPressed: () => Navigator.push
            (
              context,
              MaterialPageRoute(builder: (context) => PDFViewer(pdfFileName, pdfSerialNum))
            )
          ));
        }
      });

      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text('팜플렛 토지목록 중 계약가능한 토지는 시차 등으로 실시간 변경될 수 있습니다.', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: 'TmonTium', decoration: TextDecoration.underline))
      ));
    }

    return widgets;
  }

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
          children: _getContents(context),
        ),
        padding: EdgeInsets.only(left: 10, right: 10)
      )
    );
  }
}