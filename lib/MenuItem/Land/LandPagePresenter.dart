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

  void onRequestNotice(Notice_Code code, String panId, String ccrCnntSysDsCd)
  {
    _model
      .fetch(code, panId, ccrCnntSysDsCd)
      .then((res) => _view.onLoadComplete(res))
      .catchError((onError) => _view.onLoadError());
  }
}