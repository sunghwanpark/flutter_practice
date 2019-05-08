import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/Data/URL.dart';
import 'package:bunyang/MenuItem/MenuItemModel.dart';
import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;

class InstallmentHouseModel extends MenuPanInfoModel
{
  InstallmentHouseModel() : super("OCMC_LCC_SIL_SILSNOT_R0001");

  Map<String, List<Map<String, String>>> cachedLandInfos;

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

        builder.element("Col", attributes: {"id": "UPP_AIS_TP_CD"}, nest: ()
        {
          builder.text(requestPanInfo.uppAisTpCd);
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
}