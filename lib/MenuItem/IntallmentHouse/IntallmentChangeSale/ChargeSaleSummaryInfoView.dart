import 'package:bunyang/Util/PDFViewer.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';

class ChargeSaleSummaryInfoView extends StatelessWidget
{
  ChargeSaleSummaryInfoView(this._defaultData);

  final Map<String, List<Map<String, String>>> _defaultData;

  List<Widget> _getContents(BuildContext context)
  {
    List<Widget> widgets = new List<Widget>();

    widgets.add(Row
    (
      children : <Widget>
      [
        Icon(Icons.stars, color: Colors.black),
        SizedBox(width: 10),
        Text('공고개요', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 27, fontFamily: 'TmonTium', fontWeight: FontWeight.w500))
      ]
    ));

    String pdfFileName = _defaultData['dsAhflList'].where((map) => map['SL_PAN_AHFL_DS_CD'] == '01').first['CMN_AHFL_NM'];
    String pdfSerialNum = _defaultData['dsAhflList'].where((map) => map['SL_PAN_AHFL_DS_CD'] == '01').first['CMN_AHFL_SN'];
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
          myText(pdfFileName)
        ]
      ),
      onPressed: () => Navigator.push
      (
        context,
        MaterialPageRoute(builder: (context) => PDFViewer(pdfFileName, pdfSerialNum))
      )
    ));
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
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column
        (
          children: _getContents(context)
        ),
      )
    );
  }
}