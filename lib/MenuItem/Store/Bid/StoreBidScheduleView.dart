import 'package:auto_size_text/auto_size_text.dart';
import 'package:bunyang/Abstract/AbstractContentsView.dart';
import 'package:bunyang/Map/MyGoogleMapView.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sprintf/sprintf.dart';

class StoreBidScheduleView extends AbstractContentsView
{
  StoreBidScheduleView(this._defaultData, this._scheduleDatas);

  final Map<String, String> _defaultData;
  final List<Map<String, String>> _scheduleDatas;

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
      child: Text('· 입찰일정', textAlign: TextAlign.left, style: TextStyle(color: Colors.blue[500], fontSize: 22, fontFamily: 'TmonTium', fontWeight: FontWeight.w300))
    ));

    for(int i = 0; i < _scheduleDatas.length; i++)
    {
      List<Widget> texts = List<Widget>();
      var schedule = _scheduleDatas[i];

      int toy = schedule['TOY'].isNotEmpty ? int.tryParse(schedule['TOY']) : -1;
      if(toy != -1)
      {
        String strToy = toy == 1 ? '최초입찰' : toy == 2 ? '재입찰' : '$toy+회차'; 

        texts.add(Align
        (
          alignment: Alignment.centerLeft,
          child: Text('구분 : $strToy', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));
      }

      String rqsScd = schedule['RQS_SCD'];
      rqsScd = rqsScd.replaceAll('일정:', '');
      texts.add(Align
      (
        alignment: Alignment.centerLeft,
        child: AutoSizeText('신청일시 : $rqsScd', textAlign: TextAlign.left, maxLines: 1, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));

      String opbStScd = schedule['OPB_ST_SCD'];
      opbStScd = opbStScd.replaceAll('일정:', '');
      String opbStHr = schedule['OPB_ST_HR'];
      opbStHr = opbStHr.replaceAll('시간:', '');
      texts.add(Align
      (
        alignment: Alignment.centerLeft,
        child: AutoSizeText('입찰보증금 마감일시 : $opbStScd ($opbStHr)', textAlign: TextAlign.left, maxLines: 1, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));

      String gmyPymClsgScd = schedule['GMY_PYM_CLSG_SCD'];
      gmyPymClsgScd = gmyPymClsgScd.replaceAll('일정:', '');
      String gmyPymClsgHr = schedule['GMY_PYM_CLSG_HR'];
      gmyPymClsgHr = gmyPymClsgHr.replaceAll('시간:', '');
      texts.add(Align
      (
        alignment: Alignment.centerLeft,
        child: AutoSizeText('개찰일시 : $gmyPymClsgScd ($gmyPymClsgHr)', textAlign: TextAlign.left, maxLines: 1, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));

      String opbEdScd = schedule['OPB_ED_SCD'];
      opbEdScd = opbEdScd.replaceAll('일정:', '');
      String opbEdHr = schedule['OPB_ED_HR'];
      opbEdHr = opbEdHr.replaceAll('시간:', '');
      texts.add(Align
      (
        alignment: Alignment.centerLeft,
        child: AutoSizeText('개찰결과게시일시 : $opbEdScd ($opbEdHr)', textAlign: TextAlign.left, maxLines: 1, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));

      widgets.add(Padding
      (
        padding: EdgeInsets.only(bottom: 10),
        child: Card
        (
          color: Colors.grey[100],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 2,
          child: Column(children: texts),
        )
      ));
    }

    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text('· 계약체결일정', textAlign: TextAlign.left, style: TextStyle(color: Colors.blue[500], fontSize: 22, fontFamily: 'TmonTium', fontWeight: FontWeight.w300))
    ));

    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text(sprintf('%s ~ %s',[getDateFormat(_defaultData['CTRT_ST_DT']), getDateFormat(_defaultData['CTRT_ED_DT'])]),
       textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
    ));

    if(_defaultData['CTRT_PLC_ADR'].isNotEmpty && _defaultData['CTRT_PLC_DTL_ADR'].isNotEmpty)
    {
      widgets.add(SizedBox(height: 10));
      var addr = _defaultData['CTRT_PLC_ADR'] + " " + _defaultData["CTRT_PLC_DTL_ADR"];
      if(_defaultData['CTRT_PLC_COA_CODT_XXS'].isNotEmpty && _defaultData['CTRT_PLC_COA_CODT_YXS'].isNotEmpty)
      {
        widgets.add(MyGoogleMapViewLatLtd
        (
          '계약장소 정보', addr, LatLng(double.tryParse(_defaultData['CTRT_PLC_COA_CODT_XXS']), double.tryParse(_defaultData['CTRT_PLC_COA_CODT_YXS'])))
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