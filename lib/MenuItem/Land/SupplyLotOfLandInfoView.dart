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
      landInfosCards.add(GestureDetector
      (
        child: Container
        (
          decoration: ShapeDecoration
          (
            color: Colors.lightGreen[100],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
          ),
          child: Column
          (
            children: <Widget>
            [
              info.supplyPurpose.isNotEmpty ? Align
              (
                alignment: Alignment.centerLeft,
                child: Text(sprintf('공급용도 : %s', [info.supplyPurpose]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
              ) : SizedBox(),
              info.locate.isNotEmpty ? Align
              (
                alignment: Alignment.centerLeft,
                child: Text(sprintf('소재지 : %s', [info.locate]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
              ) : SizedBox(),
              Align
              (
                alignment: Alignment.centerLeft,
                child: Text(sprintf('지번 : %s', [info.number]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
              ),
              Align
              (
                alignment: Alignment.centerLeft,
                child: Text(sprintf('지번 : %s', [info.number]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
              )
            ],
          )
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