import 'package:bunyang/MenuItem/Store/Draw/StoreDrawModel.dart';
import 'package:bunyang/MenuItem/Store/Draw/StoreDrawView.dart';

class StoreDrawPresenter
{
  StoreDrawModel _model;
  StoreDrawWidgetView _view;

  StoreDrawPresenter(this._view)
  {
    _model = StoreDrawModel();
  }

  void onRequestData(Map<String, String> params)
  {
    _model
      .fetchDefaultDetailData(params)
      .then((res) => _view.onResponseData(res))
      .catchError((err) => _view.onError(err));
  }

  void onRequestAttachment(Map<String, String> params)
  {
    _model
      .fetchAttachment(params)
      .then((res) => _view.onResponseAttachmentData(res))
      .catchError((err) => _view.onError(err));
  }

  void onRequestSupplyData(Map<String, String> params)
  {
    _model
      .fetchDetail(params)
      .then((res) => _view.onResponseSupplyData(res, params['SBD_NM']))
      .catchError((err) => _view.onError(err));
  }
}