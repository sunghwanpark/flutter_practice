import 'package:bunyang/Data/Address.dart';

class ListItem
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

  factory ListItem(Map jsonMap) =>
      ListItem._internalFromJson(jsonMap);

  ListItem._internalFromJson(Map jsonMap)
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
}