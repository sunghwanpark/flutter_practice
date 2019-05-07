import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

class SupplyDateView extends StatelessWidget
{
  SupplyDateView(bool isTender, Map<String, String> landInfo, Map<String, String> data)
  {
    widgets.clear();

    String typeString = isTender ? "입찰" : "추첨";;
    
    widgets.add(
      Row
      (
        children : <Widget>
        [
          Icon(Icons.date_range, color: Colors.black),
          SizedBox(width: 10),
          Text(sprintf('공급일정(%s)', [typeString]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium'))
        ]
      ));

    widgets.add(
      Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('신청일시 : %s', [data["RQS_DTTM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));

    widgets.add(
      Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf(isTender ? "입찰보증금 납부마감일시 : %s" : '신청예약금 입금마감일시 : %s',
           [data["CLSG_DTTM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    
    widgets.add(
      Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf(isTender ? '개찰일시 : %s' : '추첨일정 : %s',
         [data["OPB_DTTM"].isNotEmpty ? data["OPB_DTTM"] : landInfo["LTR_DTTM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));

    widgets.add(
      Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf(isTender ?  '개찰결과게시일시 : %s' : '결과게시일정 : %s',
         [data["OPB_RSL_NT_DTTM"].isNotEmpty ? data["OPB_RSL_NT_DTTM"] : landInfo["PZWR_NT_DTTM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));

    if(landInfo["CTRT_ST_DT"].isNotEmpty && landInfo["CTRT_ED_DT"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('계약체결일정 : %s ~ %s', [getDateFormat(landInfo["CTRT_ST_DT"]), getDateFormat(landInfo["CTRT_ED_DT"])]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
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