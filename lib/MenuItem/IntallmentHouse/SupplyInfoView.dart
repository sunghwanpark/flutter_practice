import 'package:auto_size_text/auto_size_text.dart';
import 'package:bunyang/Map/MyGoogleMapView.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sprintf/sprintf.dart';

class SupplyInfoView extends StatelessWidget
{
  SupplyInfoView(this._defaultData, this._detailData, this._imageData);

  final Map<String, String> _defaultData;
  final List<Map<String, String>> _detailData;
  final List<Map<String, String>> _imageData;

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
          children: <Widget>
          [
            Row
            (
              children : <Widget>
              [
                Icon(Icons.stars, color: Colors.black),
                SizedBox(width: 10),
                Text('공급정보', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 27, fontFamily: 'TmonTium', fontWeight: FontWeight.w500))
              ]
            ),
            _defaultData["BZDT_NM"].isNotEmpty ? Align
            (
              alignment: Alignment.centerLeft,
              child: AutoSizeText
              (
                _defaultData["HC_BLK_CD_NM"].isNotEmpty ?
                sprintf("%s %s단지", [_defaultData["BZDT_NM"], _defaultData["HC_BLK_CD_NM"]]) 
                : _defaultData["BZDT_NM"],
                maxLines: 2,
                style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium'),
              )
            ) : SizedBox(),
            _defaultData["LAT"].isNotEmpty && _defaultData["LTD"].isNotEmpty ? 
            MyGoogleMapViewLatLtd
            (
              '소재지',
              sprintf('%s %s', [_defaultData['LCT_ARA_ADR'], _defaultData['LCT_ARA_DTL_ADR']]),
              LatLng(double.parse(_defaultData["LAT"]), double.parse(_defaultData["LTD"]))
            ) : MyGoogleMap('소재지', sprintf('%s %s', [_defaultData['LCT_ARA_ADR'], _defaultData['LCT_ARA_DTL_ADR']])),
          ]
        ),
      )
    );
  }
}