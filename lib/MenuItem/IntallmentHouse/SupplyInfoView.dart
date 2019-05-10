import 'package:flutter/material.dart';

class SupplyInfo extends StatefulWidget
{
  final SupplyInfoView _infoView = SupplyInfoView();

  final Map<String, String> defaultData = new Map<String, String>();
  final List<Map<String, String>> detailData = new List<Map<String, String>>();
  final List<Map<String, String>> imageData = new List<Map<String, String>>();

  void setDefaultData(Map<String, String> data)
  {
    defaultData.clear();
    defaultData.addAll(data);

    _infoView.onListenDefaultData();
  }

  void setDetailData(List<Map<String, String>> data)
  {
    detailData.clear();
    detailData.addAll(data);

    _infoView.onListenDetailData();
  }

  void setImageData(List<Map<String, String>> data)
  {
    imageData.clear();
    imageData.addAll(data);

    _infoView.onListenImageData();
  }

  @override
  SupplyInfoView createState() => _infoView;
}

enum _SupplyDataState { NONE, COMPLETE }

class SupplyInfoView extends State<SupplyInfo>
{
  SupplyInfoView();

  _SupplyDataState _state = _SupplyDataState.NONE;

  void onListenDefaultData()
  {
  }

  void onListenDetailData()
  {
  }

  void onListenImageData()
  {
    setState(() {
      _state = _SupplyDataState.COMPLETE;
    });
  }

  List<Widget> _getContents(BuildContext context)
  {
    List<Widget> widgets = new List<Widget>();

    return widgets;
  }

  @override
  Widget build(BuildContext context)
  {
    if(_state == _SupplyDataState.NONE)
      return Container();
    
    return Container
    (
      width: MediaQuery.of(context).size.width,
      child: Padding
      (
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column
        (
          children: _getContents(context)
        ),
      )
    );
  }
}