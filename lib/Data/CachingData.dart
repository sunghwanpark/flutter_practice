import 'dart:convert';
import 'dart:collection';
import 'dart:io';
import 'dart:async';

import 'package:http/http.dart' as http;

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

  Future<List<ListItem>> request()
  {
    var params = 
    {
      "apiKey" : api_key,
      "PG_SZ" : "100",
      "PAGE" : "1",
      "PAN_SS" : "공고중"
    };

    var uri = Uri.https(noticeURL, apiURL, params);

    return _getJson(uri).then((json) => json['dsList'])
    .then((json) => json
    .map<ListItem>((item) => ListItem(item))
    .toList());
  }

  Future<dynamic> _getJson(Uri uri) async 
  {
    var response = await (await _http.getUrl(uri)).close();
    var transformedResponse = await response.transform(utf8.decoder).join();
    return json.decode(transformedResponse);
  }
}