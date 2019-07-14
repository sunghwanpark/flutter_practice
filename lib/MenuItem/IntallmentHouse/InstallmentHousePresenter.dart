import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/InstallmentHouseModel.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/InstallmentHouseView.dart';
import 'package:bunyang/MenuItem/MenuItemPresenter.dart';

typedef void InstallmentResponseCallback(String aisInfSn, Map<String, List<Map<String, String>>> r);

class InstallmentHousePresenter extends MenuItemPresenter<InstallmentHouseModel>
{
  InstallmentHousePresenter(InstallmentHouseView view) : super(new InstallmentHouseModel(), view);

  void onRequestDetail(Notice_Code code, String panId, String ccrCnntSysDsCd, String otxtPanId, String uppAisTpCd)
  {
    model
      .fetchData(code, panId, ccrCnntSysDsCd, otxtPanId, uppAisTpCd)
      .then((res) => (view as InstallmentHouseView).onResponseDetail(res))
      .catchError((onError) => view.onError(onError));
  }

  // UPP_AIS_TP_CD = 05
  void onRequestSupplyInfoPublicInstallment(String panId, String ccrCnntSysDsCd, String aisInfSn,
   String otxtPanId, String uppAisTpCd, InstallmentResponseCallback successCallback, [bool dynamic0708 = false, bool dynamic11 = false])
  {
     model
      .fetchSupplyInfo(panId, ccrCnntSysDsCd, aisInfSn, otxtPanId, uppAisTpCd, dynamic0708, dynamic11)
      .then((res) => successCallback(aisInfSn, res))
      .catchError((err) => view.onError(err));
  }
  
  void onRequestSupplyInfoImage(String panId, String ccrCnntSysDsCd, String aisInfSn,
   String otxtPanId, String uppAisTpCd, InstallmentResponseCallback successCallback, String bzdtCd, String hcBlkCd)
  {
    model
      .fetchSupplyInfoImage(panId, ccrCnntSysDsCd, aisInfSn, otxtPanId, uppAisTpCd, bzdtCd, hcBlkCd)
      .then((res) => successCallback(aisInfSn, res))
      .catchError((err) => view.onError(err));
  }
}