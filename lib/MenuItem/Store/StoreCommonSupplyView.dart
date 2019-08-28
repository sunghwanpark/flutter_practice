import 'package:auto_size_text/auto_size_text.dart';
import 'package:bunyang/Abstract/AbstractContentsView.dart';
import 'package:bunyang/MenuItem/Store/StoreCommonSupplyData.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';

class StoreCommonSupplyView extends AbstractContentsView
{
  StoreCommonSupplyView(this._supplyDatas);
  
  final StoreCommonSupplyData _supplyDatas;

  @override
  List<Widget> getContents(BuildContext context) 
  {
    List<Widget> widgets = new List<Widget>();

    widgets.add(Row
    (
      children : <Widget>
      [
        Icon(Icons.stars, color: Colors.black),
        SizedBox(width: 10),
        Text('공급정보', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 27, fontFamily: 'TmonTium', fontWeight: FontWeight.w500))
      ]
    ));

    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text('· 단지정보', textAlign: TextAlign.left, style: TextStyle(color: Colors.blue[500], fontSize: 22, fontFamily: 'TmonTium', fontWeight: FontWeight.w300))
    ));

    if(_supplyDatas.defaultData['SBD_INF_CTS'].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(_supplyDatas.defaultData['SBD_INF_CTS'], textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }

    widgets.add(SizedBox(height: 10));

    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text('· 입찰일정', textAlign: TextAlign.left, style: TextStyle(color: Colors.blue[500], fontSize: 22, fontFamily: 'TmonTium', fontWeight: FontWeight.w300))
    ));

    if(_supplyDatas.defaultData['MSH_XPC_CTS'].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(_supplyDatas.defaultData['MSH_XPC_CTS'], textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }

    widgets.add(SizedBox(height: 10));

    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text('· 상가동호안내', textAlign: TextAlign.left, style: TextStyle(color: Colors.blue[500], fontSize: 22, fontFamily: 'TmonTium', fontWeight: FontWeight.w300))
    ));

    var f = NumberFormat('#,###');
    _supplyDatas.supplyDatas.forEach((map)
    {
      List<Widget> cardTexts = List<Widget>();
      var texts = 
      [
        sprintf('· 호 : %s', [map['HO_NM']]),
        sprintf('· 층수 : %s', [map['FLR_NM']]),
        sprintf('· 공급용도 : %s', [map['SST_SPL_PP_NM']]),
        sprintf('· 전용면적(㎡) : %s', [map['DDO_AR']]),
        sprintf('· 분양면적(㎡) : %s', [map['SUM_AR']]),
        sprintf('· 임대보증금(원) : %s', [map['SUM_DPA_BLCE'].isNotEmpty ? f.format(int.parse(map['SUM_DPA_BLCE'])) : 0]),
        sprintf('· 월임대료(원) : %s', [map['MM_RFE'].isNotEmpty ? f.format(int.parse(map['MM_RFE'])) : 0]),
        sprintf('· 관리비선수금(원) : %s', [map['ADM_XPS_ADRC_AMT'].isNotEmpty ? f.format(int.parse(map['ADM_XPS_ADRC_AMT'])) : 0]),
      ];

      texts.forEach((str)
      {
        cardTexts.add(Align
        (
          alignment: Alignment.centerLeft,
          child: AutoSizeText(str, maxLines: 1, textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium', fontWeight: FontWeight.w300))
        ));
      });

      widgets.add(Padding
      (
        padding: EdgeInsets.only(bottom: 10),
        child: Card
        (
          color: Colors.deepOrange[200],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 2,
          child: Column(children: cardTexts),
        )
      ));
    });

    return widgets;
  }
}