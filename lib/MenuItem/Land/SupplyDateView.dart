import 'package:auto_size_text/auto_size_text.dart';
import 'package:bunyang/Abstract/AbstractContentsView.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

class SupplyDateView extends AbstractContentsView
{
  SupplyDateView(this.isTender, this.landInfo, this.data);

  final bool isTender;
  final Map<String, String> landInfo;
  final List<Map<String, String>> data;

  @override
  List<Widget> getContents(BuildContext context)
  {
    List<Widget> widgets = List<Widget>();
    String typeString = isTender ? "입찰" : "추첨";

    widgets.add(Row
    (
      children : <Widget>
      [
        Icon(Icons.date_range, color: Colors.black),
        SizedBox(width: 10),
        Text(sprintf('공급일정(%s)', [typeString]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium'))
      ]
    ));

    if(data.length > 1)
    {
      List<TableRow> rows = new List<TableRow>();
      rows.add(TableRow
      (
        children: <Widget>
        [
          AutoSizeText
          (
            '순위',
            textAlign: TextAlign.center,
            style: TextStyle
            (
              color: Colors.black,
              fontFamily: "TmonTium",
              fontSize: 20,
              fontWeight: FontWeight.w800
            ),
            maxLines: 1,
          ),
          AutoSizeText
          (
            '신청일시',
            textAlign: TextAlign.center,
            style: TextStyle
            (
              color: Colors.black,
              fontFamily: "TmonTium",
              fontSize: 20,
              fontWeight: FontWeight.w800
            ),
            maxLines: 1,
          ),
          AutoSizeText
          (
            '신청예약금 입금마감일시',
            textAlign: TextAlign.center,
            style: TextStyle
            (
              color: Colors.black,
              fontFamily: "TmonTium",
              fontSize: 20,
              fontWeight: FontWeight.w800
            ),
            maxLines: 1,
          )
        ]
      ));

      data.forEach((data) =>
      {
        rows.add(TableRow
        (
          children: <Widget>
          [
            AutoSizeText
            (
              data["RNK"],
              textAlign: TextAlign.center,
              style: TextStyle
              (
                color: Colors.black,
                fontFamily: "TmonTium",
                fontSize: 20,
                fontWeight: FontWeight.w800
              ),
              maxLines: 1,
            ),
            AutoSizeText
            (
              data["RQS_DTTM"],
              style: TextStyle
              (
                color: Colors.black,
                fontFamily: "TmonTium",
                fontSize: 20,
                fontWeight: FontWeight.w800
              ),
              maxLines: 1,
            ),
            AutoSizeText
            (
              data["CLSG_DTTM"],
              style: TextStyle
              (
                color: Colors.black,
                fontFamily: "TmonTium",
                fontSize: 20,
                fontWeight: FontWeight.w800
              ),
              maxLines: 1,
            )
          ]
        ))
      });

      widgets.add(Table
      (
        border: TableBorder.all(color: Colors.black, width: 1),
        columnWidths: {0: FractionColumnWidth(0.2)},
        children: rows,
      ));
    }
    else
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('신청일시 : %s', [data.first["RQS_DTTM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));

      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf(isTender ? "입찰보증금 납부마감일시 : %s" : '신청예약금 입금마감일시 : %s',
           [data.first["CLSG_DTTM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }

    widgets.add(
      Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf(isTender ? '개찰일시 : %s' : '추첨일정 : %s',
         [data.first["OPB_DTTM"].isNotEmpty ? data.first["OPB_DTTM"] : landInfo["LTR_DTTM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));

    widgets.add(
      Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf(isTender ?  '개찰결과게시일시 : %s' : '결과게시일정 : %s',
         [data.first["OPB_RSL_NT_DTTM"].isNotEmpty ? data.first["OPB_RSL_NT_DTTM"] : landInfo["PZWR_NT_DTTM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));

    if(landInfo["CTRT_ST_DT"].isNotEmpty && landInfo["CTRT_ED_DT"].isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('계약체결일정 : %s ~ %s', [getDateFormat(landInfo["CTRT_ST_DT"]), getDateFormat(landInfo["CTRT_ED_DT"])]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    return widgets;
  }
}