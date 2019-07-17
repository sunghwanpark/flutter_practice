import 'package:auto_size_text/auto_size_text.dart';
import 'package:bunyang/Abstract/AbstractContentsView.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';

class StoreBidInquiryGuideView extends AbstractContentsView
{
  StoreBidInquiryGuideView(this._datas);

  final List<Map<String, String>> _datas;

  @override
  List<Widget> getContents(BuildContext context)
  {
    List<Widget> widgets = new List<Widget>();

    widgets.add(Row
    (
      children : <Widget>
      [
        Icon(Icons.info_outline, color: Colors.black),
        SizedBox(width: 10),
        Text('상가동호 안내', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium', fontWeight: FontWeight.w500))
      ]
    ));

    final f = NumberFormat('#,###');
    _datas.forEach((map)
    {
      List<Widget> texts = new List<Widget>();

      var values = 
      [
        sprintf('· 상가명: %s', [map['HTY_NM']]),
        sprintf('· 상가호: %s', [map['HO_NM']]),
        sprintf('· 전용면적(㎡): %s', [map['DDO_AR']]),
        sprintf('· 분양면적(㎡): %s', [map['SIL_AR']]),
        sprintf('· 예정가격(원): %s', [map['XPC_PR'].isNotEmpty ? f.format(int.parse(map['XPC_PR'])) : ''])
      ];

      values.forEach((str)
      {
        texts.add(Align
        (
          alignment: Alignment.centerLeft,
          child: AutoSizeText(str, textAlign: TextAlign.left, maxLines: 1, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));
      });

      widgets.add(Padding
      (
        padding: EdgeInsets.only(bottom: 10),
        child: Card
        (
          color: Colors.lightBlue[200],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 2,
          child: Column(children: texts),
        )
      ));
    });

    return widgets;
  }
}