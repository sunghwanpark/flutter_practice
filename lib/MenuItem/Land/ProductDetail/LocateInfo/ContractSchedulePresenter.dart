import 'package:bunyang/MenuItem/Land/ProductDetail/LocateInfo/ContractScheduleModel.dart';
import 'package:bunyang/MenuItem/Land/ProductDetail/LocateInfo/ContractScheduleView.dart';

class ContractSchedulePresenter
{
  ContractScheduleModel _model;
  ContractScheduleView _view;

  ContractSchedulePresenter(this._view)
  {
    _model = new ContractScheduleModel();
  }

  void onRequestContractInfo(String ccrCnntSysDsCd, String aisInfSn)
  {
    _model
      .fetchContractInfo(ccrCnntSysDsCd, aisInfSn)
      .then((res) => _view.onComplete(res))
      .catchError((err) => _view.onError());
  }
}