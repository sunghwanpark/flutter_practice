import 'package:flutter/material.dart';

class LeaseMoreInfoView extends StatelessWidget
{
  LeaseMoreInfoView(this._detailData, this._etcDatas);

  final Map<String, String> _detailData;
  final List<Map<String, String>> _etcDatas;

  List<Widget> _getContents(BuildContext context)
  {
    List<Widget> widgets = List<Widget>();

    if(_detailData['LSTR_CTS'].isNotEmpty)
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
        child: Text(_detailData["LSTR_CTS"], textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));

      widgets.add(SizedBox(height: 10));
    }

    if(_detailData['LSC_CTS'].isNotEmpty)
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
        child: Text(_detailData["LSC_CTS"], textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
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

    for(int i = 0; i < _etcDatas.length; i++)
    {
      var etcData = _etcDatas[i];
      
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