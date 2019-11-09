import 'package:bunyang/MenuItem/Store/Evaluation/StoreEvaluationModel.dart';
import 'package:bunyang/MenuItem/Store/Evaluation/StoreEvaluationView.dart';

class StoreEvaluationPresenter
{
  StoreEvaluationModel _model;
  StoreEvaluationViewWidget _view;

  StoreEvaluationPresenter(this._view)
  {
    _model = StoreEvaluationModel();
  }

  void onRequestData(Map<String, String> params)
  {
    _model
      .fetchDefaultDetailData(params)
      .then((res) => _view.onResponseData(res))
      .catchError((err) => _view.onError(err));
  }

  void onRequestSupplyData(Map<String, String> params)
  {
    _model
      .fetchSupplyData(params)
      .then((res) => _view.onResponseSupplyData(res, params['SBD_NM']))
      .catchError((err) => _view.onError(err));
  }
}