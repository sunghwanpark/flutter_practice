import 'package:bunyang/MenuItem/Land/LandPageModel.dart';
import 'package:bunyang/MenuItem/Land/ProductDetail/ProductDetailView.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';
import 'package:intl/intl.dart';

class SupplyLotOfLandInfoView extends StatelessWidget
{
  SupplyLotOfLandInfoView(PageState pageState, List<SupplyLotOfLandInfo> infos)
  {    
    landInfosCards.clear();

    bool isDraw = (pageState.isLtr || pageState.isCtp || pageState.isHndcLtr) && !pageState.isPvtc;
    bool isTender = pageState.isBid && !pageState.isPvtc;

    String typeString = "";
    if(isDraw)
      typeString = "추첨";
    if(isTender)
      typeString = "입찰";

    landInfosCards.add(Row
    (
      children : <Widget>
      [
        Icon(Icons.stars, color: Colors.black),
        SizedBox(width: 10),
        Text(sprintf('공급필지 정보(%s)', [typeString]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium'))
      ]
    ));

    final f = NumberFormat("#,###");
    infos.forEach((info) =>
    { 
      landInfosCards.add(Padding
      (
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: GestureDetector
        (
          onLongPress: () => onLongPressDetail(info.detailPageData),
          child: Container
          (
            decoration: ShapeDecoration
            (
              color: Colors.lightGreen[100],
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
                info.number.isNotEmpty ? Align
                ( 
                  alignment: Alignment.centerLeft,
                  child: Text(sprintf('지번 : %s', [info.number]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
                ) : SizedBox(),
                info.extent.isNotEmpty ? Align
                (
                  alignment: Alignment.centerLeft,
                  child: Text(sprintf('면적 : %s', [info.extent]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
                ) : SizedBox(),
                info.supplyPrice.isNotEmpty && info.supplyPrice != "0" ? Align
                (
                  alignment: Alignment.centerLeft,
                  child: Text(sprintf('공급가격(원) : %s', [f.format(int.parse(info.supplyPrice))]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
                ) : SizedBox(),
                info.reservePrice.isNotEmpty && info.reservePrice != "0" ? Align
                (
                  alignment: Alignment.centerLeft,
                  child: Text(sprintf('신청예약금(원) : %s', [f.format(int.parse(info.reservePrice))]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
                ) : SizedBox(),
                info.duePrice.isNotEmpty && info.duePrice != "0" ? Align
                (
                  alignment: Alignment.centerLeft,
                  child: Text(sprintf('예정가격(원) : %s', [f.format(int.parse(info.duePrice))]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
                ) : SizedBox(),
                info.state.isNotEmpty ? Align
                (
                  alignment: Alignment.centerLeft,
                  child: Text(sprintf('인터넷청약 : %s', [info.state]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
                ) : SizedBox()
              ],
            )
          )
        )
      )
    )});
  }

  final List<Widget> landInfosCards = new List<Widget>();

  BuildContext _context;

  void onLongPressDetail(DetailPageData requestDetailData)
  {
    Navigator.push
    (
      _context,
      MaterialPageRoute
      (
        builder: (context) => ProductDetail(requestDetailData)
      )
    );
  }

  @override
  Widget build(BuildContext context)
  {
    _context = context;
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