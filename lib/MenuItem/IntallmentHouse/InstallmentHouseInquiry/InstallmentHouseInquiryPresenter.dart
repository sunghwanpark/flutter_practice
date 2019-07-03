
import 'package:bunyang/MenuItem/IntallmentHouse/InstallmentHouseInquiry/InstallmentHouseInquiryModel.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/InstallmentHouseInquiry/InstallmentHouseInquiryView.dart';

class InstallmentHouseInquiryPresenter
{
  InstallmentHouseInquiryModel _model;
  InstallmentHouseInquiryView _view;

  InstallmentHouseInquiryPresenter(this._view) : _model = InstallmentHouseInquiryModel();
  InstallmentHouseInquiryPresenter.extend(this._model, this._view);

  void onRequestData(String panId, String ccrCnntSysDsCd, String uppAisTpCd, String aisInfSn, String bzdtCd, String hcBlkCd)
  {
    _model
      .fetchData(panId, ccrCnntSysDsCd, uppAisTpCd, aisInfSn, bzdtCd, hcBlkCd)
      .then((res) => _view.onComplete(res))
      .catchError((err) => _view.onError());
  }
}