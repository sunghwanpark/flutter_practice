import 'dart:convert';

import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/Secret/URL.dart';
import 'package:http/http.dart' as http;

class MenuData
{
  Notice_Code type;
  String typeString;
  String startDate;
  String closeDate;
  String panState;
  String panName;
  String locateName;
  String detailNoticeCode;
  String detailURL;
  String rNum;

  factory MenuData(Map jsonMap) =>
      MenuData._internalFromJson(jsonMap);

  MenuData._internalFromJson(Map jsonMap)
      : type = getNoticeType(jsonMap['UPP_AIS_TP_NM']),
      typeString = jsonMap['UPP_AIS_TP_NM'],
      startDate = jsonMap['PAN_NT_ST_DT'],
      closeDate = jsonMap['CLSG_DT'],
      panState = jsonMap['PAN_SS'],
      panName = jsonMap['PAN_NM'],
      locateName = jsonMap['CNP_CD_NM'],
      detailNoticeCode = jsonMap['AIS_TP_CD_NM'],
      detailURL = jsonMap['DTL_URL'],
      rNum = jsonMap['RNUM'];

  MenuItemType getServiceType()
  {
    int findIdx = detailURL.lastIndexOf("gv_url=");
    String subString = detailURL.substring(findIdx, findIdx + 30);
    if(subString.contains("0040"))
      return MenuItemType.land;
    else if(subString.contains("0050"))
      return MenuItemType.installment_house;
    else if(subString.contains("0062"))
      return MenuItemType.installment_change_sale;

    return MenuItemType.land;
  }

  getParameter(String param)
  {
    int findIdx = detailURL.lastIndexOf("gv_param=");
    String subString = detailURL.substring(findIdx);
    var splitData = subString.split(',');

    var panId = splitData
    .where((str) => str.contains(param))
    .first
    .split(':');

    return panId[1];
  }

  getUppAisTPCD()
  {
    assert(detailURL.contains('gv_menuId'));

    var menuId = detailURL.split('&')
    .firstWhere((str) => str.contains('gv_menuId'))
    .split('=')
    .toList()[1];

    return menuId == '1010202' ? "05" : "06";
  }
}

class MenuModel
{
  Future<List<MenuData>> fetch(String code) async
  {
    String url = noticeURL + apiURL;
    url = url + "?" + "apiKey=" + api_key;
    url = url + "&PG_SZ=100";
    url = url + "&PAGE=1";
    url = url + "&PAN_SS=접수마감";
    url = url + "&UPP_AIS_TP_CD=" + code;

    return await http.post(url)
      .timeout(const Duration(seconds: 5))
      .then((res) => json.decode(res.body)[1]["dsList"])
      .then((json) => json.map<MenuData>((item) => MenuData(item))
      .toList());
  }
}