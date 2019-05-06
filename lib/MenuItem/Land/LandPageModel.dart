import 'dart:convert';
import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/Data/URL.dart';
import 'package:bunyang/MenuItem/MenuItemModel.dart';
import 'package:tuple/tuple.dart';
import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;

class RankDate
{
  RankDate
  (
    {
      this.rank = 0,
      this.applyDate = '',
      this.applyReserveDepositEndDate = ''
    }
  );

  final int rank;
  /// 신청일시
  final String applyDate;
  /// 납부마감일시
  final String applyReserveDepositEndDate;
}

class SupplyDate
{
  SupplyDate
  (
    {
      this.rankDate,
      this.pickDate = '',
      this.resultNoticeDate = '',
      this.contractDateStartAt = '',
      this.contractDateEndAt = ''
      }
  );

  final List<RankDate> rankDate;
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

class DetailPageData
{
  DetailPageData(this.ccrCnntSysDsCd, this.aisInfSn, this.bzdtCd, this.loldNo, this.panId);

  final String ccrCnntSysDsCd;
  final String aisInfSn;
  final String bzdtCd;
  final String loldNo;
  final String panId;
}

class SupplyLotOfLandInfo
{
  SupplyLotOfLandInfo
  (
    this.detailPageData, 
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

  final DetailPageData detailPageData;
}

class PageState
{
  PageState
  (
    { this.isBid, this.isLtr, this.isCtp, this.isHndcLtr, this.isPvtc }
  );
  /// 입찰여부
  final bool isBid;
  /// 추첨여부
  final bool isLtr;
  /// 고객제안여부
  final bool isCtp;
  /// 수기추첨여부
  final bool isHndcLtr;
  /// 수의계약여부
  final bool isPvtc;
}

class LandPageModel extends MenuItemModel
{
  LandPageModel() : super("OCMC_LCC_SIL_SILSNOT_L0004");
  
  String _requestPanInfo = "OCMC_LCC_SIL_PAN_IFNO_R0001";

  Map<String, List<Map<String, String>>> cachedLandInfos;

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

  PanInfo getPanInfo(Iterable<xml.XmlElement> iterator)
  {
    var res = this.setContextData(iterator);
    return PanInfo(res["dsPanInfo"].first["OTXT_PAN_ID"], res["dsPanInfo"].first["PAN_KD_CD"]);
  }

