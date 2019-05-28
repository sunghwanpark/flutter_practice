import 'package:bunyang/Map/MyGoogleMapView.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/IntallmentChangeSale/ChargeSupplyInfoDetailView.dart';
import 'package:bunyang/Util/NetworkImageWidget.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

class ChargeSupplyInfoView extends StatelessWidget
{
  ChargeSupplyInfoView(this._defaultData, this._detailData, this._imageData);

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

    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text(sprintf('%s', [_defaultData["LCC_NT_NM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium', fontWeight: FontWeight.w900, decoration: TextDecoration.underline))
    ));

    widgets.add(MyGoogleMap
    (
      '소재지',
      sprintf('%s %s', [_defaultData['LGDN_ADR'], _defaultData['LGDN_DTL_ADR']])
    ));

    if(_defaultData["DDO_AR"].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('전용면적(㎡): %s', [_defaultData["DDO_AR"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }

    if(_defaultData["HSH_CNT"].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('총 세대수: %s', [_defaultData["HSH_CNT"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }

    if(_defaultData["HTN_FMLA_DESC"].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('난방방식: %s', [_defaultData["HTN_FMLA_DESC"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }

    if(_defaultData["MVIN_XPC_YM"].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('입주예정월: %s', [_defaultData["MVIN_XPC_YM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }
    
    if(_imageData != null)
    {
      for(int j = 0; j < _imageData.length; j++)
      {
        var img = _imageData[j];
        String urlSerial = img["CMN_AHFL_SN"];

        widgets.add(Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf("· %s", [img["LS_SPL_INF_UPL_FL_DS_CD_NM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500, fontFamily: 'TmonTium'))
        ));

        widgets.add(NetworkImageWidget(serialNum: urlSerial));
      }
    }

    if(_detailData != null)
    {
      widgets.add(Row
      (
        children : <Widget>
        [
          Icon(Icons.check_circle, color: Colors.black),
          SizedBox(width: 10),
          Text('주택형 안내', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium', fontWeight: FontWeight.w500))
        ]
      ));

      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text('상세공급정보를 확인하시려면 카드를 길게 눌러주세요', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: 'TmonTium', decoration: TextDecoration.underline))
      ));

      List<Widget> cards = new List<Widget>();
      for(int j = 0; j < _detailData.length; j++)
      {
        var detail = _detailData[j];

        var values = 
        [
          sprintf('주택형: %s', [detail['HTY_NNA']]),
          sprintf('전용면적(㎡): %s', [detail['DDO_AR']]),
          sprintf('세대수: %s', [detail['HSH_CNT']]),
          sprintf('금화공급 세대수: %s', [detail['NOW_HSH_CNT'].isNotEmpty ? detail['NOW_HSH_CNT'] : '내용없음']),
          '평균분양가격(원): 공고문확인',
          sprintf('인터넷청약: %s', [detail['BTN_NM']])
        ];

        values.forEach((value)
        {
          cards.add(Padding
          (
            padding: EdgeInsets.only(left:10, right:10),
            child: Align
            (
              alignment: Alignment.centerLeft,
              child: Text(value, textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
            )
          ));
        });

        widgets.add(_setDetailCard(context, cards, detail));
      }        
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
      child: Text(_defaultData['SPL_INF_GUD_FCTS'].isNotEmpty && _defaultData['PC_PYM_GUD_FCTS'].isNotEmpty ?
        sprintf('%s\n\r%s', [_defaultData['SPL_INF_GUD_FCTS'], _defaultData['PC_PYM_GUD_FCTS']])
        : sprintf('%s%s', [_defaultData['SPL_INF_GUD_FCTS'], _defaultData['PC_PYM_GUD_FCTS']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
    ));

    return widgets;
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
            builder: (context) => ChargeSupplyInfoDetailView(contentsData)
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