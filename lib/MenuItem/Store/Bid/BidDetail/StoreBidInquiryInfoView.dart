import 'package:auto_size_text/auto_size_text.dart';
import 'package:bunyang/Abstract/AbstractContentsView.dart';
import 'package:bunyang/Map/MyGoogleMapView.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

class StoreBidInquiryInfoView extends AbstractContentsView
{
  StoreBidInquiryInfoView(this._datas);

  final Map<String, String> _datas;

  @override
  List<Widget> getContents(BuildContext context) 
  {
    List<Widget> widgets = new List<Widget>();

    widgets.add(Row
    (
      children : <Widget>
      [
        Icon(Icons.info_outline, color: Colors.black),
        SizedBox(width: 10),
        Text('단지 정보', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium', fontWeight: FontWeight.w500))
      ]
    ));

    if(_datas['CYB_MODH_URL'].isNotEmpty)
    {
      widgets.add(RaisedButton.icon
      (
        onPressed: () => launchURL(_datas['CYB_MODH_URL']),
        color: Colors.amber[300],
        icon: Icon(Icons.details),
        label: Container
        (
          width: 100,
          child: AutoSizeText('사이버모델하우스', maxLines: 1, textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        )
      ));
    }

    List<String> subjectTexts = 
    [
      sprintf('· 사업지구명 : %s', [_datas['BZDT_NM']]),
      sprintf('· 블록 : %s', [_datas['BNM']]),
      sprintf('· 상세유형 : %s', [_datas['AIS_TP_CD_NM']]),
      sprintf('· 상태 : %s', [_datas['BZDT_SS']]),
      sprintf('· 문의처 : %s', [_datas['IQY_TLNO'].isEmpty ? "1600-1004" : _datas['IQY_TLNO']]),
      sprintf('· 주택유형 : %s', [_datas['HSTP']]),
      sprintf('· 주택규모(㎡) : %s', [_datas['HTY_CD']]),
      sprintf('· 세대수 : %s', [_datas['HSH_CNT']]),
      sprintf('· 상가동수 : %s', [_datas['DNG_SN_CNT']]),
      sprintf('· 상가호수 : %s', [_datas['SST_ALL_RMNO']]),
      sprintf('· 분양시기 : %s', [_datas['SIL_DT']]),
      sprintf('· 입점시기 : %s', [getYearMonthFormat(_datas['MVIN_XPC_YM'])]),
    ];

    subjectTexts.forEach((str)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(str, textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    });

    widgets.add(MyGoogleMap
    (
      '소재지',
      sprintf('%s %s', [_datas['LCT_ARA_ADR'], _datas['LCT_ARA_DTL_ADR']]),
      titleSize: 20,
    ));
    
    return widgets;
  }
}