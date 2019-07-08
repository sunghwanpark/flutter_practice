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
}