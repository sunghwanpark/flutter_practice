import 'package:auto_size_text/auto_size_text.dart';
import 'package:bunyang/Abstract/AbstractContentsView.dart';
import 'package:bunyang/Map/MyGoogleMapView.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sprintf/sprintf.dart';

class SupplyScheduleView extends AbstractContentsView
{
  SupplyScheduleView(this._data);
  
  final Map<String, List<Map<String, String>>> _data;

  @override
  List<Widget> getContents(BuildContext context)
  {
    List<Widget> widgets = new List<Widget>();
    widgets.add(Row
    (
      children : <Widget>
      [
        Icon(Icons.schedule, color: Colors.black),
        SizedBox(width: 10),
        Text('공고일정', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 27, fontFamily: 'TmonTium', fontWeight: FontWeight.w500))
      ]
    ));

    if(_data["dsHsScdList"].length > 0)
    {
      List<TableRow> rows = new List<TableRow>();
      rows.add(TableRow
      (
        children: <Widget>
        [
          Text('구분', textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium')),
          Text('신청일시', textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium')),
          Text('신청방법', textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ]
      ));

      _data["dsHsScdList"].forEach((map)
      {
        var inet = map["INET_RQS_YN"];
        var sppb = map["SPPB_RQS_YN"];

        String rmk = inet == "Y" && sppb == "N" ? "인터넷접수" :
          inet == "N" && sppb == "Y" ? "현장접수" :
          inet == "Y" && sppb == "Y" ? "인터넷접수,현장접수" : "";
        rows.add(TableRow
        (
          children: <Widget>
          [
            Text(map["HS_SBSC_ACP_TRG_CD_NM"], textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium')),
            AutoSizeText(map["ACP_DTTM"], maxLines: 2, textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium')),
            AutoSizeText(rmk, maxLines: 1, textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
          ]
        ));
      });

      widgets.add(Table
      (
        border: TableBorder.all(color: Colors.black, width: 1),
        columnWidths: {0: FractionColumnWidth(0.2)},
        children: rows
      ));
    }
    
    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text(sprintf('· 당첨자발표일자 : %s', [_data["dsHsSlpa"].first["PZWR_ANC_DT"].isNotEmpty ?
        getDateFormat(_data["dsHsSlpa"].first["PZWR_ANC_DT"]) : ""]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
    ));

    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: AutoSizeText(_data["dsHsSlpa"].first["PZWR_PPR_SBM_ST_DT"].isNotEmpty && _data["dsHsSlpa"].first["PZWR_PPR_SBM_ED_DT"].isNotEmpty ?
        sprintf('· 당첨자 서류제출기간 : %s ~ %s', [getDateFormat(_data["dsHsSlpa"].first["PZWR_PPR_SBM_ST_DT"]), getDateFormat(_data["dsHsSlpa"].first["PZWR_PPR_SBM_ED_DT"])])
         : '· 당첨자 서류제출기간: ', maxLines: 1, textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
    ));
    
    widgets.add(Align
    (
      alignment: Alignment.centerLeft,
      child: Text(_data["dsHsSlpa"].first["PZWR_PPR_SBM_ST_DT"].isNotEmpty && _data["dsHsSlpa"].first["PZWR_PPR_SBM_ED_DT"].isNotEmpty ?
        sprintf('· 계약체결기간 : %s ~ %s', [getDateFormat(_data["dsHsSlpa"].first["PZWR_PPR_SBM_ST_DT"]), getDateFormat(_data["dsHsSlpa"].first["PZWR_PPR_SBM_ED_DT"])])
        : '· 계약체결기간:', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
    ));

    if(_data["dsHsSlpa"].first["SPL_SCD_GUD_FCTS"].isNotEmpty)
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
        child: Text(_data["dsHsSlpa"].first["SPL_SCD_GUD_FCTS"], textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }

    if(_data["dsHsSlpa"].first["CTRT_PLC_ADR"].isNotEmpty && _data["dsHsSlpa"].first["CTRT_PLC_DTL_ADR"].isNotEmpty)
    {
      StringBuffer addressBuffer = StringBuffer();
      addressBuffer.write(_data["dsHsSlpa"].first["CTRT_PLC_ADR"]);
      addressBuffer.write(" ");
      addressBuffer.write(_data["dsHsSlpa"].first["CTRT_PLC_DTL_ADR"]);

      widgets.add(MyGoogleMap("접수처 정보", addressBuffer.toString()));
      
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('전화번호 : %s', [_data["dsHsSlpa"].first["SIL_OFC_TLNO"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));

      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: AutoSizeText(sprintf('운영기간 : %s', [_data["dsHsSlpa"].first["SIL_OFC_DT"]]), maxLines: 1, textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));

      if(_data["dsHsSlpa"].first["SIL_OFC_GUD_FCTS"].isNotEmpty)
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
          child: Text(_data["dsHsSlpa"].first["SIL_OFC_GUD_FCTS"], textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
        ));
      }
    }

    if(_data["dsHsSlpa"].first["ETC_FCTS"].isNotEmpty)
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
        child: Text(_data["dsHsSlpa"].first["ETC_FCTS"], textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }

    return widgets;
  }
}