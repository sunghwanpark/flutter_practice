import 'package:bunyang/MenuItem/MenuItemModel.dart';
import 'package:bunyang/Secret/URL.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class StoreBidModel extends MenuPanInfoModel
{
  StoreBidModel() : super("OCMC_LCC_SIL_SILSNOT_R0004");

  String _attachmentURL = 'OCMC_LCC_SIL_SILSNOT_L0005';

  String _detailStoreDataURL = 'OCMC_LCC_SIL_SILSNOT_L0006';
  String _detailStoreElemDataURL = 'OCMC_LCC_SST_PBU_DNG_PAN_L0001';
  String _detailStoreImageURL = 'OCMC_LCC_SIL_SST_DNG_AHFL_L0001';

  @override
  String get panInfoFormXml => '''<?xml version="1.0" encoding="UTF-8"?>
  <Root xmlns="http://www.nexacroplatform.com/platform/dataset">
	  <Dataset id="dsSch">
		  <ColumnInfo>
			  <Column id="PAN_ID" type="STRING" size="256"  />
        <Column id="CCR_CNNT_SYS_DS_CD" type="STRING" size="256"  />
        <Column id="PREVIEW" type="STRING" size="256"  />
        <Column id="PAN_KD_CD" type="STRING" size="256"  />
        <Column id="OTXT_PAN_ID" type="STRING" size="256"  />
        <Column id="TRET_PAN_ID" type="STRING" size="256"  />
        <Column id="TMP_PAN_SS" type="STRING" size="256"  />
		  </ColumnInfo>
	  </Dataset>
  </Root>''';

  String _detailStoreForm = '''<?xml version="1.0" encoding="UTF-8"?>
  <Root xmlns="http://www.nexacroplatform.com/platform/dataset">
	  <Dataset id="dsSch">
		  <ColumnInfo>
			  <Column id="PAN_ID" type="STRING" size="256"  />
        <Column id="CCR_CNNT_SYS_DS_CD" type="STRING" size="256"  />
        <Column id="AIS_INF_SN" type="STRING" size="256"  />
        <Column id="BZDT_CD" type="STRING" size="256"  />
        <Column id="HC_BLK_CD" type="STRING" size="256"  />
        <Column id="DNG_SN" type="STRING" size="256"  />
        <Column id="SBD_NO" type="STRING" size="256"  />
        <Column id="SL_CST_NO" type="STRING" size="256"  />
        <Column id="SSDH_SL_ADM_NO" type="STRING" size="256"  />
        <Column id="CST_IDN_NO" type="STRING" size="256"  />
        <Column id="R1_SH1_RST_YN" type="STRING" size="256"  />
        <Column id="JNU" type="STRING" size="256"  />
        <Column id="TOY" type="STRING" size="256"  />
        <Column id="PAN_KD_CD" type="STRING" size="256"  />
        <Column id="TRET_PAN_ID" type="STRING" size="256"  />
        <Column id="OTXT_PAN_ID" type="STRING" size="256"  />
		  </ColumnInfo>
	  </Dataset>
  </Root>''';

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

  Future<Map<String, List<Map<String, String>>>> fetchAttachmentData(Map<String, String> params) async
  {
    StringBuffer stringBuffer = new StringBuffer();
    stringBuffer.write(noticeURL);
    stringBuffer.write(detailFormAdapter);
    stringBuffer.write("?&serviceID=");
    stringBuffer.write(_attachmentURL);

    return await http.post
    (
      stringBuffer.toString(),
      headers: {"Content-Type" : "application/xml"},
      body: generateXmlBody(defaultDetailFormXml, params)
    ).timeout(const Duration(seconds: 5))
    .then((res) => xml.parse(res.body))
    .then((xmlDocument) => setContextData(xmlDocument.findAllElements("Dataset")));
  }

  Future<Map<String, List<Map<String, String>>>> fetchStoreData(Map<String, String> params) async
  {
    StringBuffer stringBuffer = new StringBuffer();
    stringBuffer.write(noticeURL);
    stringBuffer.write(detailFormAdapter);
    stringBuffer.write("?&serviceID=");
    stringBuffer.write(_detailStoreDataURL);

    return await http.post
    (
      stringBuffer.toString(),
      headers: {"Content-Type" : "application/xml"},
      body: generateXmlBody(_detailStoreForm, params)
    ).timeout(const Duration(seconds: 5))
    .then((res) => xml.parse(res.body))
    .then((xmlDocument) => setContextData(xmlDocument.findAllElements("Dataset")));
  }

  Future<Map<String, List<Map<String, String>>>> fetchStoreElemData(Map<String, String> params) async
  {
    StringBuffer stringBuffer = new StringBuffer();
    stringBuffer.write(noticeURL);
    stringBuffer.write(detailFormAdapter);
    stringBuffer.write("?&serviceID=");
    stringBuffer.write(_detailStoreElemDataURL);

    return await http.post
    (
      stringBuffer.toString(),
      headers: {"Content-Type" : "application/xml"},
      body: generateXmlBody(_detailStoreForm, params)
    ).timeout(const Duration(seconds: 5))
    .then((res) => xml.parse(res.body))
    .then((xmlDocument) => setContextData(xmlDocument.findAllElements("Dataset")));
  }

  Future<Map<String, List<Map<String, String>>>> fetchStoreImageData(Map<String, String> params) async
  {
    StringBuffer stringBuffer = new StringBuffer();
    stringBuffer.write(noticeURL);
    stringBuffer.write(detailFormAdapter);
    stringBuffer.write("?&serviceID=");
    stringBuffer.write(_detailStoreImageURL);

    return await http.post
    (
      stringBuffer.toString(),
      headers: {"Content-Type" : "application/xml"},
      body: generateXmlBody(_detailStoreForm, params)
    ).timeout(const Duration(seconds: 5))
    .then((res) => xml.parse(res.body))
    .then((xmlDocument) => setContextData(xmlDocument.findAllElements("Dataset")));
  }
}