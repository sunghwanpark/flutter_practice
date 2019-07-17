import 'package:bunyang/Abstract/AbstractContentsView.dart';
import 'package:bunyang/Util/NetworkImageWidget.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

class StoreBidImageView extends AbstractContentsView
{
  StoreBidImageView(this._contents, this._imageDatas);

  final Map<String, String> _contents;
  final List<Map<String, String>> _imageDatas;

  @override
  List<Widget> getContents(BuildContext context)
  {
    List<Widget> widgets = List<Widget>();

    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text('· 상가동 목록', textAlign: TextAlign.left, style: TextStyle(color: Colors.blue[500], fontSize: 22, fontFamily: 'TmonTium', fontWeight: FontWeight.w300))
    ));

    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text(sprintf('상가명 : %s', [_contents['SST_NM']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium', fontWeight: FontWeight.w300))
    ));

    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text(sprintf('상가전체호수 : %s', [_contents['SSDH_SL_ADM_NO_CNT']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium', fontWeight: FontWeight.w300))
    ));

    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text(sprintf('상가면적(㎡) : %s ~ %s', [_contents['MIN_SST_AR'], _contents['MAX_SST_AR']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium', fontWeight: FontWeight.w300))
    ));

    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text(sprintf('상가입점시기 : %s', [getYearMonthFormat(_contents['MSH_PSB_YM'])]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium', fontWeight: FontWeight.w300))
    ));

    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text('· 상가동별 이미지 정보', textAlign: TextAlign.left, style: TextStyle(color: Colors.blue[500], fontSize: 22, fontFamily: 'TmonTium', fontWeight: FontWeight.w300))
    ));

    for(int i = 0; i < _imageDatas.length; i++)
    {
      var image = _imageDatas[i];
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('· %s', [image['SL_PAN_AHFL_DS_CD_NM']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium', fontWeight: FontWeight.w300))
      ));
      
      widgets.add(NetworkImageWidget(serialNum: image['CMN_AHFL_SN'], context: context));
    }

    return widgets;
  }
}