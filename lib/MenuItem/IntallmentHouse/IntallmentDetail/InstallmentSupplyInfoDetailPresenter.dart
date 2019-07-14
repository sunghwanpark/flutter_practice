import 'package:bunyang/MenuItem/IntallmentHouse/IntallmentDetail/InstallmentSupplyInfoDetailModel.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/IntallmentDetail/InstallmentSupplyInfoDetailView.dart';

class InstallmentSupplyInfoDetailPresenter
{
  InstallmentSupplyInfoDetailModel _model;
  InstallmentSupplyInfoDetailView _view;

  InstallmentSupplyInfoDetailPresenter(this._view)
  {
    _model = new InstallmentSupplyInfoDetailModel();
  }

  void onRequestData(String panId, String ccrCnntSysDsCd, String aisInfSn, String bzdtCd, String hcBlkCd, String htyCd)
  {
    _model
      .fetchData(panId, ccrCnntSysDsCd, aisInfSn, bzdtCd, hcBlkCd, htyCd)
      .then((res) => _view.onComplete(res))
      .catchError((err) => _view.onError(err));
  }
}