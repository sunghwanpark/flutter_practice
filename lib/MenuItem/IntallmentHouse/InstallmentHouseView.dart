import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/Abstract/AbstractInstallmentHouseView.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/InstallmentHousePresenter.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/SummaryInfoView.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/SupplyInfoView.dart';
import 'package:bunyang/MenuItem/MenuItemModel.dart';
import 'package:bunyang/Util/Util.dart';

import 'SupplyScheduleView.dart';

enum DataListenState { DEFAULT, DETAIL, IMAGE }

class InstallmentHousePage extends AbstractInstallmentHouse
{
  InstallmentHousePage(MenuData data) : super(data);

  @override
  InstallmentHouseView createState() => InstallmentHouseView(data);
}

class InstallmentHouseView extends AbstractInstallmentHouseView<InstallmentHousePage>
{
  InstallmentHouseView(MenuData data) : super(data);

  String _otxtPanId;
  String _aisInfSn;
  String _bztdCd;
  String _hcBlkCd;

  final Map<String, String> _defaultData = new Map<String, String>();
  final List<Map<String, String>> _publicInstallment = new List<Map<String, String>>();
  final List<Map<String, String>> _publicLease = new List<Map<String, String>>();
  final List<Map<String, String>> _publicInstallmentLease = new List<Map<String, String>>();

  @override
  void initState() 
  {
    super.initState();
    presenter = new InstallmentHousePresenter(this);
    presenter.onRequestPanInfo(type, RequestPanInfo(panId, ccrCnntSysDsCd, uppAisTpCd));
  }

  @override
  void dispose()
  {
    super.dispose();

    _defaultData.clear();
    _publicInstallment.clear();
    _publicLease.clear();
    _publicInstallmentLease.clear();
  }

  @override
  void onResponseSuccessPanInfo(Map<String, String> panInfo) 
  {
    _otxtPanId = panInfo["OTXT_PAN_ID"];
    (presenter as InstallmentHousePresenter).onRequestDetail(type, panId, ccrCnntSysDsCd, _otxtPanId, uppAisTpCd);
  }

  void onResponseDetail(Map<String, List<Map<String, String>>> res)
  {
    contents.add(SummaryInfoView(res["dsHsSlpa"].first, res["dsAhflList"]));
    scheduleView.add(SupplyScheduleView(res));

    // list가 한개인 경우만
    if(res["dsHsAisList"].length == 1)
    {
      _aisInfSn = res["dsHsAisList"].first["AIS_INF_SN"];
      _bztdCd = res["dsHsAisList"].first["BZDT_CD"];
      _hcBlkCd = res["dsHsAisList"].first["HC_BLK_CD"];

      _defaultData.clear();
      _defaultData.addAll(res["dsHsAisList"].first);

      (presenter as InstallmentHousePresenter).onRequestSupplyInfoPublicInstallment(
        panId, ccrCnntSysDsCd, _aisInfSn, _otxtPanId, uppAisTpCd, onResponsePublicInstallment);
    }
    else
    {
      setState(() {
        loadingState = LoadingState.DONE;
      });
    }
  }

  void onResponsePublicInstallment(Map<String, List<Map<String, String>>> res)
  {
    _publicInstallment.clear();
    _publicInstallment.addAll(res["dsHtyList"]);

    (presenter as InstallmentHousePresenter).onRequestSupplyInfoPublicInstallment(
        panId, ccrCnntSysDsCd, _aisInfSn, _otxtPanId, "06", onResponsePublicRentalType06, true, false);
  }

  void onResponsePublicRentalType06(Map<String, List<Map<String, String>>> res)
  {
    _publicLease.clear();
    _publicLease.addAll(res["dsHtyList"]);

    (presenter as InstallmentHousePresenter).onRequestSupplyInfoPublicInstallment(
        panId, ccrCnntSysDsCd, _aisInfSn, _otxtPanId, "06", onResponsePublicRentalType07, false, true);
  }

  void onResponsePublicRentalType07(Map<String, List<Map<String, String>>> res)
  {
    _publicInstallmentLease.clear();
    _publicInstallmentLease.addAll(res["dsHtyList"]);

    (presenter as InstallmentHousePresenter).onRequestSupplyInfoImage(
        panId, ccrCnntSysDsCd, _aisInfSn, _otxtPanId, uppAisTpCd, onResponseFinally, _bztdCd, _hcBlkCd);
  }

  void onResponseFinally(Map<String, List<Map<String, String>>> res)
  {
    infoView.add(SupplyInfo(_defaultData, _publicInstallment, _publicLease, _publicInstallmentLease, res["dsHsAhtlList"]));

    setState(() {
        loadingState = LoadingState.DONE;
    });
  }
}
