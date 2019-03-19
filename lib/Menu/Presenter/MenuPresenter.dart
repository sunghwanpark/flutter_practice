import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/Menu/View/MenuView.dart';

class MenuPresenter
{
  MenuModel _menuModel;
  MenuView _menuView;

  MenuPresenter(this._menuView)
  {
    _menuModel = new MenuModel();
  }

  void onRequestNotice(String code)
  {
    _menuModel
      .fetch(code)
      .then((res) => _menuView.onLoadComplete(res))
      .catchError((onError) => _menuView.onLoadError());
  }
}