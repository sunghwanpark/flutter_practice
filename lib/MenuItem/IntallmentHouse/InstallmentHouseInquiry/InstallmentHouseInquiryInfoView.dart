import 'package:bunyang/Map/MyGoogleMapView.dart';
import 'package:bunyang/Util/NetworkImageWidget.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sprintf/sprintf.dart';

class InstallmentHouseInquiryInfoView extends StatelessWidget
{
  InstallmentHouseInquiryInfoView(this._datas, this._imageDatas);

  final Map<String, String> _datas;
  final List<Map<String, String>> _imageDatas;

  List<Widget> _getContents(BuildContext context)
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

    List<String> subjectTexts = 
    [
      sprintf('· 사업지구명 : %s', [_datas['BZDT_NM']]),
      sprintf('· 블록 : %s', [_datas['BNM']]),
      sprintf('· 상태 : %s', [_datas['BZDT_SS']]),
      sprintf('· 문의처 : %s', [_datas['IQY_TLNO']]),
      sprintf('· 전용면적(㎡) : %s', [_datas['RSDN_DDO_AR']]),
      sprintf('· 세대수 : %s', [_datas['HSH_CNT']]),
      sprintf('· 난방방식 : %s', [_datas['HTN_FMLA_DS_CD_NM']]),
      sprintf('· 입주예정월 : %s', [getDateFormatkr(_datas['MVIN_XPC_YM'])]),
    ];

    subjectTexts.forEach((str)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(str, textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    });

    widgets.add(MyGoogleMapViewLatLtd
    (
      '소재지',
      sprintf('%s %s', [_datas['LCT_ARA_ADR'], _datas['LCT_ARA_DTL_ADR']]),
      LatLng(double.parse(_datas["LAT"]), double.parse(_datas["LTD"]))
    ));

    if(_imageDatas.length > 0)
    {
      widgets.add(Row
      (
        children : <Widget>
        [
          Icon(Icons.image, color: Colors.black),
          SizedBox(width: 10),
          Text('단지 관련 이미지 정보', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium', fontWeight: FontWeight.w500))
        ]
      ));

      for(int i = 0; i < _imageDatas.length; i++)
      {
        var img = _imageDatas[i];

        String urlSerial = img["CMN_AHFL_SN"];
        widgets.add(Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf("· %s", [img["SL_PAN_AHFL_DS_CD_NM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500, fontFamily: 'TmonTium'))
        ));
        
        widgets.add(NetworkImageWidget(serialNum: urlSerial));
      }
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