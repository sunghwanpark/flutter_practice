import 'package:bunyang/Abstract/AbstractContentsView.dart';
import 'package:flutter/material.dart';

class LeaseMoreInfoView extends AbstractContentsView
{
  LeaseMoreInfoView(this._defaultDatas);

  final Map<String, List<Map<String, String>>> _defaultDatas;

  @override
  List<Widget> getContents(BuildContext context)
  {
    List<Widget> widgets = List<Widget>();

    if(_defaultDatas['dsLsPanDtl'].first['LSTR_CTS'].isNotEmpty)
    {
      widgets.add(Row
      (
        children : <Widget>
        [
          Icon(Icons.date_range, color: Colors.black),
          SizedBox(width: 10),
          Text('임대기간', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 27, fontFamily: 'TmonTium', fontWeight: FontWeight.w500))
        ]
      ));

      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(_defaultDatas['dsLsPanDtl'].first["LSTR_CTS"], textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));

      widgets.add(SizedBox(height: 10));
    }

    if(_defaultDatas['dsLsPanDtl'].first['LSC_CTS'].isNotEmpty)
    {
      widgets.add(Row
      (
        children : <Widget>
        [
          Icon(Icons.announcement, color: Colors.black),
          SizedBox(width: 10),
          Text('임대조건', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 27, fontFamily: 'TmonTium', fontWeight: FontWeight.w500))
        ]
      ));

      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(_defaultDatas['dsLsPanDtl'].first["LSC_CTS"], textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));

      widgets.add(SizedBox(height: 10));
    }

    if(_defaultDatas['dsLsPanDtl'].first['SPPT_LMT_AMT_CTS'].isNotEmpty)
    {
      widgets.add(Row
      (
        children : <Widget>
        [
          Icon(Icons.monetization_on, color: Colors.black),
          SizedBox(width: 10),
          Text('지원한도액', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 27, fontFamily: 'TmonTium', fontWeight: FontWeight.w500))
        ]
      ));

      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(_defaultDatas['dsLsPanDtl'].first["SPPT_LMT_AMT_CTS"], textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));

      widgets.add(SizedBox(height: 10));
    }

    widgets.add(Row
    (
      children : <Widget>
      [
        Icon(Icons.assignment_late, color: Colors.black),
        SizedBox(width: 10),
        Text('신청자격', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 27, fontFamily: 'TmonTium', fontWeight: FontWeight.w500))
      ]
    ));

    for(int i = 0; i < _defaultDatas['dsLsPanEtc'].length; i++)
    {
      var etcData = _defaultDatas['dsLsPanEtc'][i];
      
      String type = etcData["PAN_ETC_INF_CD_NM"];
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text('· $type', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 23, fontFamily: 'TmonTium', fontWeight: FontWeight.w700))
      ));

      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(etcData["ETC_CTS"], textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }

    return widgets;
  }
}