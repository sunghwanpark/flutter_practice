import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/MenuItem/MenuItemModel.dart';
import 'package:bunyang/MenuItem/MenuItemPageView.dart';
import 'package:meta/meta.dart';

abstract class MenuItemPresenter<T extends MenuPanInfoModel>
{
  T model;
  MenuItemPageView view;

  @protected
  MenuItemPresenter(this.model, this.view);

  void onRequestPanInfo(Notice_Code code, RequestPanInfo requestPanInfo)
  {
    model
      .fetchPanInfo(code, requestPanInfo)
      .then((panInfo) => view.onResponseSuccessPanInfo(panInfo))
      .catchError((onError) => view.onError());
  }
}