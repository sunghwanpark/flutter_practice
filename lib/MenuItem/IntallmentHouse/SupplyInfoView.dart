import 'package:auto_size_text/auto_size_text.dart';
import 'package:bunyang/Map/MyGoogleMapView.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/InstallmentHouseInquiry/InstallmentHouseInquiryView.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/IntallmentDetail/InstallmentSupplyInfoDetailView.dart';
import 'package:bunyang/Secret/URL.dart';
import 'package:bunyang/Util/HighlightImageView.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';

class SupplyInfo extends StatefulWidget
{
  SupplyInfo(this._uppAisTpCd, this._defaultData, this._publicInstallment, this._publicLease, this._publicInstallmentLease, this._imageData);

  final String _uppAisTpCd;
  final Map<String, String> _defaultData;
  final List<Map<String, String>> _publicInstallment;
  final List<Map<String, String>> _publicLease;
  final List<Map<String, String>> _publicInstallmentLease;
  final List<Map<String, String>> _imageData;

  @override
  SupplyInfoView createState() => SupplyInfoView();
}

class SupplyInfoView extends State<SupplyInfo>
{
  SupplyInfoView();

  List<bool> _imageLoadingState = new List<bool>();

  @override
  void initState()
  {
    super.initState();
  }

  
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

    if(widget._defaultData["BZDT_NM"].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: AutoSizeText
        (
          widget._defaultData["HC_BLK_CD_NM"].isNotEmpty ?
          sprintf("%s %s단지", [widget._defaultData["BZDT_NM"], widget._defaultData["HC_BLK_CD_NM"]]) : widget._defaultData["BZDT_NM"],
          maxLines: 2,
          style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium'),
        )
      ));
    }

    widgets.add(Align
    (
      alignment: Alignment.center,
      child: Row
      (
        children: <Widget>
        [
          widget._defaultData['CYB_MODH_URL'].isNotEmpty ? RaisedButton.icon
          (
            onPressed: () => launchURL(widget._defaultData['CYB_MODH_URL']),
            color: Colors.amber[300],
            icon: Icon(Icons.details),
            label: Text('사이버모델하우스', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium')),
          ) : SizedBox(),
          widget._defaultData['CYB_MODH_URL'].isNotEmpty ? SizedBox(width: 10) : SizedBox(),
          RaisedButton.icon
          (
            onPressed: () => Navigator.push
            (
              context,
              MaterialPageRoute(builder: (context) => InstallmentHouseInquiry(widget._defaultData, widget._uppAisTpCd))
            ),
            color: Colors.amber[300],
            icon: Icon(Icons.details),
            label: Text('매물정보조회', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium')),
          )
        ],
      )
    ));

    if(widget._defaultData["LAT"].isNotEmpty && widget._defaultData["LTD"].isNotEmpty)
    {
      widgets.add(MyGoogleMapViewLatLtd
      (
        '소재지',
        sprintf('%s %s', [widget._defaultData['LCT_ARA_ADR'], widget._defaultData['LCT_ARA_DTL_ADR']]),
        LatLng(double.parse(widget._defaultData["LAT"]), double.parse(widget._defaultData["LTD"]))
      ));
    }
    else 
    {
      widgets.add(MyGoogleMap('소재지', sprintf('%s %s', [widget._defaultData['LCT_ARA_ADR'], widget._defaultData['LCT_ARA_DTL_ADR']])));
    }

    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text(sprintf('· 적용면적(㎡) : %s ~ %s', [widget._defaultData["MIN_RSDN_DDO_AR"], widget._defaultData["MAX_RSDN_DDO_AR"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
    ));
    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text(sprintf('· 총 세대수 : %s', [widget._defaultData["SUM_TOT_HSH_CNT"].isEmpty ? "" : widget._defaultData["SUM_TOT_HSH_CNT"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
    ));
    
    if(widget._defaultData["HTN_FMLA_DS_CD_NM"].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('· 난방방식 : %s', [widget._defaultData["HTN_FMLA_DS_CD_NM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }
    
    if(widget._defaultData["MVIN_XPC_YM"].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('· 입주 예정월 : %s년 %s월', [widget._defaultData["MVIN_XPC_YM"].substring(0, 4), widget._defaultData["MVIN_XPC_YM"].substring(4, 6)]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }

    _imageLoadingState.clear();
    for(int i = 0; i < widget._imageData.length; i++)
    {
      var map = widget._imageData[i];
      _imageLoadingState.add(false);
      String urlSerial = map["CMN_AHFL_SN"];
      var _image = Image.network("$imageURL$urlSerial");
      _image.image.resolve(new ImageConfiguration()).addListener((_, __) 
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
        child: Text(sprintf("· %s", [map["SL_PAN_AHFL_DS_CD_NM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500, fontFamily: 'TmonTium'))
      ));

      widgets.add(_imageLoadingState[i] ? InkWell
      (
        child: Hero
        (
          tag: urlSerial,
          child: _image
        ),
        onTap: () => Navigator.push
        (
          context,
          MaterialPageRoute(builder: (context) => HighlightImageView(urlSerial, _image))
        )
      ) : CircularProgressIndicator(backgroundColor: Colors.black));
    }
    
    widgets.add(Row
    (
      children : <Widget>
      [
        Icon(Icons.check_circle, color: Colors.black),
        SizedBox(width: 10),
        Text('단지 특장점', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium', fontWeight: FontWeight.w500))
      ]
    ));

    if(widget._defaultData["TFFC_FCL_CTS"].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('· 교통여건 : %s', [widget._defaultData["TFFC_FCL_CTS"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }
     
    if(widget._defaultData["EDC_FCL_CTS"].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('· 교육환경 : %s', [widget._defaultData["EDC_FCL_CTS"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }

    if(widget._defaultData["CVN_FCL_CTS"].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('· 편의시설 : %s', [widget._defaultData["CVN_FCL_CTS"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }
    
    if(widget._defaultData["IDT_FCL_CTS"].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('· 부대시설 : %s', [widget._defaultData["IDT_FCL_CTS"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }
    
    final f = NumberFormat("#,###");
    if(widget._publicInstallment.length > 0) // 공공분양
    {
      widgets.add(_setSubject('공공분양'));

      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text('상세공급정보를 확인하시려면 카드를 길게 눌러주세요', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: 'TmonTium', decoration: TextDecoration.underline))
      ));

      widget._publicInstallment.forEach((map)
      {
        var values = 
        [
          sprintf('주택형: %s', [map['HTY_NM']]),
          sprintf('전용면적(㎡): %s', [map['RSDN_DDO_AR']]),
          sprintf('세대수: %s', [map['TOT_HSH_CNT']]),
          sprintf('금화공급 세대수: %s', [map['SIL_HSH_CNT']]),
          sprintf('평균분양가격(원): %s', [f.format(int.parse(map['SIL_AMT']))]),
          sprintf('인터넷청약: %s', [map['BTN_NM']])
        ];

        List<Widget> contents = new List<Widget>(); 
        values.forEach((value)
        {
          contents.add(Padding
          (
            padding: EdgeInsets.only(left:10, right:10),
            child: Align
            (
              alignment: Alignment.centerLeft,
              child: Text(value, textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
            )
          ));
        });

        widgets.add(_setDetailCard(context, contents, map));
      });
    }
    else if(widget._publicLease.length > 0) // 공공임대
    {
      widgets.add(_setSubject('공공임대'));

      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text('상세공급정보를 확인하시려면 카드를 길게 눌러주세요', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: 'TmonTium', decoration: TextDecoration.underline))
      ));

      widget._publicInstallment.forEach((map)
      {
        var values = 
        [
          sprintf('주택형: %s', [map['HTY_NM']]),
          sprintf('전용면적(㎡): %s', [map['RSDN_DDO_AR']]),
          sprintf('세대수: %s', [map['TOT_HSH_CNT']]),
          sprintf('금화공급 세대수: %s', [map['SIL_HSH_CNT']]),
          sprintf('임대보증금(원): %s', [f.format(int.parse(map['LS_GMY']))]),
          sprintf('월임대료(원): %s', [f.format(int.parse(map['MM_RFE']))]),
          sprintf('인터넷청약: %s', [map['BTN_NM']])
        ];

        List<Widget> contents = new List<Widget>(); 
        values.forEach((value)
        {
          contents.add(Padding
          (
            padding: EdgeInsets.only(left:10, right:10),
            child: Align
            (
              alignment: Alignment.centerLeft,
              child: Text(value, textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
            )
          ));
        });

        widgets.add(_setDetailCard(context, contents, map));
      });
    }
    else if(widget._publicInstallmentLease.length > 0) // 분납임대
    {
      widgets.add(_setSubject('분납임대'));

      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text('상세공급정보를 확인하시려면 카드를 길게 눌러주세요', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: 'TmonTium', decoration: TextDecoration.underline))
      ));

      widget._publicInstallment.forEach((map)
      {
        var values = 
        [
          sprintf('주택형: %s', [map['HTY_NM']]),
          sprintf('전용면적(㎡): %s', [map['DDO_AR']]),
          sprintf('세대수: %s', [map['TOT_HSH_CNT']]),
          sprintf('금화공급 세대수: %s', [map['SIL_HSH_CNT']]),
          sprintf('초기분납금(원): %s', [f.format(int.parse(map['ELY_DSU_AMT']))]),
          sprintf('월임대료(원): %s', [f.format(int.parse(map['MM_RFE']))]),
          sprintf('인터넷청약: %s', [map['BTN_NM']])
        ];

        List<Widget> contents = new List<Widget>(); 
        values.forEach((value)
        {
          contents.add(Padding
          (
            padding: EdgeInsets.only(left:10, right:10),
            child: Align
            (
              alignment: Alignment.centerLeft,
              child: Text(value, textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
            )
          ));
        });

        widgets.add(_setDetailCard(context, contents, map));
      });
    }

    widgets.add(Row
    (
      children : <Widget>
      [
        Icon(Icons.info, color: Colors.red),
        SizedBox(width: 10),
        Text('안내사항', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium', fontWeight: FontWeight.w800))
      ]
    ));

    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text(widget._defaultData['SPL_INF_GUD_FCTS'], textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
    ));

    return widgets;
  }

  Row _setSubject(String subject)
  {
    return Row
    (
      children : <Widget>
      [
        Icon(Icons.check_circle, color: Colors.black),
        SizedBox(width: 10),
        Text('주택형 안내 ($subject)', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium', fontWeight: FontWeight.w500))
      ]
    );
  }

  Padding _setDetailCard(BuildContext context, List<Widget> addContents, Map<String, String> contentsData)
  {
    return Padding
    (
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: GestureDetector
      (
        onLongPress: () => Navigator.push
        (
          context,
          MaterialPageRoute
          (
            builder: (context) => InstallmentSupplyInfoDetail(contentsData)
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
            children: addContents
          )
        )
      )
    );
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