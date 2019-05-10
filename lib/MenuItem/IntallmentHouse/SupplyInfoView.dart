import 'package:flutter/material.dart';

class SupplyInfo extends StatefulWidget
{
  final SupplyInfoView _infoView = SupplyInfoView();

  final Map<String, String> defaultData = new Map<String, String>();
  final List<Map<String, String>> detailData = new List<Map<String, String>>();

  void setDefaultData(Map<String, String> data)
  {
    defaultData.clear();
    defaultData.addAll(data);

    _infoView.setDefaultData(data);
  }

  void setDetailData(List<Map<String, String>> data)
  {
    detailData.clear();
    detailData.addAll(data);

    _infoView.setDetailData(data);
  }

  @override
  SupplyInfoView createState() => _infoView;
}

class SupplyInfoView extends State<SupplyInfo>
{
  SupplyInfoView();

  void setDefaultData(Map<String, String> data)
  {
    setState(() {
      
    });
  }

  void setDetailData(List<Map<String, String>> data)
  {
    setState(() {
      
    });
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
          children: <Widget>
          []
        ),
      )
    );
  }
}