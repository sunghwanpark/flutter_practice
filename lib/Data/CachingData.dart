import 'dart:convert';
import 'dart:collection';
import 'dart:async';

import 'package:http/http.dart' as http;

import 'package:bunyang/Data/URL.dart';
import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/Data/ListItem.dart';

class CachingData
{
  static final CachingData _data = CachingData._internal();

  final HashMap<Notice_Code, String> cacheDatas = HashMap<Notice_Code, String>();

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
    .then((res) => json.decode(res.body)[1]["dsList"])
    .then((json) => json
    .map<ListItem>((item) => ListItem(item))
    .toList());
  }
}