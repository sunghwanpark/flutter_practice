import 'package:bunyang/Map/MyGoogleMapView.dart';
import 'package:bunyang/Secret/URL.dart';
import 'package:bunyang/Util/HighlightImageView.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sprintf/sprintf.dart';

class InstallmentHouseInquiryInfo extends StatefulWidget
{
  InstallmentHouseInquiryInfo(this._datas, this._imageDatas);

  final Map<String, String> _datas;
  final List<Map<String, String>> _imageDatas;

  @override
  InstallmentHouseInquiryInfoView createState() => InstallmentHouseInquiryInfoView();
}

class InstallmentHouseInquiryInfoView extends State<InstallmentHouseInquiryInfo>
{
  List<bool> _imageLoadingState = new List<bool>();

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
      sprintf('· 사업지구명 : %s', [widget._datas['BZDT_NM']]),
      sprintf('· 블록 : %s', [widget._datas['BNM']]),
      sprintf('· 상태 : %s', [widget._datas['BZDT_SS']]),
      sprintf('· 문의처 : %s', [widget._datas['IQY_TLNO']]),
      sprintf('· 전용면적(㎡) : %s', [widget._datas['RSDN_DDO_AR']]),
      sprintf('· 세대수 : %s', [widget._datas['HSH_CNT']]),
      sprintf('· 난방방식 : %s', [widget._datas['HTN_FMLA_DS_CD_NM']]),
      sprintf('· 입주예정월 : %s', [getDateFormatkr(widget._datas['MVIN_XPC_YM'])]),
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
      sprintf('%s %s', [widget._datas['LCT_ARA_ADR'], widget._datas['LCT_ARA_DTL_ADR']]),
      LatLng(double.parse(widget._datas["LAT"]), double.parse(widget._datas["LTD"]))
    ));

    if(widget._imageDatas.length > 0)
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

      _imageLoadingState.clear();
      for(int i = 0; i < widget._imageDatas.length; i++)
      {
        var img = widget._imageDatas[i];
        _imageLoadingState.add(false);

        String urlSerial = img["CMN_AHFL_SN"];
        var networkImage = Image.network("$imageURL$urlSerial");
        networkImage.image.resolve(new ImageConfiguration()).addListener((_, __) 
        {
          if (mounted) 
          {
            setState(() {
              _imageLoadingState[i] = true;
            });
          }
        });

        widgets.add(Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf("· %s", [img["SL_PAN_AHFL_DS_CD_NM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500, fontFamily: 'TmonTium'))
        ));

        widgets.add(_imageLoadingState[i] ? InkWell
        (
          child: Hero
          (
            tag: urlSerial,
            child: networkImage
          ),
          onTap: () => Navigator.push
          (
            context,
            MaterialPageRoute(builder: (context) => HighlightImageView(urlSerial, networkImage))
          )
        ) : CircularProgressIndicator(backgroundColor: Colors.black));
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