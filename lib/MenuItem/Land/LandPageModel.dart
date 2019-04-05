import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/Data/URL.dart';
import 'package:bunyang/MenuItem/MenuItemModel.dart';
import 'package:tuple/tuple.dart';
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
      this.duePrice = '',
      this.state = '',
    }
  );

  /// 공급용도
  final String supplyPurpose;
  /// 소재지
  final String locate;
  /// 지번
  final String number;
  /// 면적
  final String extent;
  /// 필지군
  final String aLotOfLand;
  /// 공급가격(원)
  final String supplyPrice;
  /// 신청예약금(원)
  final String reservePrice;
  /// 예정가격(원)
  final String duePrice;
  /// 인터넷 청약
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

  Tuple2<SupplyDate, List<SupplyLotOfLandInfo>> getSupplyDate(Iterable<xml.XmlElement> iterator)
  {
    Map<String, Map<String, String>> dataSetMap = new Map<String, Map<String, String>>();
    List<SupplyLotOfLandInfo> bidList = new List<SupplyLotOfLandInfo>();
    iterator.forEach((elem)
      {
        var id = elem.getAttribute('id');
        if(id == "dsSplInfBidList")
        {
          elem.findAllElements("Row")
          .forEach((row)
          {
            Map<String, String> infoMap = new Map<String, String>();
            row.findElements("Col").forEach((col)
            {
              infoMap[col.getAttribute("id")] = col.text;
            });

            bidList.add(SupplyLotOfLandInfo
            (
              supplyPurpose: infoMap["LND_US_DS_CD_NM"],
              locate: infoMap["LGDN_DTL_ADR"],
              number: infoMap["LNO"],
              extent: infoMap["AR"],
              duePrice: infoMap["SPL_XPC_AMT"],
              state: infoMap["BTN_NM"]
            ));
          });
        }
        else if(id == "dsSplScdList" || id == "dsLndInf")
        {
          dataSetMap[id] = new Map<String, String>();
          elem.findAllElements('Col')
          .forEach((colElem)
          {
            dataSetMap[id][colElem.getAttribute('id')] = colElem.text;
          });
        }
      });

    return Tuple2
    (
      SupplyDate
      (
        applyDate: dataSetMap['dsSplScdList']['RQS_DTTM'],
        applyReserveDepositEndDate: dataSetMap['dsSplScdList']['CLSG_DTTM'],
        pickDate: dataSetMap['dsLndInf']['LTR_DTTM'],
        resultNoticeDate: dataSetMap['dsLndInf']['PZWR_NT_DTTM'],
        contractDateStartAt: dataSetMap['dsLndInf']['CTRT_ST_DT'],
        contractDateEndAt: dataSetMap['dsLndInf']['CTRT_ED_DT'],
      ),
      bidList
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

  Future<Tuple2<SupplyDate, List<SupplyLotOfLandInfo>>> fetchData(Notice_Code noticeCode, String panId, String ccrCnntSysDsCd, PanInfo panInfo) async
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