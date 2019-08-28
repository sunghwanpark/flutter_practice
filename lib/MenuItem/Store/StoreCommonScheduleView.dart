import 'package:bunyang/Abstract/AbstractContentsView.dart';
import 'package:bunyang/Map/MyGoogleMapView.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sprintf/sprintf.dart';

class StoreCommonScheduleView extends AbstractContentsView
{
  StoreCommonScheduleView(this._data);

  final Map<String, String> _data;

  @override
  List<Widget> getContents(BuildContext context) 
  {
    List<Widget> widgets = List<Widget>();

    widgets.add(Row
    (
      children : <Widget>
      [
        Icon(Icons.schedule, color: Colors.black),
        SizedBox(width: 10),
        Text('공급일정', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 27, fontFamily: 'TmonTium', fontWeight: FontWeight.w500))
      ]
    ));

    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text(sprintf('· 신청일시 : %s ~ %s', [_data['ACP_ST_DTTM'], _data['ACP_ED_DTTM']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
    ));

    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text(sprintf('· 추첨일시 : %s', [_data['LTR_DTTM']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
    ));

    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text(sprintf('· 계약체결일정 : %s ~ %s', [_data['CTRT_ST_DT'], _data['CTRT_ED_DT']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
    ));

    if(_data['CTRT_PLC_ADR'].isNotEmpty && _data['CTRT_PLC_DTL_ADR'].isNotEmpty)
    {
      widgets.add(SizedBox(height: 10));
      var addr = _data['CTRT_PLC_ADR'] + " " + _data["CTRT_PLC_DTL_ADR"];
      if(_data['CTRT_PLC_COA_CODT_XXS'].isNotEmpty && _data['CTRT_PLC_COA_CODT_YXS'].isNotEmpty)
      {
        widgets.add(MyGoogleMapViewLatLtd
        (
          '계약장소 정보', addr, LatLng(double.tryParse(_data['CTRT_PLC_COA_CODT_XXS']), double.tryParse(_data['CTRT_PLC_COA_CODT_YXS'])))
        );
      }
      else
      {
        widgets.add(MyGoogleMap('계약장소 정보', addr));
      }
    }

    return widgets;
  }
}