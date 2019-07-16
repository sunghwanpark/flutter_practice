import 'package:auto_size_text/auto_size_text.dart';
import 'package:bunyang/Abstract/AbstractSupplyDetailView.dart';
import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/MenuItem/Store/Bid/BidSupplyDetail/StoreBidSupplyDetailPresenter.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';

class StoreBidSupplyDetailView extends AbstractSupplyDetailView
{
  StoreBidSupplyDetailView(Map<String, String> params)
   : super(params: params, code : Notice_Code.shopping_district);

  @override
  StoreBidSupplyDetailWidget createState() => StoreBidSupplyDetailWidget();  
}

class StoreBidSupplyDetailWidget extends AbstractSupplyDetailWidget<StoreBidSupplyDetailView>
{
  StoreBidSupplyDetailPresenter _presenter;
  Map<String, String> _datas;

  @override
  void makePresenter()
  {
    _presenter = StoreBidSupplyDetailPresenter(this);
    _presenter.onRequestData(widget.requestParams);
  }

  @override
  void onComplete(Map<String, List<Map<String, String>>> res) 
  {
    _datas = res['dsList'].first;
    loadingComplete();
  }

  @override
  List<Widget> getContents() 
  {
    List<Widget> widgets = List<Widget>();

    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text('· 상가호안내', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium', fontWeight: FontWeight.w700))
    ));

    var f = NumberFormat('#,###');
    var texts =
    [
      sprintf('상가명 : %s', [_datas['SST_NM']]),
      sprintf('상가호 : %s', [_datas['HO_NM']]),
      sprintf('입점가능시기 : %s', [getYearMonthFormat(_datas['MSH_PSB_YM'])]),
      sprintf('층수 : %s', [_datas['OCNT']]),
      sprintf('전용면적(㎡) : %s', [_datas['DDO_AR']]),
      sprintf('분양면적(㎡) : %s', [_datas['SIL_AR']]),
      sprintf('예정가격(원) : %s', [_datas['XPC_PR'].isNotEmpty ? f.format(int.parse(_datas['XPC_PR'])) : ''])
    ];

    texts.forEach((text)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: AutoSizeText(text, textAlign: TextAlign.left, maxLines: 1, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    });

    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text('납부조건 : ', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
    ));

    if(_datas['DPA_RT'].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text('- 계약금', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium', fontWeight: FontWeight.w500))
      ));
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('낙찰가격의 %s, 납부기한 : %s',[_datas['DPA_RT'], _datas['DPA_DT']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }

    if(_datas['PPMT_RT'].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text('- 중도금', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium', fontWeight: FontWeight.w500))
      ));
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('낙찰가격의 %s, 납부기한 : %s',[_datas['PPMT_RT'], _datas['PPMT_DT']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }

    if(_datas['BLCE_RT'].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text('- 잔금', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium', fontWeight: FontWeight.w500))
      ));
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('낙찰가격의 %s, 납부기한 : %s',[_datas['BLCE_RT'], _datas['BLCE_DT']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }

    return widgets;
  }
}