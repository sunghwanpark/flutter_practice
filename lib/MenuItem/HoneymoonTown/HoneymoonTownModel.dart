import 'package:bunyang/MenuItem/MenuItemModel.dart';
import 'package:bunyang/Secret/URL.dart';
import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;

class HoneymoonTownModel extends MenuPanInfoModel
{
  HoneymoonTownModel() : super("OCMC_LCC_SIL_SILSNOT_R0001", panInfoURL : "OCMC_LCC_NWHT_SIL_PAN_IFNO_R0001");

  String _detailURL = "OCMC_LCC_NWHT_SIL_SILSNOT_R0002";
  String _attachmentURL = "OCMC_LCC_NWHT_SIL_SILSNOT_L0003";

  String _defaultFormXml = '''<?xml version="1.0" encoding="UTF-8"?>
  <Root xmlns="http://www.nexacroplatform.com/platform/dataset">
	  <Dataset id="dsSch">
		  <ColumnInfo>
			  <Column id="PAN_ID" type="STRING" size="256"  />
			  <Column id="CCR_CNNT_SYS_DS_CD" type="STRING" size="256"  />
			  <Column id="PREVIEW" type="STRING" size="256"  />
        <Column id="OTXT_PAN_ID" type="STRING" size="256"  />
			  <Column id="UPP_AIS_TP_CD" type="STRING" size="256"  />
		  </ColumnInfo>
	  </Dataset>
  </Root>''';

  String _detailFormXml = '''<?xml version="1.0" encoding="UTF-8"?>
  <Root xmlns="http://www.nexacroplatform.com/platform/dataset">
	  <Dataset id="dsSch">
		  <ColumnInfo>
			  <Column id="PAN_ID" type="STRING" size="256"  />
        <Column id="CCR_CNNT_SYS_DS_CD" type="STRING" size="256"  />
        <Column id="AIS_INF_SN" type="STRING" size="256"  />
        <Column id="BZDT_CD" type="STRING" size="256"  />
        <Column id="HC_BLK_CD" type="STRING" size="256"  />
        <Column id="UPP_AIS_TP_CD" type="STRING" size="256"  />
        <Column id="SPL_TP_CD" type="STRING" size="256"  />
        <Column id="SSN_DS" type="STRING" size="256"  />
        <Column id="CST_IDN_NO" type="STRING" size="256"  />
        <Column id="CST_TP_CD" type="STRING" size="256"  />
        <Column id="OTXT_PAN_ID" type="STRING" size="256"  />
		  </ColumnInfo>
	  </Dataset>
  </Root>''';

  generateRequestDefaultBody(String panId, String ccrCnntSysDsCd, String otxtPanId, String uppAisTpCd) 
  {
    var document = xml.parse(_defaultFormXml);

    var builder = new xml.XmlBuilder();
    builder.element("Rows", nest: ()
    {
      builder.element("Row", nest: ()
      {
        builder.element("Col", attributes: {"id": "PAN_ID"}, nest: ()
        {
          builder.text(panId);
        });

        builder.element("Col", attributes: {"id": "CCR_CNNT_SYS_DS_CD"}, nest: ()
        {
          builder.text(ccrCnntSysDsCd);
        });

        builder.element("Col", attributes: {"id": "OTXT_PAN_ID"}, nest: ()
        {
          builder.text(otxtPanId);
        });

        builder.element("Col", attributes: {"id": "UPP_AIS_TP_CD"}, nest: ()
        {
          builder.text(uppAisTpCd);
        });

        builder.element("Col", attributes: {"id": "PREVIEW"}, nest: ()
        {
          builder.text("N");
        });
      });
    });

    var landXml = builder.build();
    var parent = document.findAllElements("Dataset");
    if(parent.length > 0)
    {
      try
      {
        var root = landXml.copy();
        var child = root.firstChild;
        child.detachParent(root);

        parent.first.children.add(child);
      }
      catch(e)
      {
        print(e);
      }
    }
    return document.toXmlString(pretty: true, indent: '\t');
  }

