import 'package:auto_size_text/auto_size_text.dart';
import 'package:bunyang/Data/OrganizationCode.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

class SummaryInfoView extends StatelessWidget
{
  SummaryInfoView(this._data);
  
  final Map<String, String> _data;

  @override
  Widget build(BuildContext context) 
  {
    var panId = _data["PAN_ID"];
    var currPanId = _data["CURR_PAN_ID"];
    var currPanKdCd = _data["CURR_PAN_KD_CD"];

    bool isModifyNotice = currPanKdCd != "01" && panId != currPanId ? currPanKdCd == "02" : false;
    bool isCancelNotice = currPanKdCd != "01" && panId != currPanId ? currPanKdCd == "03" : false;

    String department = _data["ARA_HDQ_CD"].isNotEmpty ? OrganizationCode().getCodeName(int.parse(_data["ARA_HDQ_CD"])) : "";
    return Container
    (
      width: MediaQuery.of(context).size.width,
      child: Padding
      (
        child: Column
        (
          children: <Widget>
          [
            Row
            (
              children : <Widget>
              [
                Icon(Icons.assignment, color: Colors.black),
                SizedBox(width: 10),
                Text('공고개요', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 27, fontFamily: 'TmonTium', fontWeight: FontWeight.w500))
              ]
            ),
            isModifyNotice ? AutoSizeText
            (
              '본 공고문에 대한 정정 공고문이 있습니다.',
              maxLines: 2,
              textAlign: TextAlign.left, 
              style: TextStyle(color: Colors.red, fontSize: 23, fontFamily: 'TmonTium', fontWeight: FontWeight.w800)
            ) : SizedBox(),
            isCancelNotice ? AutoSizeText
            (
              '본 공고문에 대한 취소 공고문이 있습니다.',
              maxLines: 2,
              textAlign: TextAlign.left, 
              style: TextStyle(color: Colors.red, fontSize: 23, fontFamily: 'TmonTium', fontWeight: FontWeight.w800)
            ) : SizedBox(),
            Row
            (
              children : <Widget>
              [
                Icon(Icons.brightness_high, color: Colors.black),
                SizedBox(width: 10),
                AutoSizeText(_data["PAN_NM"], maxLines: 2, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium', decoration: TextDecoration.underline))
              ]
            ),
            department.isNotEmpty ? 
            Text(sprintf('담당부서 : %s', [department]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium')) 
            : SizedBox(),
            _data["IQY_TLNO"].isNotEmpty ?
            Text(sprintf('문의처 : %s', [_data["IQY_TLNO"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium')) 
            : SizedBox(),
            _data["PAN_DT"].isNotEmpty ?
            Text(sprintf('공고일 : %s', [getDateFormat(_data["PAN_DT"])]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium')) 
            : SizedBox(),
            _data["CLSG_DT"].isNotEmpty ?
            Text(sprintf('마감일 : %s', [getDateFormat(_data["CLSG_DT"])]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium')) 
            : SizedBox(),
            _data["PAN_DTL_CTS"].isNotEmpty ?
            Text(sprintf('공고내용 : %s', [_data["PAN_DTL_CTS"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium')) 
            : SizedBox(),
          ],
        ),
        padding: EdgeInsets.only(left: 10, right: 10)
      )
    );
  }
}