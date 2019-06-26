import 'package:bunyang/Secret/URL.dart';
import 'package:bunyang/MenuItem/MenuItemModel.dart';
import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;

class ProductDetailModel extends MenuItemModel
{
  ProductDetailModel() : super(detailFormURL : "OCMC_LCC_SIL_AIS_R0001");

  Map<String, List<Map<String, String>>> cachedDetailInfos;

  @override
  String defaultDetailFormXml = '''<?xml version="1.0" encoding="UTF-8"?>
      <Root xmlns="http://www.nexacroplatform.com/platform/dataset">
	    <Dataset id="dsSch">
		    <ColumnInfo>
			  <Column id="CCR_CNNT_SYS_DS_CD" type="STRING" size="256"  />
			  <Column id="AIS_INF_SN" type="STRING" size="256"  />
			  <Column id="BZDT_CD" type="STRING" size="256"  />
			  <Column id="LOLD_NO" type="STRING" size="256"  />
			  <Column id="PAN_ID" type="STRING" size="256"  />
			  <Column id="PAN_TYPE" type="STRING" size="256"  />
			  <Column id="STL_BLTR_DS_CD" type="STRING" size="256"  />
			  <Column id="SL_CST_NO" type="STRING" size="256"  />
			  <Column id="STL_SST_LTR_GRP_CD" type="STRING" size="256"  />
			  <Column id="STL_LOLD_RQS_DS_CD" type="STRING" size="256"  />
			  <Column id="JNU" type="STRING" size="256"  />
			  <Column id="SNG_BID_YN" type="STRING" size="256"  />
			  <Column id="PREVIEW" type="STRING" size="256"  />
			  <Column id="LGR_NO" type="STRING" size="256"  />
			  <Column id="CST_IDN_NO" type="STRING" size="256"  />
			  <Column id="CORP_RPSV_JNU" type="STRING" size="256"  />
			  <Column id="CHK_DUP_PAN" type="STRING" size="256"  />
		  </ColumnInfo>
    </Dataset>
  </Root>''';
  
  generateRequestBody(String ccrCnntSysDsCd, String aisInfSn, String bzdtCd, String loldNo, String panId)
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

        builder.element("Col", attributes: {"id": "BZDT_CD"}, nest: ()
        {
          builder.text(bzdtCd);
        });

        builder.element("Col", attributes: {"id": "LOLD_NO"}, nest: ()
        {
          builder.text(loldNo);
        });

        builder.element("Col", attributes: {"id": "PAN_ID"}, nest: ()
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

  Future<Map<String, List<Map<String, String>>>> fetchDetailInfo(String ccrCnntSysDsCd, String aisInfSn, String bzdtCd, String loldNo, String panId) async
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
      body: generateRequestBody(ccrCnntSysDsCd, aisInfSn, bzdtCd, loldNo, panId)
    ).timeout(const Duration(seconds: 5))
    .then((res) => xml.parse(res.body))
    .then((xmlDocument) => setContextData(xmlDocument.findAllElements("Dataset")));
  }
}