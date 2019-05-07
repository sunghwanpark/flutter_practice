import 'package:bunyang/MenuItem/Land/ProductDetail/ProductDetailView.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';
import 'package:intl/intl.dart';

class DetailPageData
{
  DetailPageData(this.ccrCnntSysDsCd, this.aisInfSn, this.bzdtCd, this.loldNo, this.panId);

  final String ccrCnntSysDsCd;
  final String aisInfSn;
  final String bzdtCd;
  final String loldNo;
  final String panId;
}

class SupplyLotOfLandInfoView extends StatelessWidget
{
  SupplyLotOfLandInfoView(bool isTender, List<Map<String, String>> data)
  {    
    landInfosCards.clear();

    String typeString = isTender ? "입찰" : "추첨";
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
    data.forEach((info) =>
    { 
      landInfosCards.add(Padding
      (
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: GestureDetector
        (
          onLongPress: () => onLongPressDetail(DetailPageData
          (
            info["CCR_CNNT_SYS_DS_CD"],
            info["AIS_INF_SN"],
            info["BZDT_CD"],
            info["LOLD_NO"],
            info["PAN_ID"]
          )),
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
                info["LND_US_DS_CD_NM"].isNotEmpty ? Align
                (
                  alignment: Alignment.centerLeft,
                  child: Text(sprintf('공급용도 : %s', [info["LND_US_DS_CD_NM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
                ) : SizedBox(),
                info["LND_US_DS_CD_NM"].isNotEmpty ? Align
                (
                  alignment: Alignment.centerLeft,
                  child: Text(sprintf('소재지 : %s', [info["LND_US_DS_CD_NM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
                ) : SizedBox(),
                info["LNO"].isNotEmpty ? Align
                ( 
                  alignment: Alignment.centerLeft,
                  child: Text(sprintf('지번 : %s', [info["LNO"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
                ) : SizedBox(),
                info["AR"].isNotEmpty ? Align
                (
                  alignment: Alignment.centerLeft,
                  child: Text(sprintf('면적 : %s', [info["AR"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
                ) : SizedBox(),
                info["SPL_AMT"].isNotEmpty && info["SPL_AMT"] != "0" ? Align
                (
                  alignment: Alignment.centerLeft,
                  child: Text(sprintf('공급가격(원) : %s', [f.format(int.parse(info["SPL_AMT"]))]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
                ) : SizedBox(),
                info["RQS_BAM"].isNotEmpty && info["LND_US_DS_CD_NM"] != "0" ? Align
                (
                  alignment: Alignment.centerLeft,
                  child: Text(sprintf('신청예약금(원) : %s', [f.format(int.parse(info["RQS_BAM"]))]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
                ) : SizedBox(),
                info["SPL_XPC_AMT"].isNotEmpty && info["LND_US_DS_CD_NM"] != "0" ? Align
                (
                  alignment: Alignment.centerLeft,
                  child: Text(sprintf('예정가격(원) : %s', [f.format(int.parse(info["SPL_XPC_AMT"]))]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
                ) : SizedBox(),
                info["BTN_NM"].isNotEmpty ? Align
                (
                  alignment: Alignment.centerLeft,
                  child: Text(sprintf('인터넷청약 : %s', [info["BTN_NM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
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