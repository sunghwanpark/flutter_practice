import 'package:bunyang/Abstract/AbstractContentsView.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';

class PlanView extends AbstractContentsView
{
  PlanView(this._datas);

  final List<Map<String, String>> _datas;

  @override
  List<Widget> getContents(BuildContext context)
  {
    List<Widget> widgets = List<Widget>();

    widgets.add(
      Row
      (
        children : <Widget>
        [
          Icon(Icons.date_range, color: Colors.black),
          SizedBox(width: 10),
          Text('수용인구 및 주택계획', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium'))
        ]
      ));

    final f = NumberFormat("#,###");
    _datas.forEach((map) => 
    {
      widgets.add(Padding
      (
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Container
        (
          decoration: ShapeDecoration
          (
            color: Colors.indigo[100],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            shadows: 
            [
              BoxShadow
              (
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 2.0,
                offset: Offset(5.0, 5.0),
              )
            ],
          ),
          child: Column
          (
            children: <Widget>
            [
              map["HS_TP_CD_NM"].isNotEmpty ? Align
              (
                alignment: Alignment.centerLeft,
                child: Text(sprintf('주택유형 : %s', [map["HS_TP_CD_NM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
              ) : SizedBox(),
              map["AR"].isNotEmpty ? Align
              (
                alignment: Alignment.centerLeft,
                child: Text(sprintf('면적(㎡) : %s', [f.format(double.parse(map["AR"]))]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
              ) : SizedBox(),
              map["AGR_HSH_CNT"].isNotEmpty ? Align
              (
                alignment: Alignment.centerLeft,
                child: Text(sprintf('수용세대(호) : %s', [f.format(int.parse(map["AGR_HSH_CNT"]))]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
              ) : SizedBox(),
              map["AGR_POP_CNT"].isNotEmpty ? Align
              (
                alignment: Alignment.centerLeft,
                child: Text(sprintf('수용인구(인) : %s', [f.format(int.parse(map["AGR_POP_CNT"]))]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
              ) : SizedBox(),
            ]
          )
        )
      )
      )});
    
    return widgets;
  }
}