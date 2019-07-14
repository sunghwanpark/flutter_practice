import 'package:bunyang/MenuItem/MenuItemModel.dart';
import 'package:bunyang/Secret/URL.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class StoreBidInquiryModel extends MenuItemModel
{
  StoreBidInquiryModel() : super(detailFormURL : "OCMC_LCC_SIL_AIS_R0003");

  @override
  String defaultDetailFormXml = '''<?xml version="1.0" encoding="UTF-8"?>
    <Root xmlns="http://www.nexacroplatform.com/platform/dataset">
	    <Dataset id="dsSch">
		    <ColumnInfo>
			    <Column id="CCR_CNNT_SYS_DS_CD" type="STRING" size="256"  />
          <Column id="PAN_ID" type="STRING" size="256"  />
          <Column id="AIS_INF_SN" type="STRING" size="256"  />
          <Column id="DNG_SN" type="STRING" size="256"  />
          <Column id="SBD_NO" type="STRING" size="256"  />
          <Column id="SSDH_SL_ADM_NO" type="STRING" size="256"  />
          <Column id="SL_CST_NO" type="STRING" size="256"  />
          <Column id="PR1_SH1_RST_YN" type="STRING" size="256"  />
          <Column id="JNU" type="STRING" size="256"  />
          <Column id="TOY" type="STRING" size="256"  />
          <Column id="PREVIEW" type="STRING" size="256"  />
          <Column id="HC_BLK_CD" type="STRING" size="256"  />
          <Column id="BZDT_CD" type="STRING" size="256"  />
		    </ColumnInfo>''';
  
  Future<Map<String, List<Map<String, String>>>> fetchData(Map<String, String> params) async
  {
    StringBuffer stringBuffer = new StringBuffer();
    stringBuffer.write(noticeURL);
    stringBuffer.write(detailFormAdapter);
    stringBuffer.write("?&serviceID=");
    stringBuffer.write(detailFormURL);

    return await http.post
    (
      stringBuffer.toString(),
      headers: {"Content-Type" : "application/xml"},
      body: generateXmlBody(defaultDetailFormXml, params)
    ).timeout(const Duration(seconds: 5))
    .then((res) => xml.parse(res.body))
    .then((xmlDocument) => setContextData(xmlDocument.findAllElements("Dataset")));
  }
}