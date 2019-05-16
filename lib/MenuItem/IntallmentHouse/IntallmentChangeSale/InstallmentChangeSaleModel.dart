import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/Secret/URL.dart';
import 'package:bunyang/MenuItem/MenuItemModel.dart';
import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;

class InstallmentChangeSaleModel extends MenuPanInfoModel
{
  InstallmentChangeSaleModel() : super('OCMC_LCC_SIL_SILSNOT_R0006');
  
  String _supplyTabServiceId = 'OCMC_LCC_SIL_SILSNOT_L0014';
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

  generateDetailBody(String panId, String ccrCnntSysDsCd)
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

  generateServiceBody(String panId, String ccrCnntSysDsCd, String sbdLgoNo, String ltrNot, String ltrUntNo, String sn)
  {
    var document = xml.parse(_supplyTabDetailFormXml);

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

        builder.element("Col", attributes: {"id": "SBD_LGO_NO"}, nest: ()
        {
          builder.text(sbdLgoNo);
        });

        builder.element("Col", attributes: {"id": "LTR_NOT"}, nest: ()
        {
          builder.text(ltrNot);
        });

        builder.element("Col", attributes: {"id": "LTR_UNT_NO"}, nest: ()
        {
          builder.text(ltrUntNo);
        });

        builder.element("Col", attributes: {"id": "SN"}, nest: ()
        {
          builder.text(sn);
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

  Future<Map<String, List<Map<String, String>>>> fetchData(Notice_Code noticeCode, String panId, String ccrCnntSysDsCd) async
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
      body: generateDetailBody(panId, ccrCnntSysDsCd)
    ).timeout(const Duration(seconds: 5))
    .then((res) => xml.parse(res.body))
    .then((xmlDocument) => setContextData(xmlDocument.findAllElements("Dataset")));
  }

  Future<Map<String, List<Map<String, String>>>> fetchHouseType(String panId, String ccrCnntSysDsCd, String sbdLgoNo, String ltrNot, String ltrUntNo, String sn, bool isAttachment) async
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
      body: generateServiceBody(panId, ccrCnntSysDsCd, sbdLgoNo, ltrNot, ltrUntNo, sn)
    ).timeout(const Duration(seconds: 5))
    .then((res) => xml.parse(res.body))
    .then((xmlDocument) => setContextData(xmlDocument.findAllElements("Dataset")));
  }

  @override
  String get panInfoFormXml => null;

  @override
  generateRequestPanInfoBody(RequestPanInfo requestPanInfo) {
    // TODO: implement generateRequestPanInfoBody
    return null;
  }
}