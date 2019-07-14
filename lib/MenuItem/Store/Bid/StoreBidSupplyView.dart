import 'package:bunyang/MenuItem/Store/Bid/BidDetail/StoreBidInquiryView.dart';
import 'package:flutter/material.dart';

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

    widgets.add(RaisedButton.icon
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
        width: 100,
        child: Text('매물정보조회', maxLines: 1, textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      )
    ));

    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text('· 단지내 주택 정보', textAlign: TextAlign.left, style: TextStyle(color: Colors.blue[500], fontSize: 22, fontFamily: 'TmonTium', fontWeight: FontWeight.w300))
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