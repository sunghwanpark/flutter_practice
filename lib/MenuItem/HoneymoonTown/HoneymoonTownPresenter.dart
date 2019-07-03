import 'package:bunyang/MenuItem/HoneymoonTown/HoneymoonTownModel.dart';
import 'package:bunyang/MenuItem/HoneymoonTown/HoneymoonTownView.dart';
import 'package:bunyang/MenuItem/MenuItemPresenter.dart';

class HoneymoonTownPresenter extends MenuItemPresenter<HoneymoonTownModel>
{
  HoneymoonTownPresenter(HoneymoonTownWidget view) : super(HoneymoonTownModel(), view);
  
  void onRequestDefault(String panId, String ccrCnntSysDsCd, String otxtPanId, String uppAisTpCd)
  {
    model
      .fetchData(panId, ccrCnntSysDsCd, otxtPanId, uppAisTpCd)
      .then((res) => (view as HoneymoonTownWidget).onResponseDetail(res))
      .catchError((err) => view.onError());
  }

  void onRequestDetail(String panId, String ccrCnntSysDsCd, String otxtPanId, String uppAisTpCd, String aisInfSn)
  {
    model
      .fetchDetailData(panId, ccrCnntSysDsCd, otxtPanId, uppAisTpCd, aisInfSn)
      .then((res) => (view as HoneymoonTownWidget).onResponseDetailData(aisInfSn, res))
      .catchError((err) => view.onError());
  }

  void onRequestAttachment(String panId, String ccrCnntSysDsCd, String otxtPanId, String uppAisTpCd, String aisInfSn, String bztdCd, String hcBlkCd)
  {
    model
      .fetchAttacementData(panId, ccrCnntSysDsCd, otxtPanId, uppAisTpCd, aisInfSn, bztdCd, hcBlkCd)
      .then((res) => (view as HoneymoonTownWidget).onResponseAttachment(aisInfSn, res))
      .catchError((err) => view.onError());
  }
}