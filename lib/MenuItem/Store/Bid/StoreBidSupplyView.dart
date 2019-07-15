import 'package:bunyang/Map/MyGoogleMapView.dart';
import 'package:bunyang/MenuItem/Store/Bid/BidDetail/StoreBidInquiryView.dart';
import 'package:bunyang/MenuItem/Store/Bid/StoreBidImageView.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:bunyang/Util/WidgetInsideTabBarView.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

class StoreBidSupplyView extends StatelessWidget
{
  StoreBidSupplyView(this._defaultData, this._storeList, this._storeImageList, this._storeDetailList, this._uppAisTpCd);

  final Map<String, String> _defaultData;
  final List<Map<String, String>> _storeList;
  final Map<String, List<Map<String, String>>> _storeImageList;
  final List<Map<String, String>> _storeDetailList;

  final String _uppAisTpCd;

  List<Widget> _getContents(BuildContext context)
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