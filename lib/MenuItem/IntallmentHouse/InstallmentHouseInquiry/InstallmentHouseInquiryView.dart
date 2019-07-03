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
  InstallmentHouseInquiry(this.requestData, this.uppAisTpCd) 
  : super
    (
      noticeCode : getNoticeCodeByUppAisTpCd(uppAisTpCd),
      appBarTitle : '분양, 임대주택 상세정보',
      expandedHeight : 200
    );

  InstallmentHouseInquiry.extend(this.requestData, this.uppAisTpCd, Notice_Code _code, String _appBarTitle, double _expandedHeight)
  : super(noticeCode : _code, appBarTitle : _appBarTitle, expandedHeight : _expandedHeight);

  final Map<String, String> requestData;
  final String uppAisTpCd;

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

  @protected
  InstallmentHouseInquiryPresenter presenter;

  @override
  void makePresenter()
  {
    presenter = InstallmentHouseInquiryPresenter(this);
    presenter.onRequestData(
      widget.requestData['PAN_ID'],
      widget.requestData['CCR_CNNT_SYS_DS_CD'],
      widget.uppAisTpCd,
      widget.requestData['AIS_INF_SN'],
      widget.requestData['BZDT_CD'],
      widget.requestData['HC_BLK_CD']);
  }

  void onComplete(Map<String, List<Map<String, String>>> res)
  {
    contents[InstallmentHouseInquiryTabState.Info.index].add(InstallmentHouseInquiryInfoView(res['dsHsInf'].first, res['dsHsAhflList']));
    contents[InstallmentHouseInquiryTabState.Guide.index].add(InstallmentHouseInquiryGuideView(res['dsHsList']));

    setState(() {
     loadingState = LoadingState.DONE; 
    });
  }
}