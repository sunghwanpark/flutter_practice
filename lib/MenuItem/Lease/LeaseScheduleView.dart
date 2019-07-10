import 'package:auto_size_text/auto_size_text.dart';
import 'package:bunyang/Map/MyGoogleMapView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sprintf/sprintf.dart';

class LeaseScheduleView extends StatelessWidget
{
  LeaseScheduleView(this._data);
  
  final Map<String, List<Map<String, String>>> _data;

  List<Widget> _getContents(BuildContext context)
  {
    List<Widget> widgets = new List<Widget>();
    widgets.add(Row
    (
      children : <Widget>
      [
        Icon(Icons.schedule, color: Colors.black),
        SizedBox(width: 10),
        Text('공급일정', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 27, fontFamily: 'TmonTium', fontWeight: FontWeight.w500))
      ]
    ));

    if(_data['dsSplScdInf'].first['SBSC_ACP_ST_DT'].isNotEmpty && _data['dsSplScdInf'].first['SBSC_ACP_CLSG_DT'].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('· 접수기간 : %s ~ %s', [_data['dsSplScdInf'].first['SBSC_ACP_ST_DT'], _data['dsSplScdInf'].first['SBSC_ACP_CLSG_DT']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }
    else if(_data['dsSplScdInf'].first['UST_ACP_ST_DTTM'].isNotEmpty || _data['dsSplScdInf'].first['UST_ACP_CLSG_DTTM'].isNotEmpty)
    {
      String startAt = _data['dsSplScdInf'].first['UST_ACP_ST_DTTM'];
      String endAt = _data['dsSplScdInf'].first['UST_ACP_CLSG_DTTM'];
      String contents = startAt.isNotEmpty && endAt.isNotEmpty ? '· 접수기간 : $startAt ~ $endAt' : 
        startAt.isNotEmpty && endAt.isEmpty ? '· 접수기간 : $startAt ~' :
        startAt.isEmpty && endAt.isNotEmpty ? '· 접수기간 : $endAt' : '';

      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(contents, textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }
    
    if(_data['dsSplScdInf'].first['PPR_SBM_OPE_ANC_DT'].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('· 서류제출대상자 발표일 : %s', [_data['dsSplScdInf'].first['PPR_SBM_OPE_ANC_DT']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }

    if(_data['dsSplScdInf'].first['PPR_ACP_ST_DT'].isNotEmpty && _data['dsSplScdInf'].first['PPR_ACP_CLSG_DT'].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('· 서류접수기간 : %s ~ %s', [_data['dsSplScdInf'].first['PPR_ACP_ST_DT'], _data['dsSplScdInf'].first['PPR_ACP_CLSG_DT']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }

    if(_data['dsSplScdInf'].first['HS_VIE_ST_DT'].isNotEmpty && _data['dsSplScdInf'].first['HS_VIE_ED_DT'].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('· 주택열람기간 : %s ~ %s', [_data['dsSplScdInf'].first['HS_VIE_ST_DT'], _data['dsSplScdInf'].first['HS_VIE_ED_DT']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }

    if(_data['dsSplScdInf'].first['PZWR_ANC_DT'].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf(_data['dsLohTpCdInf'].first['LOH_TP_CD'] == '03' ? '· 입주대상자발표일 : %s': '· 당첨자발표일 : %s',
          [_data['dsSplScdInf'].first['PZWR_ANC_DT']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }

    if(_data['dsSplScdInf'].first['CTRT_ST_DT'].isNotEmpty && _data['dsSplScdInf'].first['CTRT_ED_DT'].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('· 계약기간 : %s ~ %s', [_data['dsSplScdInf'].first['CTRT_ST_DT'], _data['dsSplScdInf'].first['CTRT_ED_DT']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }

    if(_data["dsPanInf"].first["ETC_CTS2"].isNotEmpty)
    {
      widgets.add(SizedBox(height: 10));
      
      widgets.add(Row
      (
        children : <Widget>
        [
          Icon(Icons.more, color: Colors.black),
          SizedBox(width: 10),
          Text('기타사항', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 27, fontFamily: 'TmonTium', fontWeight: FontWeight.w500))
        ]
      ));

      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(_data["dsPanInf"].first["ETC_CTS2"], textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }

    widgets.add(SizedBox(height: 10));

    if(_data["dsPanInf"].first["CTRT_PLC_ADR"].isNotEmpty && _data["dsPanInf"].first["CTRT_PLC_DTL_ADR"].isNotEmpty)
    {
      StringBuffer addressBuffer = StringBuffer();
      addressBuffer.write(_data["dsPanInf"].first["CTRT_PLC_ADR"]);
      addressBuffer.write(" ");
      addressBuffer.write(_data["dsPanInf"].first["CTRT_PLC_DTL_ADR"]);

      widgets.add(MyGoogleMap("접수처 정보", addressBuffer.toString()));
    }
    else
    {
      widgets.add(Row
      (
        children: <Widget>
        [
          Icon(Icons.location_on, color: Colors.black),
          SizedBox(width: 10),
          Text('접수처 정보', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'TmonTium'))
      ]));
    }

    if(_data["dsPanInf"].first["SIL_OFC_TLNO"].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('전화번호 : %s', [_data["dsPanInf"].first["SIL_OFC_TLNO"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }

    if(_data['dsPanInf'].first['TSK_ST_DTTM'].isNotEmpty && _data['dsPanInf'].first['TSK_ED_DTTM'].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: AutoSizeText(sprintf('운영기간 : %s ~ %s', [_data["dsPanInf"].first["TSK_ST_DTTM"], _data["dsPanInf"].first["TSK_ED_DTTM"]]), maxLines: 1, textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }

    if(_data["dsPanInf"].first["SIL_OFC_GUD_FCTS"].isNotEmpty)
    {
      widgets.add(SizedBox(height: 10));

      widgets.add(Row
      (
        children : <Widget>
        [
          Icon(Icons.info, color: Colors.red),
          SizedBox(width: 10),
          Text('안내사항', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium', fontWeight: FontWeight.w800))
        ]
      ));

      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(_data["dsPanInf"].first["SIL_OFC_GUD_FCTS"], textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }

    return widgets;
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