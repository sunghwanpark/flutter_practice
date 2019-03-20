import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';
import 'package:bunyang/MenuItem/Land/LandPageModel.dart';

class SupplyDateView extends StatelessWidget
{
  SupplyDateView(this._supplyDate);

  final SupplyDate _supplyDate;

  @override
  Widget build(BuildContext context)
  {
    List<Widget> widgets = new List<Widget>();
    widgets.add(
      Row
      (
        children : <Widget>
        [
          Icon(Icons.stars, color: Colors.white),
          SizedBox(width: 10),
          Text('공급일정(추첨)', textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'TmonTium'))
        ]
      ));
      
    if(_supplyDate.applyDate.isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('신청일시 : %s', [_supplyDate.applyDate]), textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    if(_supplyDate.applyReserveDepositEndDate.isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('신청예약금 입금마감일시 : %s', [_supplyDate.applyReserveDepositEndDate]), textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    if(_supplyDate.pickDate.isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('추첨일정 : %s', [_supplyDate.pickDate]), textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    if(_supplyDate.resultNoticeDate.isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('결과게시일정 : %s', [_supplyDate.resultNoticeDate]), textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    if(_supplyDate.contractDateStartAt.isNotEmpty && _supplyDate.contractDateEndAt.isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('계약체결일정 : %s ~ %s', [_supplyDate.contractDateStartAt, _supplyDate.contractDateEndAt]), textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    return Container
    (
      alignment: Alignment.center,
      height: 250,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration
      (
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withAlpha(50)
      ),
      child: Column
      (
        mainAxisAlignment: MainAxisAlignment.center,
        children: widgets
      )
    );
  }
}