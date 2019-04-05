import 'package:bunyang/MenuItem/Land/LandPageModel.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

class SupplyLotOfLandInfoView extends StatelessWidget
{
  SupplyLotOfLandInfoView(List<SupplyLotOfLandInfo> infos)
  {
    landInfosCards.clear();
    landInfosCards.add(Row
    (
      children : <Widget>
      [
        Icon(Icons.stars, color: Colors.black),
        SizedBox(width: 10),
        Text('공급필지 정보(일정)', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium'))
      ]
    ));
      
    infos.forEach((info) =>
    {
      landInfosCards.add(Card
      (
        elevation: 2,
        shape: RoundedRectangleBorder
        (
          borderRadius: BorderRadius.all(Radius.circular(5)),
          side: BorderSide
          (
            color: Colors.grey,
            style: BorderStyle.solid
          )
        ),
        color: Colors.lightGreen[100],
        child: Column
        (
          children: <Widget>
          [
            Text(sprintf('공급용도 : %s', [info.supplyPurpose]), textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'TmonTium'))
          ],
        )
      ))
    });
  }

  final List<Widget> landInfosCards = new List<Widget>();

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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: landInfosCards
        ),
      )
    );
  }
}