  generateRequestDetailBody(String panId, String ccrCnntSysDsCd, String otxtPanId, String uppAisTpCd, String aisInfSn, String bztdCd, String hcBlkCd) 
  {
    var document = xml.parse(_detailFormXml);

    var builder = new xml.XmlBuilder();
    builder.element("Rows", nest: ()
    {
      builder.element("Row", nest: ()
      {
        builder.element("Col", attributes: {"id": "PAN_ID"}, nest: ()
        {
          builder.text(panId);
        });

        builder.element("Col", attributes: {"id": "CCR_CNNT_SYS_DS_CD"}, nest: ()
        {
          builder.text(ccrCnntSysDsCd);
        });

        builder.element("Col", attributes: {"id": "OTXT_PAN_ID"}, nest: ()
        {
          builder.text(otxtPanId);
        });

        builder.element("Col", attributes: {"id": "UPP_AIS_TP_CD"}, nest: ()
        {
          builder.text(uppAisTpCd);
        });

        builder.element("Col", attributes: {"id": "AIS_INF_SN"}, nest: ()
        {
          builder.text(aisInfSn);
        });

        if(bztdCd.isNotEmpty)
        {
          builder.element("Col", attributes: {"id": "BZDT_CD"}, nest: ()
          {
            builder.text(bztdCd);
          });
        }

        if(hcBlkCd.isNotEmpty)
        {
          builder.element("Col", attributes: {"id": "HC_BLK_CD"}, nest: ()
          {
            builder.text(hcBlkCd);
          });
        }
      });
    });

    var landXml = builder.build();
    var parent = document.findAllElements("Dataset");
    if(parent.length > 0)
    {
      try
      {
        var root = landXml.copy();
        var child = root.firstChild;
        child.detachParent(root);

        parent.first.children.add(child);
      }
      catch(e)
      {
        print(e);
      }
    }
    return document.toXmlString(pretty: true, indent: '\t');
  }

  @override
  String get panInfoFormXml => '''<?xml version="1.0" encoding="UTF-8"?>
  <Root xmlns="http://www.nexacroplatform.com/platform/dataset">
	  <Dataset id="dsSch">
		  <ColumnInfo>
			  <Column id="PAN_ID" type="STRING" size="256"  />
			  <Column id="CCR_CNNT_SYS_DS_CD" type="STRING" size="256"  />
			  <Column id="PREVIEW" type="STRING" size="256"  />
			  <Column id="UPP_AIS_TP_CD" type="STRING" size="256"  />
		  </ColumnInfo>
	  </Dataset>
  </Root>''';

  Future<Map<String, List<Map<String, String>>>> fetchData(String panId, String ccrCnntSysDsCd, String otxtPanId, String uppAisTpCd) async
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
      body: generateRequestDefaultBody(panId, ccrCnntSysDsCd, otxtPanId, uppAisTpCd)
    ).timeout(const Duration(seconds: 5))
    .then((res) => xml.parse(res.body))
    .then((xmlDocument) => setContextData(xmlDocument.findAllElements("Dataset")));
  }

  Future<Map<String, List<Map<String, String>>>> fetchDetailData(String panId, String ccrCnntSysDsCd, String otxtPanId, String uppAisTpCd, String aisInfSn) async
  {
    StringBuffer stringBuffer = new StringBuffer();
    stringBuffer.write(noticeURL);
    stringBuffer.write(detailFormAdapter);
    stringBuffer.write("?&serviceID=");
    stringBuffer.write(_detailURL);

    return await http.post
    (
      stringBuffer.toString(),
      headers: {"Content-Type" : "application/xml"},
      body: generateRequestDetailBody(panId, ccrCnntSysDsCd, otxtPanId, uppAisTpCd, aisInfSn, "", "")
    ).timeout(const Duration(seconds: 5))
    .then((res) => xml.parse(res.body))
    .then((xmlDocument) => setContextData(xmlDocument.findAllElements("Dataset")));
  }

  Future<Map<String, List<Map<String, String>>>> fetchAttacementData(
    String panId, String ccrCnntSysDsCd, String otxtPanId, String uppAisTpCd, String aisInfSn, String bztdCd, String hcBlkCd) async
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
      body: generateRequestDetailBody(panId, ccrCnntSysDsCd, otxtPanId, uppAisTpCd, aisInfSn, bztdCd, hcBlkCd)
    ).timeout(const Duration(seconds: 5))
    .then((res) => xml.parse(res.body))
    .then((xmlDocument) => setContextData(xmlDocument.findAllElements("Dataset")));
  }
}