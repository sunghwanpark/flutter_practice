import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/Data/URL.dart';
import 'package:bunyang/MenuItem/MenuItemModel.dart';
import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;

class SupplyDate
{
  SupplyDate
  (
    {
      this.applyDate = '',
      this.applyReserveDepositEndDate = '',
      this.pickDate = '',
      this.resultNoticeDate = '',
      this.contractDateStartAt = '',
      this.contractDateEndAt = ''
    }
  );

  final String applyDate;
  final String applyReserveDepositEndDate;
  final String pickDate;
  final String resultNoticeDate;
  final String contractDateStartAt;
  final String contractDateEndAt;
}

class PanInfo
{
  PanInfo(this.otxtPanId, this.panKDCD);

  final String otxtPanId;
  final String panKDCD;
}

class SupplyLotOfLandInfo
{
  SupplyLotOfLandInfo
  (
    {
      this.supplyPurpose = '',
      this.locate = '',
      this.number = '',
      this.extent = '',
      this.aLotOfLand = '',
      this.supplyPrice = '',
      this.reservePrice = '',
      this.state = ''
    }
  );

  final String supplyPurpose;
  final String locate;
  final String number;
  final String extent;
  final String aLotOfLand;
  final String supplyPrice;
  final String reservePrice;
  final String state;
}

class LandPageModel extends MenuItemModel
{
  LandPageModel() : super("OCMC_LCC_SIL_SILSNOT_L0004");
  
  String _requestPanInfo = "OCMC_LCC_SIL_PAN_IFNO_R0001";

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

        builder.element("Col", attributes: {"id": "PAN_LOLD_TYPE"}, nest: ()
        {
          builder.text(ccrCnntSysDsCd);
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

  generateDetailBody(String panId, String ccrCnntSysDsCd, PanInfo panInfo)
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
          builder.text(panInfo.panKDCD);
        });

        builder.element("Col", attributes: {"id": "OTXT_PAN_ID"}, nest: ()
        {
          builder.text(panInfo.otxtPanId);
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

  PanInfo setContextData(Iterable<xml.XmlElement> iterator)
  {
    Map<String, Map<String, String>> dataSetMap = new Map<String, Map<String, String>>();
    iterator.forEach((elem)
      {
        dataSetMap[elem.getAttribute('id')] = new Map<String, String>();
        elem.findAllElements('Col')
        .forEach((colElem)
        {
          dataSetMap[elem.getAttribute('id')][colElem.getAttribute('id')] = colElem.text;
        });
      });

    return PanInfo(dataSetMap["dsPanInfo"]["OTXT_PAN_ID"], dataSetMap["dsPanInfo"]["PAN_KD_CD"]);
  }

  SupplyDate getSupplyDate(Iterable<xml.XmlElement> iterator)
  {
    Map<String, Map<String, String>> dataSetMap = new Map<String, Map<String, String>>();
    iterator.forEach((elem)
      {
        dataSetMap[elem.getAttribute('id')] = new Map<String, String>();
        print(elem.getAttribute('id'));
        elem.findAllElements('Col')
        .forEach((colElem)
        {
          print(colElem.toString());
          dataSetMap[elem.getAttribute('id')][colElem.getAttribute('id')] = colElem.text;
        });
      });

    return SupplyDate
    (
      applyDate: dataSetMap['dsSplScdList']['RQS_DTTM'],
      applyReserveDepositEndDate: dataSetMap['dsSplScdList']['CLSG_DTTM'],
      pickDate: dataSetMap['dsLndInf']['LTR_DTTM'],
      resultNoticeDate: dataSetMap['dsLndInf']['PZWR_NT_DTTM'],
      contractDateStartAt: dataSetMap['dsLndInf']['CTRT_ST_DT'],
      contractDateEndAt: dataSetMap['dsLndInf']['CTRT_ED_DT'],
    );
  }

  Future<PanInfo> fetchPanInfo(Notice_Code noticeCode, String panId, String ccrCnntSysDsCd) async
  {
    StringBuffer stringBuffer = new StringBuffer();
    stringBuffer.write(noticeURL);
    stringBuffer.write(detailFormUrl);
    stringBuffer.write("?&serviceID=");
    stringBuffer.write(_requestPanInfo);

    return await http.post
    (
      stringBuffer.toString(),
      headers: {"Content-Type" : "application/xml"},
      body: generateRequestBody(panId, ccrCnntSysDsCd)
    ).timeout(const Duration(seconds: 5))
    .then((res) => xml.parse(res.body))
    .then((xmlDocument) => setContextData(xmlDocument.findAllElements("Dataset")));
  }

  Future<SupplyDate> fetchData(Notice_Code noticeCode, String panId, String ccrCnntSysDsCd, PanInfo panInfo) async
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
      body: generateDetailBody(panId, ccrCnntSysDsCd, panInfo)
    ).timeout(const Duration(seconds: 5))
    .then((res) => xml.parse(res.body))
    .then((xmlDocument) => getSupplyDate(xmlDocument.findAllElements("Dataset")));
  }
}