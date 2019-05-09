import 'package:bunyang/Secret/URL.dart';
import 'package:bunyang/MenuItem/MenuItemModel.dart';
import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;

class ContractScheduleModel extends MenuItemModel
{
  ContractScheduleModel() : super("OCMC_LCC_SIL_AIS_R0002");

  @override
  String defaultDetailFormXml = '''<?xml version="1.0" encoding="UTF-8"?>
      <Root xmlns="http://www.nexacroplatform.com/platform/dataset">
	    <Dataset id="dsSch">
		    <ColumnInfo>
			  <Column id="CCR_CNNT_SYS_DS_CD" type="STRING" size="256"  />
			  <Column id="AIS_INF_SN" type="STRING" size="256"  />
		  </ColumnInfo>
    </Dataset>
  </Root>''';
  
  generateRequestBody(String ccrCnntSysDsCd, String aisInfSn)
  {
    var document = xml.parse(defaultDetailFormXml);

    var builder = new xml.XmlBuilder();
    builder.element("Rows", nest: ()
    {
      builder.element("Row", nest: ()
      {
        builder.element("Col", attributes: {"id": "CCR_CNNT_SYS_DS_CD"}, nest: ()
        {
          builder.text(ccrCnntSysDsCd);
        });

        builder.element("Col", attributes: {"id": "AIS_INF_SN"}, nest: ()
        {
          builder.text(aisInfSn);
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

  Future<Map<String, List<Map<String, String>>>> fetchContractInfo(String ccrCnntSysDsCd, String aisInfSn) async
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
      body: generateRequestBody(ccrCnntSysDsCd, aisInfSn)
    ).timeout(const Duration(seconds: 5))
    .then((res) => xml.parse(res.body))
    .then((xmlDocument) => setContextData(xmlDocument.findAllElements("Dataset")));
  }

  @override
  generateRequestPanInfoBody(String panId, String ccrCnntSysDsCd) {
    // TODO: implement generateRequestPanInfoBody
    return null;
  }
}