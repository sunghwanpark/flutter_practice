import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/MenuItem/MenuItemModel.dart';
import 'package:bunyang/MenuItem/MenuItemPageView.dart';
import 'package:meta/meta.dart';

abstract class MenuItemPresenter<T extends MenuPanInfoModel>
{
  @protected
  T model;
  @protected
  MenuItemPageView view;

  @protected
  MenuItemPresenter(this.model, this.view);

  void onRequestPanInfo(Notice_Code code, Map<String, String> requestPanInfo)
  {
    model
      .fetchPanInfo(code, requestPanInfo)
      .then((panInfo) => view.onResponseSuccessPanInfo(panInfo))
      .catchError((onError) => view.onError(onError));
  }
}