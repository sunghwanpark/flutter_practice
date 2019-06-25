
import 'package:bunyang/Abstract/TabStateView.dart';
import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/Abstract/AbstractInstallmentHouseView.dart';
import 'package:flutter/material.dart';

class PublicLeaseView extends TabStatefull
{
  PublicLeaseView(this._data) : super(noticeCode: _data.type, appBarTitle: _data.panName);
  
  final MenuData _data;

  @override
  PublicLeaseViewWidget createState() => PublicLeaseViewWidget(_data);
}

class PublicLeaseViewWidget extends TabStateView<PublicLeaseView>
{
  PublicLeaseViewWidget()
  {
    tabNames = ['공고내용', '공급정보', '공고일정'];

    for(int i = 0; i < InstallmentTabState.values.length; i++)
    {
      contents[i] = new List<Widget>();
    }
  }

  @override
  void initState()
  {
    super.initState();

  }

  @override
  void onResponseSuccessPanInfo(Map<String, String> panInfo) {
  }
}