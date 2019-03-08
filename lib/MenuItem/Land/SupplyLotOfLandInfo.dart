import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

class SupplyLotOfLandInfo extends StatelessWidget
{
  SupplyLotOfLandInfo
  (
    {
      this.supplyPurpose = '',
      this.locate = '',
      this.number = '',
      this.extent = '',
      this.aLotOfLand = '',
      this.supplyPrice = '',
      this.reservePrice = '',
      this.state = ''
    }
  );

  final String supplyPurpose;
  final String locate;
  final String number;
  final String extent;
  final String aLotOfLand;
  final String supplyPrice;
  final String reservePrice;
  final String state;

  Widget _getTextWidget(String format, String value)
  {
    return Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf(format, [value]), textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'TmonTium'))
      );
  }

  @override
  Widget build(BuildContext context)
  {
    List<Widget> widgets = new List<Widget>();
    widgets.add(Row
      (
        children : <Widget>
        [
          Icon(Icons.stars, color: Colors.white),
          SizedBox(width: 10),
          Text('공급필지 정보(추첨)', textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'TmonTium'))
        ]
      ));
    
    if(supplyPurpose.isNotEmpty)
      widgets.add(_getTextWidget('공급용도 : %s', supplyPurpose));
    
    if(locate.isNotEmpty)
      widgets.add(_getTextWidget('공급용도 : %s', locate));
    
    if(number.isNotEmpty)
      widgets.add(_getTextWidget('공급용도 : %s', number));
    
    if(extent.isNotEmpty)
      widgets.add(_getTextWidget('공급용도 : %s', extent));
    
    if(aLotOfLand.isNotEmpty)
      widgets.add(_getTextWidget('공급용도 : %s', aLotOfLand));

    if(supplyPrice.isNotEmpty)
      widgets.add(_getTextWidget('공급용도 : %s', supplyPrice));

    if(supplyPrice.isNotEmpty)
      widgets.add(_getTextWidget('공급용도 : %s', supplyPrice));
  }
}