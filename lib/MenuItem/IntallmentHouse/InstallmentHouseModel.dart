import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/Secret/URL.dart';
import 'package:bunyang/MenuItem/MenuItemModel.dart';
import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;

class InstallmentHouseModel extends MenuPanInfoModel
{
  InstallmentHouseModel() : super("OCMC_LCC_SIL_SILSNOT_R0001");

  String _supplyServiceId = 'OCMC_LCC_SIL_SILSNOT_L0002';
  String _supplyAttachmentId = 'OCMC_LCC_SIL_SILSNOT_L0003';

  Map<String, List<Map<String, String>>> cachedLandInfos;

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

  @override
  String defaultDetailFormXml ='''<?xml version="1.0" encoding="UTF-8"?>
    <Root xmlns="http://www.nexacroplatform.com/platform/dataset">
	    <Dataset id="dsSch">
		    <ColumnInfo>
			    <Column id="PAN_ID" type="STRING" size="256"  />
			    <Column id="CCR_CNNT_SYS_DS_CD" type="STRING" size="256"  />
			    <Column id="PREVIEW" type="STRING" size="256"  />
			    <Column id="OTXT_PAN_ID" type="STRING" size="256"  />
			    <Column id="UPP_AIS_TP_CD" type="STRING" size="256"  />
			    <Column id="TMP_PAN_SS" type="STRING" size="256"  />
		    </ColumnInfo>
      </Dataset>
    </Root>''';

  String supplyInfoFormXml ='''<?xml version="1.0" encoding="UTF-8"?>
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
          <Column id="DYNAMIC_SPL_TP_CD_0708" type="STRING" size="256"  />
          <Column id="DYNAMIC_SPL_TP_CD_11" type="STRING" size="256"  />
          <Column id="OTXT_PAN_ID" type="STRING" size="256"  />
		    </ColumnInfo>
      </Dataset>
    </Root>''';

  generateDetailBody(String panId, String ccrCnntSysDsCd, String otxtPanId, String uppAisTpCd)
  {
    var document = xml.parse(defaultDetailFormXml);

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
        assert(() 
        {
          print(e);
          return true;
        }());
      }
    }
    return document.toXmlString(pretty: true, indent: '\t');
  }

  generateSupplyInfoBody(String panId, String ccrCnntSysDsCd, String aisInfSn, String otxtPanId, String uppAisTpCd, [bool dynamic0708 = false, bool dynamic11 = false])
  {
    var document = xml.parse(supplyInfoFormXml);

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

        builder.element("Col", attributes: {"id": "AIS_INF_SN"}, nest: ()
        {
          builder.text(aisInfSn);
        });

        builder.element("Col", attributes: {"id": "OTXT_PAN_ID"}, nest: ()
        {
          builder.text(otxtPanId);
        });

        builder.element("Col", attributes: {"id": "UPP_AIS_TP_CD"}, nest: ()
        {
          builder.text(uppAisTpCd);
        });

        if(dynamic0708)
        {
          builder.element("Col", attributes: {"id": "DYNAMIC_SPL_TP_CD_0708"}, nest: ()
          {
            builder.text("0708");
          });
        }
        if(dynamic11)
        {
          builder.element("Col", attributes: {"id": "DYNAMIC_SPL_TP_CD_11"}, nest: ()
          {
            builder.text("11");
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
        assert(() 
        {
          print(e);
          return true;
        }());
      }
    }
    return document.toXmlString(pretty: true, indent: '\t');
  }

  generateSupplyInfoImageBody(String panId, String ccrCnntSysDsCd, String aisInfSn, String otxtPanId, String uppAisTpCd, String bzdtCd, String hcBlkCd)
  {
    var document = xml.parse(supplyInfoFormXml);

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

        builder.element("Col", attributes: {"id": "AIS_INF_SN"}, nest: ()
        {
          builder.text(aisInfSn);
        });

        builder.element("Col", attributes: {"id": "OTXT_PAN_ID"}, nest: ()
        {
          builder.text(otxtPanId);
        });

        builder.element("Col", attributes: {"id": "UPP_AIS_TP_CD"}, nest: ()
        {
          builder.text(uppAisTpCd);
        });
        
        builder.element("Col", attributes: {"id": "BZDT_CD"}, nest: ()
        {
          builder.text(bzdtCd);
        });
        
        builder.element("Col", attributes: {"id": "HC_BLK_CD"}, nest: ()
        {
          builder.text(hcBlkCd);
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
        assert(() 
        {
          print(e);
          return true;
        }());
      }
    }
    return document.toXmlString(pretty: true, indent: '\t');
  }

  Future<Map<String, List<Map<String, String>>>> fetchData(Notice_Code noticeCode, String panId, String ccrCnntSysDsCd, String otxtPanId, String uppAisTpCd) async
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
      body: generateDetailBody(panId, ccrCnntSysDsCd, otxtPanId, uppAisTpCd)
    ).timeout(const Duration(seconds: 5))
    .then((res) => xml.parse(res.body))
    .then((xmlDocument) => setContextData(xmlDocument.findAllElements("Dataset")));
  }

  Future<Map<String, List<Map<String, String>>>> fetchSupplyInfo(String panId, String ccrCnntSysDsCd, String aisInfSn, String otxtPanId, String uppAisTpCd, [bool dynamic0708 = false, bool dynamic11 = false]) async
  {
    StringBuffer stringBuffer = new StringBuffer();
    stringBuffer.write(noticeURL);
    stringBuffer.write(detailFormAdapter);
    stringBuffer.write("?&serviceID=");
    stringBuffer.write(_supplyServiceId);

    return await http.post
    (
      stringBuffer.toString(),
      headers: {"Content-Type" : "application/xml"},
      body: generateSupplyInfoBody(panId, ccrCnntSysDsCd, aisInfSn, otxtPanId, uppAisTpCd, dynamic0708, dynamic11)
    ).timeout(const Duration(seconds: 5))
    .then((res) => xml.parse(res.body))
    .then((xmlDocument) => setContextData(xmlDocument.findAllElements("Dataset")));
  }

  Future<Map<String, List<Map<String, String>>>> fetchSupplyInfoImage(String panId, String ccrCnntSysDsCd, String aisInfSn, String otxtPanId, String uppAisTpCd, String bzdtCd, String hcBlkCd) async
  {
    StringBuffer stringBuffer = new StringBuffer();
    stringBuffer.write(noticeURL);
    stringBuffer.write(detailFormAdapter);
    stringBuffer.write("?&serviceID=");
    stringBuffer.write(_supplyAttachmentId);

    return await http.post
    (
      stringBuffer.toString(),
      headers: {"Content-Type" : "application/xml"},
      body: generateSupplyInfoImageBody(panId, ccrCnntSysDsCd, aisInfSn, otxtPanId, uppAisTpCd, bzdtCd, hcBlkCd)
    ).timeout(const Duration(seconds: 5))
    .then((res) => xml.parse(res.body))
    .then((xmlDocument) => setContextData(xmlDocument.findAllElements("Dataset")));
  }
}