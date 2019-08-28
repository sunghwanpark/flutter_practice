import 'package:bunyang/Abstract/AbstractContentsView.dart';
import 'package:flutter/material.dart';

class StoreCommonNotifyView extends AbstractContentsView
{
  StoreCommonNotifyView(this._data);

  final Map<String, String> _data;

  @override
  List<Widget> getContents(BuildContext context) 
  {
    return <Widget>
    [
      Align
      (
        alignment: Alignment.centerLeft,
        child: Text('· 신청자격', textAlign: TextAlign.left, style: TextStyle(color: Colors.blue[500], fontSize: 22, fontFamily: 'TmonTium', fontWeight: FontWeight.w300))
      ),
      Align
      (
        alignment: Alignment.centerLeft,
        child: Text(_data['RQS_QF_CTS'], textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium', fontWeight: FontWeight.w300))
      ),
      SizedBox(height: 10),
      Align
      (
        alignment: Alignment.centerLeft,
        child: Text('· 입점자 선정방법', textAlign: TextAlign.left, style: TextStyle(color: Colors.blue[500], fontSize: 22, fontFamily: 'TmonTium', fontWeight: FontWeight.w300))
      ),
      Align
      (
        alignment: Alignment.centerLeft,
        child: Text(_data['MSH_SLC_MD_CTS'], textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium', fontWeight: FontWeight.w300))
      ),
      SizedBox(height: 10),
      Align
      (
        alignment: Alignment.centerLeft,
        child: Text('· 신청시 구비서류', textAlign: TextAlign.left, style: TextStyle(color: Colors.blue[500], fontSize: 22, fontFamily: 'TmonTium', fontWeight: FontWeight.w300))
      ),
      Align
      (
        alignment: Alignment.centerLeft,
        child: Text(_data['RQS_PS_PPR_CTS'], textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium', fontWeight: FontWeight.w300))
      ),
      SizedBox(height: 10),
      Align
      (
        alignment: Alignment.centerLeft,
        child: Text('· 계약시 구비서류', textAlign: TextAlign.left, style: TextStyle(color: Colors.blue[500], fontSize: 22, fontFamily: 'TmonTium', fontWeight: FontWeight.w300))
      ),
      Align
      (
        alignment: Alignment.centerLeft,
        child: Text(_data['CTRT_PS_PPR_CTS'], textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium', fontWeight: FontWeight.w300))
      ),
      SizedBox(height: 10),
      Align
      (
        alignment: Alignment.centerLeft,
        child: Text('· 영업가능업종내용', textAlign: TextAlign.left, style: TextStyle(color: Colors.blue[500], fontSize: 22, fontFamily: 'TmonTium', fontWeight: FontWeight.w300))
      ),
      Align
      (
        alignment: Alignment.centerLeft,
        child: Text(_data['MBZ_PSB_BZTP_CTS'], textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium', fontWeight: FontWeight.w300))
      ),
      SizedBox(height: 10),
      Align
      (
        alignment: Alignment.centerLeft,
        child: Text('· 유의사항', textAlign: TextAlign.left, style: TextStyle(color: Colors.blue[500], fontSize: 22, fontFamily: 'TmonTium', fontWeight: FontWeight.w300))
      ),
      Align
      (
        alignment: Alignment.centerLeft,
        child: Text(_data['ATTN_FCTS'], textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium', fontWeight: FontWeight.w300))
      )
    ];
  }
}