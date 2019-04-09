import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';
import 'package:bunyang/MenuItem/Land/LandPageModel.dart';

class SupplyDateView extends StatelessWidget
{
  SupplyDateView(PageState pageState, SupplyDate supplyDate)
  {
    widgets.clear();
    
    bool isDraw = (pageState.isLtr || pageState.isCtp || pageState.isHndcLtr) && !pageState.isPvtc;
    bool isTender = pageState.isBid && !pageState.isPvtc;

    String typeString = "";
    if(isDraw)
      typeString = "추첨";
    if(isTender)
      typeString = "입찰";

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

    if(supplyDate.rankDate.length > 1)
    {
      supplyDate.rankDate
        .forEach((data) =>
        {
          widgets.add
          (
            Card
            (
              color: Colors.lightBlueAccent,
              child: Column
              (
                children: <Widget>
                [
                  Align
                  (
                    alignment: Alignment.center,
                    child: Text(sprintf('%s 순위', [data.rank]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 22, fontFamily: 'TmonTium', fontWeight: FontWeight.w600))
                  ),
                  Align
                  (
                    alignment: Alignment.centerLeft,
                    child: Text(sprintf('신청일시 : %s', [supplyDate.rankDate.first.applyDate]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
                  ),
                  Align
                  (
                    alignment: Alignment.centerLeft,
                    child: Text(sprintf('신청예약금 입금마감일시 : %s', [supplyDate.rankDate.first.applyReserveDepositEndDate]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
                  )
                ],
              ),
            )
          )
        });
    }
    else
    {
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('신청일시 : %s', [supplyDate.rankDate.first.applyDate]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));

      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf(isDraw ? '신청예약금 입금마감일시 : %s' : "입찰보증금 납부마감일시 : %s",
           [supplyDate.rankDate.first.applyReserveDepositEndDate]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));
    }

    if(supplyDate.pickDate.isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf(isDraw ? '추첨일정 : %s' : '개찰일시 : %s',
           [supplyDate.pickDate]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    if(supplyDate.resultNoticeDate.isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf(isDraw ? '결과게시일정 : %s' : '개찰결과게시일시 : %s',
           [supplyDate.resultNoticeDate]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));

    if(supplyDate.contractDateStartAt.isNotEmpty && supplyDate.contractDateEndAt.isNotEmpty)
      widgets.add(
        Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('계약체결일정 : %s ~ %s', [supplyDate.contractDateStartAt, supplyDate.contractDateEndAt]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
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