import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/IntallmentDetail/InstallmentSupplyInfoDetailPresenter.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';

class InstallmentSupplyInfoDetail extends StatefulWidget
{
  InstallmentSupplyInfoDetail(this._datas);

  final Map<String, String> _datas;

  @override
  InstallmentSupplyInfoDetailView createState() => InstallmentSupplyInfoDetailView();
}

class InstallmentSupplyInfoDetailView extends State<InstallmentSupplyInfoDetail>
{
  LoadingState _loadingState = LoadingState.LOADING;
  
  InstallmentSupplyInfoDetailPresenter _presenter;

  List<Map<String, String>> _datas = new List<Map<String, String>>();

  @override
  void initState()
  {
    super.initState();
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

    setState(() {
     _loadingState = LoadingState.DONE; 
    });
  }

  void onError()
  {
    setState(() {
     _loadingState = LoadingState.ERROR; 
    });
  }

  List<Widget> _getContents()
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
      sprintf('· 금회공급 세대수 : %s', [widget._datas['SIL_HSH_CNT']]),
      sprintf('· 분양가격(원) : %s', [_datas.first['SIL_AMT'].isNotEmpty ? f.format(int.parse(_datas.first['SIL_AMT'])) : '']),
      sprintf('· 계약금(원) : %s', [contractMoney]),
      sprintf('· 중도금(원) : %s', [middlePayMoney]),
      sprintf('· 잔금(원) : %s', [balanceMoney]),
      sprintf('· 융자금(원) : %s', [_datas.first['LOA'].isNotEmpty ? f.format(int.parse(_datas.first['LOA'])) : '']),
    ];

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

  Widget _getContentSection(BuildContext context)
  {
    switch (_loadingState)
    {
      case LoadingState.DONE:
        return SliverList
        (
          delegate: SliverChildListDelegate(_getContents())
        );
      case LoadingState.ERROR:
        return SliverList
        (
          delegate: SliverChildListDelegate(<Widget>
          [
            myText("데이터를 불러오지 못했습니다!")
          ])
        );
      case LoadingState.LOADING:
        return SliverList
        (
          delegate: SliverChildListDelegate(<Widget>
          [
            Container
            (
              alignment: Alignment.center,
              child: CircularProgressIndicator(backgroundColor: Colors.white)
            )
          ])
        );
      default:
        return SliverList
        (
          delegate: SliverChildListDelegate(<Widget>
          [
            Container()
          ])
        );
    }
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      backgroundColor: Colors.white,
      body: CustomScrollView
      (
        primary: false,
        slivers: <Widget>
        [
          SliverAppBar
          (
            expandedHeight: 200,
            iconTheme: IconThemeData
            (
              color: Colors.black
            ),
            flexibleSpace: FlexibleSpaceBar
            (
              titlePadding: EdgeInsets.only(bottom: 20, left: 80, right: 80),
              centerTitle: true,
              title: Text
              (
                "공급정보 상세보기",
                style: TextStyle
                (
                  color: Colors.white,
                  fontFamily: "TmonTium",
                  fontSize: 25,
                  fontWeight: FontWeight.w800
                )
              ),
              background: Stack
              (
                fit: StackFit.expand,
                children: <Widget>
                [
                  Hero
                  (
                    tag: constNoticeCodeMap[Notice_Code.installment_house].code,
                    child: FadeInImage
                    (
                      fit: BoxFit.cover,
                      placeholder: AssetImage("assets/image/placeholder.jpg"),
                      image: constNoticeCodeMap[Notice_Code.installment_house].image
                    )
                  )
                ]
              )
            ),
          ),
          _getContentSection(context)
        ], 
      ),
    );
  }
}