import 'package:auto_size_text/auto_size_text.dart';
import 'package:bunyang/Data/OrganizationCode.dart';
import 'package:bunyang/Util/PDFViewer.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';
import 'package:tuple/tuple.dart';

class SummaryInfoView extends StatelessWidget
{
  SummaryInfoView(this._data, List<Map<String, String>> attatchDatas)
  {
    for(int i = 0; i < attatchDatas.length; i++)
    {
      var map = attatchDatas[i];

      String pdfName = map["CMN_AHFL_NM"];
      if(!pdfName.contains('pdf'))
        continue;

      String serialNum = map["CMN_AHFL_SN"];
      String code = map["SL_PAN_AHFL_DS_CD"];

      if(!_attatchmentDatas.containsKey(code))
        _attatchmentDatas[code] = new List<Tuple2<String, String>>();

      _attatchmentDatas[code].add(Tuple2(pdfName, serialNum));
    }
  }
  
  final Map<String, String> _data;
  final Map<String, List<Tuple2<String, String>>> _attatchmentDatas = new Map<String, List<Tuple2<String, String>>>();

  _getPDFButton(BuildContext context, String pdfFileName, String pdfSerialNum)
  {
    return FlatButton
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
    );
  }

  _getContents(BuildContext context)
  {
    var panId = _data["PAN_ID"];
    var currPanId = _data["CURR_PAN_ID"];
    var currPanKdCd = _data["CURR_PAN_KD_CD"];

    bool isModifyNotice = currPanKdCd != "01" && panId != currPanId ? currPanKdCd == "02" : false;
    bool isCancelNotice = currPanKdCd != "01" && panId != currPanId ? currPanKdCd == "03" : false;

    String department = _data["ARA_HDQ_CD"].isNotEmpty ? OrganizationCode()[(int.parse(_data["ARA_HDQ_CD"]))] : "";

    List<Widget> widgets = new List<Widget>();

    widgets.add(Row
    (
      children : <Widget>
      [
        Icon(Icons.assignment, color: Colors.black),
        SizedBox(width: 10),
        Text('공고개요', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 27, fontFamily: 'TmonTium', fontWeight: FontWeight.w500))
      ]
    ));

    if(isModifyNotice)
    {
       widgets.add(AutoSizeText
      (
         '본 공고문에 대한 정정 공고문이 있습니다.',
        maxLines: 1,
        textAlign: TextAlign.left, 
        style: TextStyle(color: Colors.red, fontSize: 23, fontFamily: 'TmonTium', fontWeight: FontWeight.w800)
      ));
    }

    if(isCancelNotice)
    {
       widgets.add(AutoSizeText
      (
        '본 공고문에 대한 취소 공고문이 있습니다.',
        maxLines: 1,
        textAlign: TextAlign.left, 
        style: TextStyle(color: Colors.red, fontSize: 23, fontFamily: 'TmonTium', fontWeight: FontWeight.w800)
      ));
    }
    
    if(department.isNotEmpty)
    {
       widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('담당부서 : %s', [department]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }
            
    if(_data["IQY_TLNO"].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('문의처 : %s', [_data["IQY_TLNO"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }
    
    if(_data["PAN_DT"].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('공고일 : %s', [getDateFormat(_data["PAN_DT"])]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }
    
    if(_data["CLSG_DT"].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('마감일 : %s', [getDateFormat(_data["CLSG_DT"])]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium')) 
      ));
    }

    if(_attatchmentDatas.containsKey('01') && _attatchmentDatas['01'].length > 0)
    {
      widgets.add(Row
      (
        children : <Widget>
        [
          Icon(Icons.notifications, color: Colors.black),
          SizedBox(width: 10),
          Text('공고문', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium', fontWeight: FontWeight.w500))
        ]
      ));

      _attatchmentDatas['01'].forEach((tuple)
      {
        widgets.add(_getPDFButton(context, tuple.item1, tuple.item2));
      });
    }

    if(_attatchmentDatas.containsKey('02') && _attatchmentDatas['02'].length > 0)
    {
      widgets.add(Row
      (
        children : <Widget>
        [
          Icon(Icons.library_books, color: Colors.black),
          SizedBox(width: 10),
          Text('팜플렛', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium', fontWeight: FontWeight.w500))
        ]
      ));

      _attatchmentDatas['02'].forEach((tuple)
      {
        widgets.add(_getPDFButton(context, tuple.item1, tuple.item2));
      });
    }

    if(_attatchmentDatas.containsKey('19') && _attatchmentDatas['19'].length > 0)
    {
      widgets.add(Row
      (
        children : <Widget>
        [
          Icon(Icons.file_download, color: Colors.black),
          SizedBox(width: 10),
          Text('기타 첨부파일', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium', fontWeight: FontWeight.w500))
        ]
      ));

      _attatchmentDatas['19'].forEach((tuple)
      {
        widgets.add(_getPDFButton(context, tuple.item1, tuple.item2));
      });
    }

    if(_data["PAN_DTL_CTS"].isNotEmpty)
    {
      widgets.add(Text(sprintf('<공고내용>\n%s', [_data["PAN_DTL_CTS"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium')));
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
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column
        (
          children: _getContents(context)
        ),
      )
    );
  }
}