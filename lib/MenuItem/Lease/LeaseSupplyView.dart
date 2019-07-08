import 'package:auto_size_text/auto_size_text.dart';
import 'package:bunyang/Map/MyGoogleMapView.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sprintf/sprintf.dart';

typedef void AddEtcContents(BuildContext context, List<Widget> widgets, Map<String, String> info);

class LeaseSupplyView extends StatelessWidget
{
  LeaseSupplyView(this._supplyInfoType, this._detailData, this._supplyInfos);
  
  final String _supplyInfoType;
  final Map<String, List<Map<String, String>>> _supplyInfos;
  final Map<String, String> _detailData;

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

    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text(sprintf('· 모집지역 : %s', [_detailData["ARAG_RCR_HSH_CTS"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
    ));

    widgets.add(SizedBox(height: 10));

    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text('· 모집세대', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 23, fontFamily: 'TmonTium', fontWeight: FontWeight.w700))
    ));

    if(_supplyInfos != null)
    {
      AddEtcContents addContentsFunction;
      List<Map<String, String>> infos;
      if(_supplyInfos.containsKey('dsLHtyList'))
      {
        infos = _supplyInfos['dsLHtyList'];
        addContentsFunction = _addLHtyListContents;
      }
      else if(_supplyInfos.containsKey('dsRRHtyList'))
      {
        infos = _supplyInfos['dsRRHtyList'];

        if(_supplyInfoType == 'P')
        {
          addContentsFunction = _addRRHtyListContentsP;

          widgets.add(Align
          (
            alignment: Alignment.centerLeft,
            child: Text('지도를 확인하시려면 카드를 길게 눌러주세요.', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: 'TmonTium', decoration: TextDecoration.underline))
          ));
        }
        else if(_supplyInfoType == 'R')
        {
          addContentsFunction = _addRRHtyListContentsR;
        }
      }
      else if(_supplyInfos.containsKey('dsRHtyList'))
      {
        infos = _supplyInfos['dsRHtyList'];
        addContentsFunction = _addRHtyListContents;
      }

      if(infos != null && addContentsFunction != null)
      {
        for(int i = 0; i < infos.length; i++)
        {
          var info = infos[i];
          addContentsFunction(context, widgets, info);
        }
      }
    }

    return widgets;
  }

  _addLHtyListContents(BuildContext context, List<Widget> widgets, Map<String, String> info)
  {
    List<Widget> texts = new List<Widget>();
    var values = 
    [
      sprintf(' 모집지역: %s', [info['SBD_LGO_NM']]),
      sprintf(' 주소: %s', [info['ADR']]),
      sprintf(' 호: %s', [info['HO_NO']]),
      sprintf(' 층수: %s', [info['VLD_VL_NM']]),
      sprintf(' 전용면적(㎡): %s', [info['DDO_AR']])
    ];

    values.forEach((str)
    {
      texts.add(Align
      (
        alignment: Alignment.centerLeft,
        child: AutoSizeText(str, textAlign: TextAlign.left, maxLines: 1, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    });

    widgets.add(Padding
    (
      padding: EdgeInsets.only(bottom: 10),
      child: Card
      (
        color: Colors.tealAccent[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2,
        child: Column(children: texts),
      )
    ));
  }

  _addRHtyListContents(BuildContext context, List<Widget> widgets, Map<String, String> info)
  {
    List<Widget> texts = new List<Widget>();
    var values = 
    [
      sprintf(' 지역: %s', [info['SBD_CNP_NM']]),
      sprintf(' 상세지역: %s', [info['LTR_UNT_NM']]),
      sprintf(' 주택유형: %s', [info['HTY_DS_NM']]),
      sprintf(' 공급호수: %s', [info['GNR_SPL_RMNO']]),
      sprintf(' 당첨자수: %s', [info['PZWR_CNT']]),
      sprintf(' 예비자수: %s', [info['CAL_QUP_CNT']])
    ];

    values.forEach((str)
    {
      texts.add(Align
      (
        alignment: Alignment.centerLeft,
        child: AutoSizeText(str, textAlign: TextAlign.left, maxLines: 1, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    });

    widgets.add(Padding
    (
      padding: EdgeInsets.only(bottom: 10),
      child: Card
      (
        color: Colors.tealAccent[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2,
        child: Column(children: texts),
      )
    ));
  }

  _addRRHtyListContentsR(BuildContext context, List<Widget> widgets, Map<String, String> info)
  {
    List<Widget> texts = new List<Widget>();
    var values = 
    [
      sprintf(' 시도: %s', [info['CNP_NM']]),
      sprintf(' 주택정보: %s', [info['SBD_LGO_ADR']]),
      sprintf(' 주택유형: %s', [info['HTY_DS_NM']]),
      sprintf(' 모집인원: %s', [info['QUP_CNT']])
    ];

    values.forEach((str)
    {
      texts.add(Align
      (
        alignment: Alignment.centerLeft,
        child: AutoSizeText(str, textAlign: TextAlign.left, maxLines: 1, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    });

    widgets.add(Padding
    (
      padding: EdgeInsets.only(bottom: 10),
      child: Card
      (
        color: Colors.tealAccent[200],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2,
        child: Column(children: texts),
      )
    ));
  }

  _addRRHtyListContentsP(BuildContext context, List<Widget> widgets, Map<String, String> info)
  {
    List<Widget> texts = new List<Widget>();
    var values = 
    [
      sprintf(' 지자체명: %s', [info['SBD_LGO_NM']]),
      sprintf(' 주택정보: %s', [info['SBD_LGO_ADR']]),
      sprintf(' 주택유형: %s', [info['HTY_DS_NM']]),
      sprintf(' 공급호수: %s', [info['GNR_SPL_RMNO']]),
      sprintf(' 모집인원: %s', [info['QUP_CNT']]),
      sprintf(' 신청건수: %s', [info['RQS_CNT']])
    ];

    values.forEach((str)
    {
      texts.add(Align
      (
        alignment: Alignment.centerLeft,
        child: AutoSizeText(str, textAlign: TextAlign.left, maxLines: 1, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    });

    widgets.add(Padding
    (
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: GestureDetector
      (
        onLongPress: () => showDialog
        (
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context)
          {
            return AlertDialog
            (
              title: Center(child: Text('지도', textAlign: TextAlign.left, style: TextStyle(color: Colors.deepPurpleAccent[800], fontWeight: FontWeight.w600, fontSize: 30, fontFamily: 'TmonTium'))),
              shape: RoundedRectangleBorder
              (
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(style: BorderStyle.solid, color: Colors.black.withOpacity(0.2))
              ),
              backgroundColor: Colors.white,
              elevation: 0.2,
              contentPadding: EdgeInsets.all(0),
              content: MyGoogleMapWidget(LatLng(double.parse(info['COA_CODT_XXS']), double.parse(info['COA_CODT_YXS']))),
              actions: <Widget>
              [
                FlatButton
                (
                  child: myText('확인'),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            );
          }
        ),
        child: Container
        (
          decoration: ShapeDecoration
          (
            color: Colors.indigo[200],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
          ),
          child: Column
          (
            children: texts
          )
        )
      )
    ));
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