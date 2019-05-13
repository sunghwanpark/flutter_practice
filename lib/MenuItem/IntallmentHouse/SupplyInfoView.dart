import 'package:auto_size_text/auto_size_text.dart';
import 'package:bunyang/Map/MyGoogleMapView.dart';
import 'package:bunyang/Secret/URL.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sprintf/sprintf.dart';

class SupplyInfoView extends StatelessWidget
{
  SupplyInfoView(this._defaultData, this._detailData, this._imageData);

  final Map<String, String> _defaultData;
  final List<Map<String, String>> _detailData;
  final List<Map<String, String>> _imageData;

  List<Widget> _getContents(BuildContext context)
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

    if(_defaultData["BZDT_NM"].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: AutoSizeText
        (
          _defaultData["HC_BLK_CD_NM"].isNotEmpty ?
          sprintf("%s %s단지", [_defaultData["BZDT_NM"], _defaultData["HC_BLK_CD_NM"]]) : _defaultData["BZDT_NM"],
          maxLines: 2,
          style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium'),
        )
      ));
    }

    if(_defaultData["LAT"].isNotEmpty && _defaultData["LTD"].isNotEmpty)
    {
      widgets.add(MyGoogleMapViewLatLtd
      (
        '소재지',
        sprintf('%s %s', [_defaultData['LCT_ARA_ADR'], _defaultData['LCT_ARA_DTL_ADR']]),
        LatLng(double.parse(_defaultData["LAT"]), double.parse(_defaultData["LTD"]))
      ));
    }
    else 
    {
      widgets.add(MyGoogleMap('소재지', sprintf('%s %s', [_defaultData['LCT_ARA_ADR'], _defaultData['LCT_ARA_DTL_ADR']])));
    }

    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text(sprintf('· 적용면적(㎡) : %s ~ %s', [_defaultData["MIN_RSDN_DDO_AR"], _defaultData["MAX_RSDN_DDO_AR"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
    ));
    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text(sprintf('· 총 세대수 : %s', [_defaultData["SUM_TOT_HSH_CNT"].isEmpty ? "" : _defaultData["SUM_TOT_HSH_CNT"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
    ));
    
    if(_defaultData["HTN_FMLA_DS_CD_NM"].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('· 난방방식 : %s', [_defaultData["HTN_FMLA_DS_CD_NM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }
    
    if(_defaultData["MVIN_XPC_YM"].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('· 입주 예정월 : %s년 %s월', [_defaultData["MVIN_XPC_YM"].substring(0, 4), _defaultData["MVIN_XPC_YM"].substring(4, 6)]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }

    _imageData.forEach((map)
    {
      String urlSerial = map["CMN_AHFL_SN"];
      widgets.add(Image.network
      (
        "$imageURL$urlSerial",
        width: MediaQuery.of(context).size.width - 10,
        height: 300,
      ));
    });
    
    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text('단지 특장점', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w500, fontFamily: 'TmonTium'))
    ));

    if(_defaultData["TFFC_FCL_CTS"].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('· 교통여건 : %s', [_defaultData["TFFC_FCL_CTS"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }
     
    if(_defaultData["EDC_FCL_CTS"].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('· 교육환경 : %s', [_defaultData["EDC_FCL_CTS"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }

    if(_defaultData["CVN_FCL_CTS"].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('· 편의시설 : %s', [_defaultData["CVN_FCL_CTS"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }
    
    if(_defaultData["IDT_FCL_CTS"].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('· 부대시설 : %s', [_defaultData["IDT_FCL_CTS"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }

    return widgets;
  }

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
          children: _getContents(context)
        ),
      )
    );
  }
}