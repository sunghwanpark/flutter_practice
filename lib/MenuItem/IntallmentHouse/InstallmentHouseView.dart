import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/InstallmentHousePresenter.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/SummaryInfoView.dart';
import 'package:bunyang/MenuItem/MenuItemModel.dart';
import 'package:bunyang/MenuItem/MenuItemPageView.dart';
import 'package:bunyang/Util/Util.dart';

class InstallmentHousePage extends MenuItemPage
{
  InstallmentHousePage(MenuData data) : super(data);

  @override
  InstallmentHouseView createState() => InstallmentHouseView(data);
}

class InstallmentHouseView extends MenuItemPageView<InstallmentHousePage> 
{
  InstallmentHouseView(MenuData data) : super(data)
  {
    _uppAisTpCd = this.data.getUppAisTPCD();
  }

  String _uppAisTpCd;
  String _otxtPanId;
  String _aisInfSn;
  String _bztdCd;
  String _hcBlkCd;

  @override
  void initState() 
  {
    super.initState();
    presenter = new InstallmentHousePresenter(this);
    presenter.onRequestPanInfo(type, RequestPanInfo(panId, ccrCnntSysDsCd, _uppAisTpCd));
  }

  @override
  void onResponseSuccessPanInfo(Map<String, String> panInfo) 
  {
    _otxtPanId = panInfo["OTXT_PAN_ID"];
    (presenter as InstallmentHousePresenter).onRequestDetail(type, panId, ccrCnntSysDsCd, _otxtPanId, _uppAisTpCd);
  }

  void onResponseDetail(Map<String, List<Map<String, String>>> res)
  {
    // list가 한개인 경우만
    if(res["dsHsAisList"].length == 1)
    {
      _aisInfSn = res["dsHsAisList"].first["AIS_INF_SN"];
      _bztdCd = res["dsHsAisList"].first["BZDT_CD"];
      _hcBlkCd = res["dsHsAisList"].first["HC_BLK_CD"];

      (presenter as InstallmentHousePresenter).onRequestSupplyInfoPublicInstallment(
        panId, ccrCnntSysDsCd, _aisInfSn, _otxtPanId, _uppAisTpCd, onResponsePublicInstallment);
    }
    else
    {
      setState(() {
        loadingState = LoadingState.DONE;
      });
    }

    contents.add(SummaryInfoView(res["dsHsSlpa"].first));
  }

  void onResponsePublicInstallment(List<Map<String, String>> res)
  {
    (presenter as InstallmentHousePresenter).onRequestSupplyInfoPublicInstallment(
        panId, ccrCnntSysDsCd, _aisInfSn, _otxtPanId, "06", onResponsePublicRentalType06, true, false);
  }

  void onResponsePublicRentalType06(List<Map<String, String>> res)
  {
    (presenter as InstallmentHousePresenter).onRequestSupplyInfoPublicInstallment(
        panId, ccrCnntSysDsCd, _aisInfSn, _otxtPanId, "06", onResponsePublicRentalType07, false, true);
  }

  void onResponsePublicRentalType07(List<Map<String, String>> res)
  {
    (presenter as InstallmentHousePresenter).onRequestSupplyInfoImage(
        panId, ccrCnntSysDsCd, _aisInfSn, _otxtPanId, _uppAisTpCd, onResponseFinally, _bztdCd, _hcBlkCd);
  }

  void onResponseFinally(List<Map<String, String>> res)
  {
    setState(() {
        loadingState = LoadingState.DONE;
    });
  }
}
