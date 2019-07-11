import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/Secret/URL.dart';
import 'package:meta/meta.dart';
import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;

class RequestPanInfo
{
  RequestPanInfo(this.panId, this.ccrCnntSysDsCd, this.uppAisTpCd);

  final String panId;
  final String ccrCnntSysDsCd;
  final String uppAisTpCd;
}

abstract class MenuItemModel
{
  MenuItemModel(
    {
      @required this.detailFormURL
    }
  );

  final String detailFormURL;
  final String detailFormAdapter = "/lhCmcNoSessionAdapter.lh";

  @protected
  String defaultDetailFormXml ='''<?xml version="1.0" encoding="UTF-8"?>
    <Root xmlns="http://www.nexacroplatform.com/platform/dataset">
	    <Dataset id="dsSch">
		    <ColumnInfo>
			    <Column id="PAN_ID" type="STRING" size="256"  />
			    <Column id="CCR_CNNT_SYS_DS_CD" type="STRING" size="256"  />
			    <Column id="PG_SZ" type="STRING" size="256"  />
			    <Column id="PAGE" type="STRING" size="256"  />
			    <Column id="PAN_LOLD_TYPE" type="STRING" size="256"  />
			    <Column id="PREVIEW" type="STRING" size="256"  />
			    <Column id="PAN_KD_CD" type="STRING" size="256"  />
			    <Column id="OTXT_PAN_ID" type="STRING" size="256"  />
			    <Column id="TRET_PAN_ID" type="STRING" size="256"  />
			    <Column id="TMP_PAN_SS" type="STRING" size="256"  />
		    </ColumnInfo>
      </Dataset>
    </Root>''';

  Map<String, List<Map<String, String>>> setContextData(Iterable<xml.XmlElement> iterator)
  {
    Map<String, List<Map<String, String>>> res = new Map<String, List<Map<String, String>>>();

    iterator.forEach((elem)
      {
        var id = elem.getAttribute('id');
        elem.findAllElements('Rows')
          .forEach((rows)
          {
            res[id] = new List<Map<String, String>>();
            rows.findAllElements("Row")
              .forEach((row)
              {
                Map<String, String> infoMap = new Map<String, String>();
                row.findElements("Col").forEach((col)
                {
                  infoMap[col.getAttribute("id")] = col.text;
                });

                res[id].add(infoMap);
              });
          });
      });

    return res;
  }

  generateXmlBody(String form, Map<String, String> params)
  {
    var document = xml.parse(form);

    var builder = new xml.XmlBuilder();
    builder.element("Rows", nest: ()
    {
      builder.element("Row", nest: ()
      {
        params.forEach((key, value)
        {
          builder.element("Col", attributes: {"id": key}, nest: ()
          {
            builder.text(value);
          });
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
}

abstract class MenuPanInfoModel extends MenuItemModel
{
  MenuPanInfoModel(String detailForm,
    {
      String panInfoURL = "OCMC_LCC_SIL_PAN_IFNO_R0001"
    }) : _requestPanInfo = panInfoURL, super(detailFormURL : detailForm);

  final String _requestPanInfo;

  @protected
  String get panInfoFormXml;

  @protected
  generateRequestPanInfoBody(Map<String, String> requestPanInfos)
  {
    return generateXmlBody(panInfoFormXml, requestPanInfos);
  }

  @protected
  Map<String, String> getPanInfo(Iterable<xml.XmlElement> iterator)
  {
    var res = this.setContextData(iterator);
    return res["dsPanInfo"].first;
  }

  Future<Map<String, String>> fetchPanInfo(Notice_Code noticeCode, Map<String, String> requestPanInfos) async
  {
    StringBuffer stringBuffer = new StringBuffer();
    stringBuffer.write(noticeURL);
    stringBuffer.write(detailFormAdapter);
    stringBuffer.write("?&serviceID=");
    stringBuffer.write(_requestPanInfo);

    return await http.post
    (
      stringBuffer.toString(),
      headers: {"Content-Type" : "application/xml"},
      body: generateRequestPanInfoBody(requestPanInfos)
    ).timeout(const Duration(seconds: 5))
    .then((res) => xml.parse(res.body))
    .then((xmlDocument) => getPanInfo(xmlDocument.findAllElements("Dataset")));
  }
}