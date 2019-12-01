import 'package:bunyang/MenuItem/MenuItemModel.dart';
import 'package:bunyang/Secret/URL.dart';
import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;

class LeaseModel extends MenuItemModel
{
  LeaseModel() : super(detailFormURL : "OCMC_LCC_SIL_SILSNOT_R0009");

  String _detailMoreURL = "OCMC_LCC_SIL_SILSNOT_R0010";
  String _rentalLeaseMoreURL = "OCMC_LCC_SBSC_RSWLF_RQS_L0001";
  String _rentalLeaseStTypeURL = "OCMC_LCC_SBSC_RSWLF_RQS_L0002";

  @override
  String defaultDetailFormXml = '''<?xml version="1.0" encoding="UTF-8"?>
    <Root xmlns="http://www.nexacroplatform.com/platform/dataset">
	    <Dataset id="dsSch">
		    <ColumnInfo>
          <Column id="PAN_ID" type="STRING" size="256"  />
          <Column id="CCR_CNNT_SYS_DS_CD" type="STRING" size="256"  />
          <Column id="PAGE" type="STRING" size="256"  />
          <Column id="PG_SZ" type="STRING" size="256"  />
          <Column id="ALL_CNT" type="STRING" size="256"  />
          <Column id="LTR_UNT_NO" type="STRING" size="256"  />
          <Column id="LTR_NOT" type="STRING" size="256"  />
          <Column id="ACP_NO" type="STRING" size="256"  />
          <Column id="RQS_HS_TP_CD" type="STRING" size="256"  />
          <Column id="SBD_LGO_NO" type="STRING" size="256"  />
          <Column id="HTY_DS_CD" type="STRING" size="256"  />
          <Column id="CNP_NM" type="STRING" size="256"  />
          <Column id="LTST_ADM_NO" type="STRING" size="256"  />
          <Column id="LTRM_NLE_YN" type="STRING" size="256"  />
          <Column id="LTST_NO" type="STRING" size="256"  />
          <Column id="LTST_NM" type="STRING" size="256"  />
          <Column id="HO_ADM_NO" type="STRING" size="256"  />
          <Column id="HO_NO" type="STRING" size="256"  />
          <Column id="PREVIEW" type="STRING" size="256"  />
          <Column id="SSN_DS" type="STRING" size="256"  />
          <Column id="CST_IDN_NO" type="STRING" size="256"  />
          <Column id="CST_TP_CD" type="STRING" size="256"  />
          <Column id="VIEW_TYPE" type="STRING" size="256"  />
          <Column id="PAN_TP_CD" type="STRING" size="256"  />
		    </ColumnInfo>
      </Dataset>
    </Root>''';

  String _rentalLeaseMoreForm = '''<?xml version="1.0" encoding="UTF-8"?>
    <Root xmlns="http://www.nexacroplatform.com/platform/dataset">
	    <Dataset id="dsSch">
		    <ColumnInfo>
          <Column id="PAN_ID" type="STRING" size="256"  />
          <Column id="CCR_CNNT_SYS_DS_CD" type="STRING" size="256"  />
          <Column id="PREVIEW" type="STRING" size="256"  />
          <Column id="VIEW_TYPE" type="STRING" size="256"  />
          <Column id="GUBUN" type="STRING" size="256"  />
          <Column id="SSN_DS" type="STRING" size="256"  />
          <Column id="CST_IDN_NO" type="STRING" size="256"  />
          <Column id="CST_TP_CD" type="STRING" size="256"  />
          <Column id="LOH_TP_CD" type="STRING" size="256"  />
		    </ColumnInfo>
      </Dataset>
    </Root>''';

  generateRequestBody(String panId, String ccrCnntSysDsCd)
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

  generateRequestMoreBody(String panId, String ccrCnntSysDsCd, String ltrUntNo, String ltrNot, String ltrmNleYn)
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

