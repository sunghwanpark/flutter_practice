import 'package:bunyang/Data/Address.dart';
import 'package:xml/xml.dart' as xml;

const String noticeURL = "https://apply.lh.or.kr";
const String apiURL = "/RCMC_LCC_SIL_SILSNOT_L0001.jsp";
const String api_key = "SIELqdq7WDfAldOvf352OQ";

const String detailFormUrl = "/lhCmcNoSessionAdapter.lh";

const String defaultDetailFormXml =
'''<?xml version="1.0" encoding="UTF-8"?>
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

final detailFormMaps = const
{
  Notice_Code.land : "OCMC_LCC_SIL_SILSNOT_L0004"
};

generateDetailBody(Notice_Code notice_code, String panId, [String ccr_cnnt_sys_ds_cd = "", String upp_ais_tp_cd = ""])
{
  var document = xml.parse(defaultDetailFormXml);

  if(notice_code == Notice_Code.land)
  {
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
          builder.text(ccr_cnnt_sys_ds_cd);
        });

        builder.element("Col", attributes: {"id": "PAN_LOLD_TYPE"}, nest: ()
        {
          builder.text(ccr_cnnt_sys_ds_cd);
        });

        builder.element("Col", attributes: {"id": "PAN_KD_CD"}, nest: ()
        {
          builder.text(ccr_cnnt_sys_ds_cd);
        });

        builder.element("Col", attributes: {"id": "OTXT_PAN_ID"}, nest: ()
        {
          builder.text(ccr_cnnt_sys_ds_cd);
        });

        builder.element("Col", attributes: {"id": "TRET_PAN_ID"}, nest: ()
        {
          builder.text(ccr_cnnt_sys_ds_cd);
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
  }
  return document.toXmlString(pretty: true, indent: '\t');
}