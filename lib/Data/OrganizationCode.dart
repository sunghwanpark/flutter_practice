import 'package:xml/xml.dart' as xml;
import 'package:flutter/services.dart' show rootBundle;

class OrganizationCode
{
  static final OrganizationCode _instance = OrganizationCode._internal();
  factory OrganizationCode() => _instance;

  OrganizationCode._internal();

  Map<int, String> _codeNameMap = new Map<int, String>();

  String getCodeName(int code)
  {
    assert(_codeNameMap.containsKey(code));

    return _codeNameMap[code];
  }

  Future<xml.XmlDocument> parseXmlFromAssets(String assetsPath) async 
  {
    print('--- Parse xml from: $assetsPath');
    String xmlString = await rootBundle.loadString(assetsPath);

    return xml.parse(xmlString);
  }

  void loadXml()
  {
    parseXmlFromAssets('assets/xml/OrganizationCode.xml')
      .then((document)
      {
        var iterator = document.findAllElements("Row");
        iterator.forEach((row)
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
      });
  }
}