import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import 'package:bunyang/Data/URL.dart';
import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/Data/ListItem.dart';

class CachingData
{
  static final CachingData _data = CachingData._internal();

  CachingData._internal();

  factory CachingData.instance() 
  {
    return _data;
  }

  Future<List<ListItem>> request(String code) async
  {
    String url = noticeURL + apiURL;
    url = url + "?" + "apiKey=" + api_key;
    url = url + "&PG_SZ=100";
    url = url + "&PAGE=1";
    url = url + "&PAN_SS=공고중";
    url = url + "&UPP_AIS_TP_CD=" + code;

    return await http.post(url)
    .timeout(const Duration(seconds: 5))
    .then((res) => json.decode(res.body)[1]["dsList"])
    .then((json) => json
    .map<ListItem>((item) => ListItem(item))
    .toList());
  }

  Future<xml.XmlDocument> requestItem(Notice_Code notice_code, String panId, 
  [String ccr_cnnt_sys_ds_cd = "", String upp_ais_tp_cd = ""]) async
  {
    StringBuffer stringBuffer = new StringBuffer();
    stringBuffer.write(noticeURL);
    stringBuffer.write(detailFormUrl);
    stringBuffer.write("?&serviceID=");
    stringBuffer.write(detailFormMaps[notice_code]);

    return await http.post
    (
      stringBuffer.toString(),
      headers: {"Content-Type" : "application/xml"},
      body: generateDetailBody(notice_code, panId, ccr_cnnt_sys_ds_cd, upp_ais_tp_cd)
    ).timeout(const Duration(seconds: 5))
    .then((res) => xml.parse(res.body));
  }
}