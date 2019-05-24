import 'package:bunyang/Map/MyGoogleMapView.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/IntallmentChangeSale/ChargeSupplyInfoDetailView.dart';
import 'package:bunyang/Secret/URL.dart';
import 'package:bunyang/Util/HighlightImageView.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

class ChargeSupplyInfo extends StatefulWidget
{
  ChargeSupplyInfo(this._defaultData, this._detailData, this._imageData);

  final List<Map<String, String>> _defaultData;
  final List<List<Map<String, String>>> _detailData;
  final List<List<Map<String, String>>> _imageData;

  @override
  ChargeSupplyInfoView createState() => ChargeSupplyInfoView();
}

class ChargeSupplyInfoView extends State<ChargeSupplyInfo>
{
  ChargeSupplyInfoView();

  List<List<bool>> _imageLoadingState = new List<List<bool>>();

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

    _imageLoadingState.clear();
    for(int i = 0; i < widget._defaultData.length; i++)
    {
      _imageLoadingState.add(List<bool>());

      var _default = widget._defaultData[i];
      var _detail = widget._detailData[i];
      var _image = widget._imageData[i];

      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('%d. %s', [i + 1, _default["LCC_NT_NM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium', fontWeight: FontWeight.w900, decoration: TextDecoration.underline))
      ));

      widgets.add(MyGoogleMap
      (
        '소재지',
        sprintf('%s %s', [_default['LGDN_ADR'], _default['LGDN_DTL_ADR']])
      ));

      if(_default["DDO_AR"].isNotEmpty)
      {
        widgets.add(Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('전용면적(㎡): %s', [_default["DDO_AR"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));
      }

      if(_default["HSH_CNT"].isNotEmpty)
      {
        widgets.add(Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('총 세대수: %s', [_default["HSH_CNT"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));
      }

      if(_default["HTN_FMLA_DESC"].isNotEmpty)
      {
        widgets.add(Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('난방방식: %s', [_default["HTN_FMLA_DESC"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));
      }

      if(_default["MVIN_XPC_YM"].isNotEmpty)
      {
        widgets.add(Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('입주예정월: %s', [_default["MVIN_XPC_YM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));
      }
      
      if(_image != null)
      {
        _imageLoadingState[i].clear();
        for(int j = 0; j < _image.length; j++)
        {
          var img = _image[j];
          _imageLoadingState[i].add(false);
          String urlSerial = img["CMN_AHFL_SN"];
          var networkImage = Image.network("$imageURL$urlSerial");
          networkImage.image.resolve(new ImageConfiguration()).addListener((_, __) 
          {
            if (mounted) 
            {
              setState(() {
                _imageLoadingState[i][j] = true;
              });
            }
          });

          widgets.add(Align
          (
            alignment: Alignment.centerLeft,
            child: Text(sprintf("· %s", [img["LS_SPL_INF_UPL_FL_DS_CD_NM"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500, fontFamily: 'TmonTium'))
          ));

          widgets.add(_imageLoadingState[i][j] ? InkWell
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

      if(_detail != null)
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
        for(int j = 0; j < _detail.length; j++)
        {
          var detail = _detail[j];

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
        child: Text(_default['SPL_INF_GUD_FCTS'].isNotEmpty && _default['PC_PYM_GUD_FCTS'].isNotEmpty ?
          sprintf('%s\n\r%s', [_default['SPL_INF_GUD_FCTS'], _default['PC_PYM_GUD_FCTS']])
          : sprintf('%s%s', [_default['SPL_INF_GUD_FCTS'], _default['PC_PYM_GUD_FCTS']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }

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