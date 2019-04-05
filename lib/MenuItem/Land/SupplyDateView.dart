import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';
import 'package:bunyang/MenuItem/Land/LandPageModel.dart';

class SupplyDateView extends StatelessWidget
{
  SupplyDateView(this._supplyDate)
  {
    widgets.clear();
    widgets.add(
      Row
      (
        children : <Widget>
        [
          Icon(Icons.date_range, color: Colors.black),
          SizedBox(width: 10),
          Text('공급일정(일정)', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium'))
        ]
      ));
      
    if(_supplyDate.applyDate.isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('신청일시 : %s', [_supplyDate.applyDate]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    if(_supplyDate.applyReserveDepositEndDate.isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('신청예약금 입금마감일시 : %s', [_supplyDate.applyReserveDepositEndDate]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    if(_supplyDate.pickDate.isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('추첨일정 : %s', [_supplyDate.pickDate]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    if(_supplyDate.resultNoticeDate.isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('결과게시일정 : %s', [_supplyDate.resultNoticeDate]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    if(_supplyDate.contractDateStartAt.isNotEmpty && _supplyDate.contractDateEndAt.isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('계약체결일정 : %s ~ %s', [_supplyDate.contractDateStartAt, _supplyDate.contractDateEndAt]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));
  }

  final SupplyDate _supplyDate;
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