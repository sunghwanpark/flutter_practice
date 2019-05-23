import 'package:auto_size_text/auto_size_text.dart';
import 'package:bunyang/Map/MyGoogleMapView.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sprintf/sprintf.dart';

class ChargeScheduleView extends StatelessWidget
{
  ChargeScheduleView(this._data);
  
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
    

    if(_data['dsSplScdInf'].length > 0)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text('※ 단지별 공급일정은 공고문을 참조하시기 바랍니다.', textAlign: TextAlign.left, style: TextStyle(color: Colors.blue[400], fontSize: 15, fontFamily: 'TmonTium', decoration: TextDecoration.underline))
      ));

      for(int i = 0; i < _data['dsSbdInf'].length; i++)
      {
        var data = _data['dsSbdInf'][i];

        var ltrUntNo = data['LTR_UNT_NO'];
        var ltrNot = data['LTR_NOT'];

        var scheduleData = _data['dsSplScdInf'].firstWhere((map) => map['LTR_UNT_NO'] == ltrUntNo && map['LTR_NOT'] == ltrNot);
        if(scheduleData == null)
          continue;

        widgets.add(Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('%d. %s', [i + 1, data['LCC_NT_NM']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));

        if(scheduleData['SBSC_ACP_ST_DT'].isNotEmpty && scheduleData['SBSC_ACP_CLSG_DT'].isNotEmpty)
        {
          widgets.add(Align
          (
            alignment: Alignment.centerLeft,
            child: Text(sprintf('· 접수기간 : %s ~ %s', [scheduleData['SBSC_ACP_ST_DT'], scheduleData['SBSC_ACP_CLSG_DT']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
          ));
        }
        
        if(scheduleData['PPR_SBM_OPE_ANC_DT'].isNotEmpty)
        {
          widgets.add(Align
          (
            alignment: Alignment.centerLeft,
            child: Text(sprintf('· 서류제출대상자 발표일 : %s', [scheduleData['PPR_SBM_OPE_ANC_DT']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
          ));
        }

        if(scheduleData['PPR_ACP_ST_DT'].isNotEmpty || scheduleData['PPR_ACP_CLSG_DT'].isNotEmpty)
        {
          widgets.add(Align
          (
            alignment: Alignment.centerLeft,
            child: Text(sprintf('· 서류접수기간 : %s ~ %s', [scheduleData['PPR_ACP_ST_DT'], scheduleData['PPR_ACP_CLSG_DT']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
          ));
        }

        if(scheduleData['PZWR_ANC_DT'].isNotEmpty)
        {
          widgets.add(Align
          (
            alignment: Alignment.centerLeft,
            child: Text(sprintf('· 당첨자발표일 : %s', [scheduleData['PZWR_ANC_DT']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
          ));
        }

        if(scheduleData['CTRT_ST_DT'].isNotEmpty && scheduleData['CTRT_ED_DT'].isNotEmpty)
        {
          widgets.add(Align
          (
            alignment: Alignment.centerLeft,
            child: Text(sprintf('· 계약기간 : %s ~ %s', [scheduleData['CTRT_ST_DT'], scheduleData['CTRT_ED_DT']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
          ));
        }
      }
    }
    else
    {
      if(_data['dsSplScdInf'].first['SBSC_ACP_ST_DT'].isNotEmpty && _data['dsSplScdInf'].first['SBSC_ACP_CLSG_DT'].isNotEmpty)
      {
        widgets.add(Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('· 접수기간 : %s ~ %s', [_data['dsSplScdInf'].first['SBSC_ACP_ST_DT'], _data['dsSplScdInf'].first['SBSC_ACP_CLSG_DT']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
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

      if(_data['dsSplScdInf'].first['PPR_ACP_ST_DT'].isNotEmpty || _data['dsSplScdInf'].first['PPR_ACP_CLSG_DT'].isNotEmpty)
      {
        widgets.add(Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('· 서류접수기간 : %s ~ %s', [_data['dsSplScdInf'].first['PPR_ACP_ST_DT'], _data['dsSplScdInf'].first['PPR_ACP_CLSG_DT']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));
      }

      if(_data['dsSplScdInf'].first['PZWR_ANC_DT'].isNotEmpty)
      {
        widgets.add(Align
        (
          alignment: Alignment.centerLeft,
          child: Text(sprintf('· 당첨자발표일 : %s', [_data['dsSplScdInf'].first['PZWR_ANC_DT']]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
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
    }

    if(_data["dsPanInf"].first["ETC_CTS"].isNotEmpty)
    {
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
        child: Text(_data["dsPanInf"].first["ETC_CTS"], textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }

    if(_data["dsPanInf"].first["CTRT_PLC_ADR"].isNotEmpty && _data["dsPanInf"].first["CTRT_PLC_DTL_ADR"].isNotEmpty)
    {
      StringBuffer addressBuffer = StringBuffer();
      addressBuffer.write(_data["dsPanInf"].first["CTRT_PLC_ADR"]);
      addressBuffer.write(" ");
      addressBuffer.write(_data["dsPanInf"].first["CTRT_PLC_DTL_ADR"]);

      widgets.add(MyGoogleMap("접수처 정보", addressBuffer.toString()));
      
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('전화번호 : %s', [_data["dsPanInf"].first["SIL_OFC_TLNO"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));

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