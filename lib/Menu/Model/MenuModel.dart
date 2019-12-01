import 'dart:convert';

import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/Secret/URL.dart';
import 'package:http/http.dart' as http;

class MenuData
{
  Notice_Code type;
  Map<String, String> _dataMap;

  factory MenuData(Map jsonMap) =>
      MenuData._internalFromJson(jsonMap);

  MenuData._internalFromJson(Map jsonMap)
  {
    type = getNoticeType(jsonMap['UPP_AIS_TP_NM']);
    _dataMap = Map.from(jsonMap);
  }

  MenuItemType getServiceType()
  {
    if(getUppAisTPCD() == '06')
    {
      if(_dataMap['AIS_TP_CD'] == '40' && _dataMap['CCR_CNNT_SYS_DS_CD'] == '03')
        return MenuItemType.lease_house_children;
    }
    String detailURL = _dataMap['DTL_URL'];

    int findIdx = detailURL.lastIndexOf("gv_url=");
    String subString = detailURL.substring(findIdx, findIdx + 30);
    if(subString.contains("0040"))
      return MenuItemType.land;
    else if(subString.contains("0050") || subString.contains("0051"))
      return MenuItemType.installment_house;
    else if(subString.contains("0062"))
      return MenuItemType.installment_change_sale;
    else if(subString.contains("0060") || subString.contains("0065"))
      return MenuItemType.lease_house_installment;
    else if(subString.contains("9910"))
      return MenuItemType.honeymoon_lease;
    else if(subString.contains("0070"))
      return MenuItemType.all_lease;
    else if(subString.contains("0080"))
      return MenuItemType.store_bid;
    else if(subString.contains("1080"))
      return MenuItemType.store_draw;
    else if(subString.contains("1200"))
      return MenuItemType.store_evaluation;

    return MenuItemType.land;
  }

  getParameter(String param)
  {
    String detailURL = _dataMap['DTL_URL'];

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
    return _dataMap['UPP_AIS_TP_CD'];
  }

  getDetailNoticeCode()
  {
    return _dataMap['AIS_TP_CD_NM'];
  }

  getPanName()
  {
    return _dataMap['PAN_NM'];
  }

  getPanState()
  {
    return _dataMap['PAN_SS'];
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
    url = url + "&UPP_AIS_TP_CD=" + code;

    return await http.post(url)
      .timeout(const Duration(seconds: 5))
      .then((res) => json.decode(res.body)[1]["dsList"])
      .then((json) => json.map<MenuData>((item) => MenuData(item))
      .toList());
  }
}