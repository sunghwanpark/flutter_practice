import 'package:flutter/material.dart';

class ChargeSupplyInfo extends StatefulWidget
{
  ChargeSupplyInfo(this._defaultData, this._detailData, this._imageData);

  final Map<String, String> _defaultData;
  final Map<String, String> _detailData;
  final Map<String, String> _imageData;

  @override
  ChargeSupplyInfoView createState() => ChargeSupplyInfoView();
}

class ChargeSupplyInfoView extends State<ChargeSupplyInfo>
{
  ChargeSupplyInfoView();

  List<bool> _imageLoadingState = new List<bool>();

  @override
  void initState()
  {
    super.initState();
  }

  List<Widget> _getContents(BuildContext context)
  {
    List<Widget> widgets = new List<Widget>();

    widgets.add(Row
    (
      children : <Widget>
      [
        Icon(Icons.stars, color: Colors.black),
        SizedBox(width: 10),
        Text('공급정보', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 27, fontFamily: 'TmonTium', fontWeight: FontWeight.w500))
      ]
    ));

    return widgets;
  }

  Padding _setDetailCard(List<Widget> addContents)
  {
    return Padding
    (
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: GestureDetector
      (
        child: Container
        (
          decoration: ShapeDecoration
          (
            color: Colors.indigo[200],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            shadows: 
            [
              BoxShadow
              (
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 2.0,
                offset: Offset(5.0, 5.0),
              )
            ],
          ),
          child: Column
          (
            children: addContents
          )
        )
      )
    );
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
          children: _getContents(context)
        ),
      )
    );
  }
}