        builder.element("Col", attributes: {"id": "LTR_UNT_NO"}, nest: ()
        {
          builder.text(ltrUntNo);
        });

        builder.element("Col", attributes: {"id": "LTR_NOT"}, nest: ()
        {
          builder.text(ltrNot);
        });

        builder.element("Col", attributes: {"id": "LTRM_NLE_YN"}, nest: ()
        {
          builder.text(ltrmNleYn);
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

  generateRequestRentalLeaseMoreBody(String panId, String ccrCnntSysDsCd, String lohTpCd)
  {
    var document = xml.parse(_rentalLeaseMoreForm);

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

        builder.element("Col", attributes: {"id": "GUBUN"}, nest: ()
        {
          builder.text("P");
        });

        builder.element("Col", attributes: {"id": "PREVIEW"}, nest: ()
        {
          builder.text("N");
        });

        builder.element("Col", attributes: {"id": "LOH_TP_CD"}, nest: ()
        {
          builder.text(lohTpCd);
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

  Future<Map<String, List<Map<String, String>>>> fetchData(String panId, String ccrCnntSysDsCd) async
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
      body: generateRequestBody(panId, ccrCnntSysDsCd)
    ).timeout(const Duration(seconds: 5))
    .then((res) => xml.parse(res.body))
    .then((xmlDocument) => setContextData(xmlDocument.findAllElements("Dataset")));
  }

  Future<Map<String, List<Map<String, String>>>> fetchMoreData(String panId, String ccrCnntSysDsCd, String ltrUntNo, String ltrNot, String ltrmNleYn) async
  {
    StringBuffer stringBuffer = new StringBuffer();
    stringBuffer.write(noticeURL);
    stringBuffer.write(detailFormAdapter);
    stringBuffer.write("?&serviceID=");
    stringBuffer.write(_detailMoreURL);

    return await http.post
    (
      stringBuffer.toString(),
      headers: {"Content-Type" : "application/xml"},
      body: generateRequestMoreBody(panId, ccrCnntSysDsCd, ltrUntNo, ltrNot, ltrmNleYn)
    ).timeout(const Duration(seconds: 5))
    .then((res) => xml.parse(res.body))
    .then((xmlDocument) => setContextData(xmlDocument.findAllElements("Dataset")));
  }

  Future<Map<String, List<Map<String, String>>>> fetchRentalLeaseMoreData(String panId, String ccrCnntSysDsCd, String lohTpCd) async
  {
    StringBuffer stringBuffer = new StringBuffer();
    stringBuffer.write(noticeURL);
    stringBuffer.write(detailFormAdapter);
    stringBuffer.write("?&serviceID=");
    stringBuffer.write(_rentalLeaseMoreURL);

    return await http.post
    (
      stringBuffer.toString(),
      headers: {"Content-Type" : "application/xml"},
      body: generateRequestRentalLeaseMoreBody(panId, ccrCnntSysDsCd, lohTpCd)
    ).timeout(const Duration(seconds: 5))
    .then((res) => xml.parse(res.body))
    .then((xmlDocument) => setContextData(xmlDocument.findAllElements("Dataset")));
  }

  Future<Map<String, List<Map<String, String>>>> fetchRentalLeaseStTypeData(String panId, String ccrCnntSysDsCd, String lohTpCd) async
  {
    StringBuffer stringBuffer = new StringBuffer();
    stringBuffer.write(noticeURL);
    stringBuffer.write(detailFormAdapter);
    stringBuffer.write("?&serviceID=");
    stringBuffer.write(_rentalLeaseStTypeURL);

    return await http.post
    (
      stringBuffer.toString(),
      headers: {"Content-Type" : "application/xml"},
      body: generateRequestRentalLeaseMoreBody(panId, ccrCnntSysDsCd, lohTpCd)
    ).timeout(const Duration(seconds: 5))
    .then((res) => xml.parse(res.body))
    .then((xmlDocument) => setContextData(xmlDocument.findAllElements("Dataset")));
  }
}