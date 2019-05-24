import 'package:bunyang/Abstract/TabStateView.dart';
import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/InstallmentHouseInquiry/InstallmentHouseInquiryGuideView.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/InstallmentHouseInquiry/InstallmentHouseInquiryInfoView.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/InstallmentHouseInquiry/InstallmentHouseInquiryPresenter.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';

enum InstallmentHouseInquiryTabState { Info, Guide }

class InstallmentHouseInquiry extends TabStatefull
{
  InstallmentHouseInquiry(this._requestData, this._uppAisTpCd) 
  : super
    (
      noticeCode : Notice_Code.installment_house,
      appBarTitle : '분양, 임대주택 상세정보',
      expandedHeight : 200
    );

  final Map<String, String> _requestData;
  final String _uppAisTpCd;

  @override
  InstallmentHouseInquiryView createState() => InstallmentHouseInquiryView();
}

class InstallmentHouseInquiryView extends TabStateView<InstallmentHouseInquiry>
{
  InstallmentHouseInquiryView()
  {
    tabNames = ['단지정보', '주택형안내'];
    for(int i = 0; i < InstallmentHouseInquiryTabState.values.length; i++)
    {
      contents[i] = List<Widget>();
    }
  }

  InstallmentHouseInquiryPresenter _presenter;

  @override
  void initState()
  {
    super.initState();

    _presenter = InstallmentHouseInquiryPresenter(this);
    _presenter.onRequestData(
      widget._requestData['PAN_ID'],
      widget._requestData['CCR_CNNT_SYS_DS_CD'],
      widget._uppAisTpCd,
      widget._requestData['AIS_INF_SN'],
      widget._requestData['BZDT_CD'],
      widget._requestData['HC_BLK_CD']);
  }

  void onComplete(Map<String, List<Map<String, String>>> res)
  {
    contents[InstallmentHouseInquiryTabState.Info.index].add(InstallmentHouseInquiryInfo(res['dsHsInf'].first, res['dsHsAhflList']));
    contents[InstallmentHouseInquiryTabState.Guide.index].add(InstallmentHouseInquiryGuideView(res['dsHsList']));

    setState(() {
     loadingState = LoadingState.DONE; 
    });
  }
}