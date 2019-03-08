import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

class SupplyDate extends StatelessWidget
{
  SupplyDate
  (
    {
      this.applyDate = '',
      this.applyReserveDepositEndDate = '',
      this.pickDate = '',
      this.resultNoticeDate = '',
      this.contractDateStartAt = '',
      this.contractDateEndAt = ''
    }
  );

  final String applyDate;
  final String applyReserveDepositEndDate;
  final String pickDate;
  final String resultNoticeDate;
  final String contractDateStartAt;
  final String contractDateEndAt;

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
      
    if(applyDate.isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('신청일시 : %s', [applyDate]), textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    if(applyReserveDepositEndDate.isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('신청예약금 입금마감일시 : %s', [applyReserveDepositEndDate]), textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    if(pickDate.isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('추첨일정 : %s', [pickDate]), textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    if(resultNoticeDate.isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('결과게시일정 : %s', [resultNoticeDate]), textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    if(contractDateStartAt.isNotEmpty && contractDateEndAt.isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('계약체결일정 : %s ~ %s', [contractDateStartAt, contractDateEndAt]), textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'TmonTium'))
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