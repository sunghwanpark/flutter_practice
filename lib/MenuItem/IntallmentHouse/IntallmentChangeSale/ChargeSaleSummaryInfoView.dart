import 'package:auto_size_text/auto_size_text.dart';
import 'package:bunyang/Abstract/AbstractContentsView.dart';
import 'package:bunyang/Util/PDFViewer.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

class ChargeSaleSummaryInfoView extends AbstractContentsView
{
  ChargeSaleSummaryInfoView(this._defaultData);

  final Map<String, List<Map<String, String>>> _defaultData;

  @override
  List<Widget> getContents(BuildContext context)
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

    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text(sprintf('유형 : %s', [_defaultData['dsPanInf'].first['SPL_TP_CD_NM']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
    ));
    
    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text(sprintf('공고일 : %s', [getDateFormat(_defaultData['dsPanInf'].first['PAN_DT'])]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
    ));

    var callNum = _defaultData['dsPanInf'].first['TLNO_CTS'];
    if(callNum.isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('문의처 : %s', [callNum]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }

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

    String rsn = _defaultData['dsPanInf'].first['CRC_RSN'];
    if(rsn.isNotEmpty)
    {
      widgets.add(Row
      (
        children : <Widget>
        [
          Icon(Icons.warning, color: Colors.red),
          SizedBox(width: 10),
          Text(sprintf('%s 사유', [_defaultData['dsPanInf'].first['PAN_KD_CD_NM'].substring(0, 2)]), textAlign: TextAlign.left, style: TextStyle(color: Colors.red, fontSize: 25, fontFamily: 'TmonTium', fontWeight: FontWeight.w500))
        ]
      ));

      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(rsn, textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }

    return widgets;
  }
}