  Tuple4<PageState, SupplyDate, List<SupplyLotOfLandInfo>, String> getSupplyDate(Iterable<xml.XmlElement> iterator)
  {
    cachedLandInfos = setContextData(iterator);

    var pageState = PageState
      (
        isBid: cachedLandInfos["dsLndInf"].first["SPL_MD_BID_YN"] == "Y",
        isLtr: cachedLandInfos["dsLndInf"].first["SPL_MD_LTR_YN"] == "Y",
        isCtp: cachedLandInfos["dsLndInf"].first["SPL_MD_CTP_YN"] == "Y",
        isHndcLtr: cachedLandInfos["dsLndInf"].first["SPL_MD_HNDC_LTR_YN"] == "Y",
        isPvtc: cachedLandInfos["dsLndInf"].first["SPL_MD_PVTC_YN"] == "Y"
      );

    bool isDraw = (pageState.isLtr || pageState.isCtp || pageState.isHndcLtr) && !pageState.isPvtc;
    bool isTender = pageState.isBid && !pageState.isPvtc;

    SupplyDate supplyDate;

    List<RankDate> rankDate = new List<RankDate>();
    cachedLandInfos["dsSplScdList"].forEach((row) =>
    {
      rankDate.add(RankDate
      (
        rank: int.parse(row["RNK"]),
        applyDate: row["RQS_DTTM"],
        applyReserveDepositEndDate: row["CLSG_DTTM"]
      ))
    });

    if(isDraw)
    {
      supplyDate = SupplyDate
      (
        rankDate: rankDate,
        pickDate: cachedLandInfos["dsLndInf"].first['LTR_DTTM'],
        resultNoticeDate: cachedLandInfos["dsLndInf"].first['PZWR_NT_DTTM'],
        contractDateStartAt: cachedLandInfos["dsLndInf"].first['CTRT_ST_DT'],
        contractDateEndAt: cachedLandInfos["dsLndInf"].first['CTRT_ED_DT'],
      );
    }
    else if(isTender)
    {
      supplyDate = SupplyDate
      (
        rankDate: rankDate,
        pickDate: cachedLandInfos["dsSplScdList"].first['OPB_DTTM'],
        resultNoticeDate: cachedLandInfos["dsSplScdList"].first['OPB_RSL_NT_DTTM'],
        contractDateStartAt: cachedLandInfos["dsLndInf"].first['CTRT_ST_DT'],
        contractDateEndAt: cachedLandInfos["dsLndInf"].first['CTRT_ED_DT'],
      );
    }

    List<SupplyLotOfLandInfo> solInfo = new List<SupplyLotOfLandInfo>();
    if(isDraw)
    {
      cachedLandInfos["dsSplInfLtrList"].forEach((row) =>
      {
        solInfo.add(SupplyLotOfLandInfo
        (
          DetailPageData
          (
            row["CCR_CNNT_SYS_DS_CD"],
            row["AIS_INF_SN"],
            row["BZTD_CD"],
            row["LOLD_NO"],
            row["PAN_ID"]
          ),
          supplyPurpose: row["LND_US_DS_CD_NM"],
          locate: row["LGDN_DTL_ADR"],
          number: row["LNO"],
          extent: row["AR"],
          supplyPrice: row["SPL_AMT"],
          reservePrice: row["RQS_BAM"],
          state: row["BTN_NM"]
        ))
      });
    }
    else if(isTender)
    {
      cachedLandInfos["dsSplInfBidList"].forEach((row) =>
      {
        solInfo.add(SupplyLotOfLandInfo
        (
          DetailPageData
          (
            row["CCR_CNNT_SYS_DS_CD"],
            row["AIS_INF_SN"],
            row["BZTD_CD"],
            row["LOLD_NO"],
            row["PAN_ID"]
          ),
          supplyPurpose: row["LND_US_DS_CD_NM"],
          locate: row["LGDN_DTL_ADR"],
          number: row["LNO"],
          extent: row["AR"],
          duePrice: row["SPL_XPC_AMT"],
          state: row["BTN_NM"]
        ))
      });
    }

    StringBuffer addressBuffer = StringBuffer();
    addressBuffer.write(cachedLandInfos["dsLndInf"].first["CTRT_PLC_ADR"]);
    addressBuffer.write(" ");
    addressBuffer.write(cachedLandInfos["dsLndInf"].first["CTRT_PLC_DTL_ADR"]);

    return Tuple4(pageState, supplyDate, solInfo, addressBuffer.toString());
  }

  Tuple2<double, double> getLatLng(String body)
  {
    var jsonMap = json.decode(body)["results"];
    var geometry = jsonMap[0]["geometry"];
    var location = geometry["location"];
    var lat = location["lat"];
    var lng = location["lng"];
    
    return Tuple2(lat, lng);
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
    .then((xmlDocument) => getPanInfo(xmlDocument.findAllElements("Dataset")));
  }

  Future<Tuple4<PageState, SupplyDate, List<SupplyLotOfLandInfo>, String>> fetchData(Notice_Code noticeCode, String panId, String ccrCnntSysDsCd, PanInfo panInfo) async
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

  Future<Tuple2<double, double>> fetchGeocode() async
  {
    String encodeAddress = Uri.encodeComponent(cachedLandInfos["dsLndInf"].first["CTRT_PLC_ADR"]);

    StringBuffer stringBuffer = new StringBuffer();
    stringBuffer.write("https://maps.googleapis.com/maps/api/geocode/json?sensor=false&language=ko&address=");
    stringBuffer.write(encodeAddress);
    stringBuffer.write("&key=");
    stringBuffer.write(googleMapApiKey);

    return await http.post(stringBuffer.toString())
      .timeout(const Duration(seconds: 5))
      .then((res) => getLatLng(res.body));
  }
}