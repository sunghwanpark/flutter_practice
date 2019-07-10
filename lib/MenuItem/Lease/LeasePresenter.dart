import 'package:bunyang/MenuItem/Lease/LeaseModel.dart';
import 'package:bunyang/MenuItem/Lease/LeaseView.dart';

class LeasePresenter
{
  LeasePresenter(this._view)
  {
    _model = LeaseModel();
  }

  LeaseModel _model;
  LeaseViewWidget _view;

  void onRequestData(String panId, String ccrCnntSysDsCd)
  {
    _model
      .fetchData(panId, ccrCnntSysDsCd)
      .then((res) => _view.onResponseData(res))
      .catchError((err) => _view.onError());
  }

  void onRequestMoreData(String panId, String ccrCnntSysDsCd, String ltrUntNo, String ltrNot, String ltrmNleYn)
  {
    _model
      .fetchMoreData(panId, ccrCnntSysDsCd, ltrUntNo, ltrNot, ltrmNleYn)
      .then((res) => _view.onResponseMoreData(res))
      .catchError((err) => _view.onError());
  }

  void onRequestRentalLeaseMoreData(String panId, String ccrCnntSysDsCd, String lohTpCd)
  {
    _model
      .fetchRentalLeaseMoreData(panId, ccrCnntSysDsCd, lohTpCd)
      .then((res) => _view.onResponseRentalLeaseMoreData(res))
      .catchError((err) => _view.onError());
  }

  void onRequestRentalLeaseStTypeData(String panId, String ccrCnntSysDsCd, String lohTpCd)
  {
    _model
      .fetchRentalLeaseStTypeData(panId, ccrCnntSysDsCd, lohTpCd)
      .then((res) => _view.onResponseRentalLeaseStTypeData(res))
      .catchError((err) => _view.onError());
  }
}