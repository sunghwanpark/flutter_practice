import 'package:auto_size_text/auto_size_text.dart';
import 'package:bunyang/Abstract/AbstractContentsView.dart';
import 'package:bunyang/Map/MyGoogleMapView.dart';
import 'package:bunyang/MenuItem/Store/Bid/BidDetail/StoreBidInquiryView.dart';
import 'package:bunyang/MenuItem/Store/Bid/BidSupplyDetail/StoreBidSupplyDetailView.dart';
import 'package:bunyang/MenuItem/Store/Bid/StoreBidImageView.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:bunyang/Util/WidgetInsideTabBarView.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';

class StoreBidSupplyView extends AbstractContentsView
{
  StoreBidSupplyView(this._defaultData, this._storeList, this._storeImageList, this._storeDetailList, this._uppAisTpCd);

  final Map<String, String> _defaultData;
  final List<Map<String, String>> _storeList;
  final Map<String, List<Map<String, String>>> _storeImageList;
  final List<Map<String, String>> _storeDetailList;

  final String _uppAisTpCd;

  @override
  List<Widget> getContents(BuildContext context)
  {
    List<Widget> widgets = List<Widget>();

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
      child: RaisedButton.icon
      (
        onPressed: () => Navigator.push
        (
          context,
          MaterialPageRoute(builder: (context) => StoreBidInquiry
          (
            {'CCR_CNNT_SYS_DS_CD' : _defaultData['CCR_CNNT_SYS_DS_CD'], 'AIS_INF_SN' : _defaultData['AIS_INF_SN'],
            'HC_BLK_CD' : _defaultData['HC_BLK_CD'], 'BZDT_CD' : _defaultData['BZDT_CD'], 'PREVIEW' : 'N'}
            , _uppAisTpCd)
          )
        ),
        color: Colors.amber[300],
        icon: Icon(Icons.details),
        label: Container
        (
          width: 120,
          child: Text('매물정보조회', maxLines: 1, textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        )
      )
    ));

    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text('· 단지내 주택 정보', textAlign: TextAlign.left, style: TextStyle(color: Colors.blue[500], fontSize: 22, fontFamily: 'TmonTium', fontWeight: FontWeight.w300))
    ));

    if(_defaultData['LCT_ARA_ADR'].isNotEmpty && _defaultData['LCT_ARA_DTL_ADR'].isNotEmpty)
    {
      widgets.add(MyGoogleMap('소재지', sprintf('%s %s', [_defaultData['LCT_ARA_ADR'], _defaultData['LCT_ARA_DTL_ADR']]), titleSize: 20));
    }

    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text(sprintf('공급면적(㎡) : %s', [_defaultData['SC_AR']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium', fontWeight: FontWeight.w300))
    ));
    
    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text(sprintf('총 세대수 : %s', [_defaultData['HSH_CNT']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium', fontWeight: FontWeight.w300))
    ));

    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text(sprintf('난방방식 : %s', [_defaultData['HTN_FMLA_DS_CD_NM']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium', fontWeight: FontWeight.w300))
    ));

    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text(sprintf('입주예정월: %s', [getYearMonthFormat(_defaultData['MVIN_XPC_YM'])]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium', fontWeight: FontWeight.w300))
    ));

    widgets.add(WidgetInsideTabBar
    (
      tabNames: _storeDetailList.map((map) => map['SST_NM']).toList(),
      contents: List<Widget>.generate(_storeDetailList.length, (index)
      {
        var detail = _storeDetailList[index];
        var dngSn = detail['DNG_SN'];
        var sbdNo = detail['SBD_NO'];

        var imageList = _storeImageList['$dngSn$sbdNo'];
        return StoreBidImageView(detail, imageList);
      })
    ));
    
    if(_storeList.length > 0)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text('· 상가동호안내', textAlign: TextAlign.left, style: TextStyle(color: Colors.blue[500], fontSize: 22, fontFamily: 'TmonTium', fontWeight: FontWeight.w300))
      ));

      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text('상세공급정보를 확인하시려면 카드를 길게 눌러주세요', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: 'TmonTium', decoration: TextDecoration.underline))
      ));

      var f = NumberFormat('#,###');
      for(int i = 0; i < _storeList.length; i++)
      {
        var storeData = _storeList[i];

        var texts =
        [
          sprintf('상가명 : %s', [storeData['SST_NM']]),
          sprintf('상가호 : %s', [storeData['HO_NM']]),
          sprintf('입점가능시기 : %s', [getYearMonthFormat(storeData['MSH_PSB_YM'])]),
          sprintf('층수 : %s', [storeData['OCNT']]),
          sprintf('전용면적(㎡) : %s', [storeData['DDO_AR']]),
          sprintf('분양면적(㎡) : %s', [storeData['SIL_AR']]),
          sprintf('예정가격(원) : %s', [storeData['XPC_PR'].isNotEmpty ? f.format(int.parse(storeData['XPC_PR'])) : ''])
        ];

        List<Widget> cardTextWidgets = List<Widget>();
        texts.forEach((text)
        {
          cardTextWidgets.add(Padding
          (
            padding: EdgeInsets.only(left:10, right:10),
            child: Align
            (
              alignment: Alignment.centerLeft,
              child: AutoSizeText(text, textAlign: TextAlign.left, maxLines: 1, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
            )
          ));
        });
        
        widgets.add(Padding
        (
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: GestureDetector
          (
            onLongPress: () => Navigator.push
            (
              context,
              MaterialPageRoute
              (
                builder: (context) => StoreBidSupplyDetailView
                (
                  {'PAN_ID' : storeData['PAN_ID'], 'CCR_CNNT_SYS_DS_CD' : storeData['CCR_CNNT_SYS_DS_CD'],
                  'SSDH_SL_ADM_NO' : storeData['SSDH_SL_ADM_NO'], 'BZDT_CD' : storeData['BZDT_CD'],
                  'HC_BLK_CD' : storeData['HC_BLK_CD'], 'DNG_SN' : storeData['DNG_SN']}
                )
              )
            ),
            child: Container
            (
              decoration: ShapeDecoration
              (
                color: Colors.indigo[200],
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
                children: cardTextWidgets
              )
            )
          )
        ));
      }
    }
    
    return widgets;
  }
}