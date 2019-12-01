import 'package:bunyang/MenuItem/MenuItemModel.dart';
import 'package:bunyang/Secret/URL.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class LeaseHouseChildrenModel extends MenuPanInfoModel
{
  LeaseHouseChildrenModel() : super('OCMC_LCC_SIL_SILSNOT_R0015');
  
  String _supplyTabServiceId = 'OCMC_LCC_SIL_SILSNOT_L0013';
  String _supplyTabAttachmentId = 'OCMC_LCC_SIL_SILSNOT_L0009';

  @override
  String defaultDetailFormXml ='''<?xml version="1.0" encoding="UTF-8"?>
    <Root xmlns="http://www.nexacroplatform.com/platform/dataset">
	    <Dataset id="dsSch">
		    <ColumnInfo>
			    <Column id="PAN_ID" type="STRING" size="256"  />
			    <Column id="CCR_CNNT_SYS_DS_CD" type="STRING" size="256"  />
			    <Column id="PREVIEW" type="STRING" size="256"  />
		    </ColumnInfo>
      </Dataset>
    </Root>''';

  String _supplyTabDetailFormXml ='''<?xml version="1.0" encoding="UTF-8"?>
    <Root xmlns="http://www.nexacroplatform.com/platform/dataset">
	    <Dataset id="dsSch">
		    <ColumnInfo>
			    <Column id="PAN_ID" type="STRING" size="256"  />
			    <Column id="CCR_CNNT_SYS_DS_CD" type="STRING" size="256"  />
			    <Column id="AIS_INF_SN" type="STRING" size="256"  />
			    <Column id="SBD_LGO_NO" type="STRING" size="256"  />
			    <Column id="LTR_NOT" type="STRING" size="256"  />
			    <Column id="LTR_UNT_NO" type="STRING" size="256"  />
			    <Column id="SN" type="STRING" size="256"  />
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

  Future<Map<String, List<Map<String, String>>>> fetchHouseType(Map<String, String> params, bool isAttachment) async
  {
    StringBuffer stringBuffer = new StringBuffer();
    stringBuffer.write(noticeURL);
    stringBuffer.write(detailFormAdapter);
    stringBuffer.write("?&serviceID=");
    stringBuffer.write(isAttachment ? _supplyTabAttachmentId : _supplyTabServiceId);

    return await http.post
    (
      stringBuffer.toString(),
      headers: {"Content-Type" : "application/xml"},
      body: generateXmlBody(_supplyTabDetailFormXml, params)
    ).timeout(const Duration(seconds: 5))
    .then((res) => xml.parse(res.body))
    .then((xmlDocument) => setContextData(xmlDocument.findAllElements("Dataset")));
  }
  
  @override
  String get panInfoFormXml => null;
}