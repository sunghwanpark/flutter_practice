import 'package:bunyang/Abstract/TabStateView.dart';
import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/MenuItem/Store/Bid/BidDetail/StoreBidInquiryGuideView.dart';
import 'package:bunyang/MenuItem/Store/Bid/BidDetail/StoreBidInquiryInfoView.dart';
import 'package:bunyang/MenuItem/Store/Bid/BidDetail/StoreBidInquiryPresenter.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';

enum StoreBidInquiryTabState { Info, Guide }

class StoreBidInquiry extends TabStatefull
{
  StoreBidInquiry(this.requestData, String uppAisTpCd)
  : super
    (
      noticeCode : getNoticeCodeByUppAisTpCd(uppAisTpCd),
      appBarTitle : '분양, 임대상가 상세정보',
      expandedHeight : 200
    );

  final Map<String, String> requestData;

  @override
  StoreBidInquiryView createState() => StoreBidInquiryView();
}

class StoreBidInquiryView extends TabStateView<StoreBidInquiry>
{
  StoreBidInquiryView()
  {
    tabNames = ['단지정보', '상가동호안내'];
    for(int i = 0; i < StoreBidInquiryTabState.values.length; i++)
    {
      contents[i] = List<Widget>();
    }
  }

  StoreBidInquiryPresenter _presenter;

  @override
  void makePresenter() 
  {
    _presenter = StoreBidInquiryPresenter(this);
    _presenter.onRequestData(widget.requestData);
  }

  void onResponseData(Map<String, List<Map<String, String>>> res)
  {
    contents[StoreBidInquiryTabState.Info.index].add(StoreBidInquiryInfoView(res['dsSstInf'].first));
    contents[StoreBidInquiryTabState.Guide.index].add(StoreBidInquiryGuideView(res['dsDhgList']));

    setState(() {
      loadingState = LoadingState.DONE;
    });
  }
}