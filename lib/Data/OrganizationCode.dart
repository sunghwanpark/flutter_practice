import 'package:xml/xml.dart' as xml;
import 'package:flutter/services.dart' show rootBundle;

class OrganizationCode
{
  static final OrganizationCode _instance = OrganizationCode._internal();
  factory OrganizationCode() => _instance;

  OrganizationCode._internal();

  Map<int, String> _codeNameMap = new Map<int, String>();

  String operator [](int code)
  {
    assert(_codeNameMap.containsKey(code));
    return _codeNameMap[code];
  }
  
  void parseXmlFromAssets() async 
  {
    String xmlString = await rootBundle.loadString('assets/xml/OrganizationCode.xml');

    var document = xml.parse(xmlString);
    document.findAllElements("Row").forEach((row)
    {
      int codeName = 0;
      row.findAllElements("Col").forEach((col)
      {
        if(col.getAttribute("id") == "ARA_HDQ_CD")
          codeName = int.parse(col.text);
        else if(col.getAttribute("id") == "ARA_HDQ_NM")
          _codeNameMap[codeName] = col.text;
      });
    });
  }
}