import 'package:bunyang/Abstract/AbstractSupplyDetailView.dart';
import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/IntallmentDetail/InstallmentSupplyInfoDetailPresenter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';

class InstallmentSupplyInfoDetail extends AbstractSupplyDetailView
{
  InstallmentSupplyInfoDetail(this._datas) : super(params : _datas, code: Notice_Code.installment_house);

  final Map<String, String> _datas;

  @override
  InstallmentSupplyInfoDetailView createState() => InstallmentSupplyInfoDetailView();
}

class InstallmentSupplyInfoDetailView extends AbstractSupplyDetailWidget<InstallmentSupplyInfoDetail>
{
  InstallmentSupplyInfoDetailPresenter _presenter;

  List<Map<String, String>> _datas = new List<Map<String, String>>();

  @override
  void makePresenter()
  {
    _presenter = InstallmentSupplyInfoDetailPresenter(this);
    _presenter.onRequestData(
      widget._datas['PAN_ID'],
      widget._datas['CCR_CNNT_SYS_DS_CD'],
      widget._datas['AIS_INF_SN'],
      widget._datas['BZDT_CD'],
      widget._datas['HC_BLK_CD'],
      widget._datas['HTY_CD']);
  }

  void onComplete(Map<String, List<Map<String, String>>> res)
  {
    _datas.clear();
    _datas.addAll(res['dsHtyAmtList']);

    loadingComplete();
  }

  @override
  List<Widget> getContents()
  {
    List<Widget> widgets = new List<Widget>();

    widgets.add(Row
    (
      children : <Widget>
      [
        Icon(Icons.check_circle, color: Colors.black),
        SizedBox(width: 10),
        Text('주택형 안내', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium', fontWeight: FontWeight.w500))
      ]
    ));

    List<String> subjectTexts = 
    [
      sprintf('· 주택형 : %s', [widget._datas['HTY_NM']]),
      sprintf('· 전용면적(㎡) : %s', [widget._datas['RSDN_DDO_AR']]),
      sprintf('· 공급면적(㎡) : %s', [widget._datas['SPL_AR']]),
      sprintf('· 주거공용면적(㎡) : %s', [widget._datas['RSDN_CMUS_AR']]),
      sprintf('· 기타공용면적(㎡) : %s', [widget._datas['ETC_CMUS_AR']]),
      sprintf('· 지하주차장면적(㎡) : %s', [widget._datas['UNG_PKPL_AR']]),
      sprintf('· 계약면적(㎡) : %s', [widget._datas['CTRL_AR']]),
      sprintf('· 세대수 : %s', [widget._datas['TOT_HSH_CNT']]),
      sprintf('· 금회공급 세대수 : %s', [widget._datas['SIL_HSH_CNT']])
    ];

    if(_datas.length > 0)
    {
      final f = NumberFormat("#,###");
      // 계약금
      var contractData = _datas.where((map) => map['PC_KD_CD'] == '01');
      var contractMoney = contractData.isNotEmpty ? 
        contractData.first['PC_PYM_AMT'].isNotEmpty ? f.format(int.parse(contractData.first['PC_PYM_AMT'])) : ''
        : '';
      
      // 중도금
      var middlePayData = _datas.where((map) => map['PC_KD_CD'] == '02');
      var middlePayMoney = middlePayData.isNotEmpty ? 
        middlePayData.first['PC_PYM_AMT'].isNotEmpty ? f.format(int.parse(middlePayData.first['PC_PYM_AMT'])) : ''
        : '';

      // 잔금
      var balanceData = _datas.where((map) => map['PC_KD_CD'] == '03');
      var balanceMoney = balanceData.isNotEmpty ? 
        balanceData.first['PC_PYM_AMT'].isNotEmpty ? f.format(int.parse(balanceData.first['PC_PYM_AMT'])) : ''
        : '';

      subjectTexts.add(sprintf('· 분양가격(원) : %s', [_datas.first['SIL_AMT'].isNotEmpty ? f.format(int.parse(_datas.first['SIL_AMT'])) : '']));
      subjectTexts.add(sprintf('· 계약금(원) : %s', [contractMoney]));
      subjectTexts.add(sprintf('· 중도금(원) : %s', [middlePayMoney]));
      subjectTexts.add(sprintf('· 잔금(원) : %s', [balanceMoney]));
      subjectTexts.add(sprintf('· 융자금(원) : %s', [_datas.first['LOA'].isNotEmpty ? f.format(int.parse(_datas.first['LOA'])) : '']));
    }

    subjectTexts.forEach((str)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(str, textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    });
    
    return widgets;
  }
}