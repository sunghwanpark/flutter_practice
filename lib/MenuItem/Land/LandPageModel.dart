import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/Secret/URL.dart';
import 'package:bunyang/MenuItem/MenuItemModel.dart';
import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;

class LandPageModel extends MenuPanInfoModel
{
  LandPageModel() : super("OCMC_LCC_SIL_SILSNOT_L0004");

  Map<String, List<Map<String, String>>> cachedLandInfos;

  @override
  String get panInfoFormXml => '''<?xml version="1.0" encoding="UTF-8"?>
  <Root xmlns="http://www.nexacroplatform.com/platform/dataset">
	  <Dataset id="dsSch">
		  <ColumnInfo>
			  <Column id="PAN_ID" type="STRING" size="256"  />
			  <Column id="CCR_CNNT_SYS_DS_CD" type="STRING" size="256"  />
			  <Column id="PAN_LOLD_TYPE" type="STRING" size="256"  />
			  <Column id="PREVIEW" type="STRING" size="256"  />
			  <Column id="TRET_PAN_ID" type="STRING" size="256"  />
		  </ColumnInfo>
	  </Dataset>
  </Root>''';

  @override
  generateRequestPanInfoBody(RequestPanInfo requestPanInfo)
  {
    var document = xml.parse(panInfoFormXml);

    var builder = new xml.XmlBuilder();
    builder.element("Rows", nest: ()
    {
      builder.element("Row", nest: ()
      {
        builder.element("Col", attributes: {"id": "PAN_ID"}, nest: ()
        {
          builder.text(requestPanInfo.panId);
        });

        builder.element("Col", attributes: {"id": "CCR_CNNT_SYS_DS_CD"}, nest: ()
        {
          builder.text(requestPanInfo.ccrCnntSysDsCd);
        });

        builder.element("Col", attributes: {"id": "PAN_LOLD_TYPE"}, nest: ()
        {
          builder.text(requestPanInfo.ccrCnntSysDsCd);
        });

        builder.element("Col", attributes: {"id": "TRET_PAN_ID"}, nest: ()
        {
          builder.text(requestPanInfo.panId);
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

  generateDetailBody(String panId, String ccrCnntSysDsCd, String panKDCD, String otxtPanId)
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

        builder.element("Col", attributes: {"id": "PAN_LOLD_TYPE"}, nest: ()
        {
          builder.text(ccrCnntSysDsCd);
        });

        builder.element("Col", attributes: {"id": "PAN_KD_CD"}, nest: ()
        {
          builder.text(panKDCD);
        });

        builder.element("Col", attributes: {"id": "OTXT_PAN_ID"}, nest: ()
        {
          builder.text(otxtPanId);
        });

        builder.element("Col", attributes: {"id": "TRET_PAN_ID"}, nest: ()
        {
          builder.text(panId);
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

  Map<String, List<Map<String, String>>> getSupplyDate(Iterable<xml.XmlElement> iterator)
  {
    cachedLandInfos = setContextData(iterator);
    return cachedLandInfos;
  }

  Future<Map<String, List<Map<String, String>>>> fetchData(Notice_Code noticeCode, String panId, String ccrCnntSysDsCd, String panKDCD, String otxtPanId) async
  {
    StringBuffer stringBuffer = new StringBuffer();
    stringBuffer.write(noticeURL);
    stringBuffer.write(detailFormUrl);
    stringBuffer.write("?&serviceID=");
    stringBuffer.write(detailForm);

    return await http.post
    (
      stringBuffer.toString(),
      headers: {"Content-Type" : "application/xml"},
      body: generateDetailBody(panId, ccrCnntSysDsCd, panKDCD, otxtPanId)
    ).timeout(const Duration(seconds: 5))
    .then((res) => xml.parse(res.body))
    .then((xmlDocument) => getSupplyDate(xmlDocument.findAllElements("Dataset")));
  }
}