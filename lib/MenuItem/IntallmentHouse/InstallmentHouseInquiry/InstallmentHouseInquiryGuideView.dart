import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';

class InstallmentHouseInquiryGuideView extends StatelessWidget
{
  const InstallmentHouseInquiryGuideView(this._datas);

  final List<Map<String, String>> _datas;

  List<Widget>_getContents() 
  {
    List<Widget> widgets = new List<Widget>();

    widgets.add(Row
    (
      children : <Widget>
      [
        Icon(Icons.info_outline, color: Colors.black),
        SizedBox(width: 10),
        Text('주택형 안내', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium', fontWeight: FontWeight.w500))
      ]
    ));

    final f = NumberFormat('#,###');
    _datas.forEach((map)
    {
      List<Widget> texts = new List<Widget>();

      var values = 
      [
        sprintf('· 주택형안내: %s', [map['HTY_NM']]),
        sprintf('· 전용면적(㎡): %s', [map['RSDN_DDO_AR']]),
        sprintf('· 세대수: %s', [map['TOT_HSH_CNT']]),
        sprintf('· 수의계약대상 세대수: %s', [map['PVTC_TRG_HSH_CNT']]),
        sprintf('· 분양가격(원): %s', [map['SIL_AMT'].isNotEmpty ? f.format(int.parse(map['SIL_AMT'])) : ''])
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
          children: _getContents()
        ),
      )
    );
  }
}