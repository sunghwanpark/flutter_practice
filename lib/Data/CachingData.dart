import 'dart:convert';
import 'dart:collection';
import 'dart:io';
import 'dart:async';

import 'package:flutter_practice/Data/Address.dart';
import 'package:flutter_practice/Data/ListItem.dart';

class CachingData
{
  static final CachingData _data = CachingData._internal();

  final _http = HttpClient();
  final HashMap<Notice_Code, String> cacheDatas = HashMap<Notice_Code, String>();

  CachingData._internal();

  factory CachingData.instance() 
  {
    return _data;
  }

  Future<List<ListItem>> requestTest() async
  {
    String url = noticeURL + apiURL;
    url = url + "?" + "apiKey=" + api_key;
    url = url + "&PG_SZ=100";
    url = url + "&PAGE=1";
    url = url + "&PAN_SS=공고중";

    return await http.post(url)
    .then((res) => json.decode(res.body)[1]["dsList"])
    .then((json) => json
    .map<ListItem>((item) => ListItem(item))
    .toList());
  }
}