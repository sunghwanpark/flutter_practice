import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/MenuItem/Land/LandPageModel.dart';
import 'package:bunyang/MenuItem/Land/LandPageView.dart';

class LandPagePresenter
{
  LandPageModel _model;
  LandPageView _view;

  LandPagePresenter(this._view)
  {
    _model = new LandPageModel();
  }

  void onRequestPanInfo(Notice_Code code, String panId, String ccrCnntSysDsCd)
  {
    _model
      .fetchPanInfo(code, panId, ccrCnntSysDsCd)
      .then((panInfo) => _view.onResponseSuccessPanInfo(panInfo))
      .catchError((onError) => _view.onLoadError());
  }

  void onRequestNotice(Notice_Code code, String panId, String ccrCnntSysDsCd, PanInfo panInfo)
  {
    _model
      .fetchData(code, panId, ccrCnntSysDsCd, panInfo)
      .then((res) => _view.onLoadComplete(res))
      .catchError((onError) => _view.onLoadError());
  }
}