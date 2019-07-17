import 'package:auto_size_text/auto_size_text.dart';
import 'package:bunyang/Abstract/AbstractContentsView.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

class LeaseRentalSupplyView extends AbstractContentsView
{
  LeaseRentalSupplyView(this._defaultDatas, this._dsList, this._stTypeList);
  
  final Map<String, List<Map<String, String>>> _defaultDatas;
  final List<Map<String, String>> _dsList;
  final List<Map<String, String>> _stTypeList;

  @override
  List<Widget> getContents(BuildContext context)
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

    if(_defaultDatas['dsLohTpCdInf'].first['LOH_TP_CD'].isNotEmpty)
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('· 대상주택 : %s', [_defaultDatas['dsLsPanDtl'].first["TRG_HS_CTS"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));

      widgets.add(SizedBox(height: 10));

      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('· 공급호수 : %s', [_defaultDatas['dsLsPanDtl'].first["SPL_HO_CNT_CTS"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));
    }
    else
    {
      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text(sprintf('· 모집지역 : %s', [_defaultDatas['dsLsPanDtl'].first["ARAG_RCR_HSH_CTS"]]), textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
      ));

      widgets.add(SizedBox(height: 10));

      widgets.add(Align
      (
        alignment: Alignment.centerLeft,
        child: Text('· 모집세대', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 23, fontFamily: 'TmonTium', fontWeight: FontWeight.w700))
      ));
    }

    if(_dsList != null)
    {
      for(int i = 0; i < _dsList.length; i++)
      {
        var info = _dsList[i];

        String panId = info['PAN_ID'];

        String subject = '';
        StringBuffer strBuffer = StringBuffer();
        _stTypeList
          .where((map) => map['PAN_ID'] == panId)
          .toList()
          .forEach((map)
          {
            subject = map['SPL_INF_NM'];
            if(!strBuffer.toString().contains(map['VLD_VL_NM']))
            {
              strBuffer.write(map['VLD_VL_NM']);
              strBuffer.write(',');
            }
          });

        List<Widget> texts = new List<Widget>();
        var values = 
        [
          sprintf(' 지역: %s', [info['CNP_NM']]),
          sprintf(strBuffer.isNotEmpty  ? ' 학생분류: %s\n(%s)' : '학생분류: %s%s', [subject, 
            strBuffer.isNotEmpty ? strBuffer.toString().substring(0, strBuffer.toString().length - 1) : '']),
          sprintf(' 총 공급물량: %s', [info['TOT_RSDC_SPL_QOM']]),
          sprintf(' 대학생 공급물량: %s', [info['UST_SPL_QOM']]),
          sprintf(' 취업준비생 공급물량: %s', [info['EMPT_PPRT_OPE_SPL_QOM']]),
          sprintf(' 청년 공급물량: %s', [info['YT_OPE_SPL_QOM']]),
          sprintf(' 공동거주 공급물량: %s', [info['COP_RSDC_SPL_QOM']])
        ];

        values.forEach((str)
        {
          texts.add(Align
          (
            alignment: Alignment.centerLeft,
            child: AutoSizeText(str, textAlign: TextAlign.left, maxLines: 3, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
          ));

          texts.add(SizedBox(height: 5));
        });

        widgets.add(Padding
        (
          padding: EdgeInsets.only(bottom: 10),
          child: Card
          (
            color: Colors.lime[100],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 2,
            child: Column(children: texts),
          )
        ));
      }
    }

    return widgets;
  }
}