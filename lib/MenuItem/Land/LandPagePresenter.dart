import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/MenuItem/Land/LandPageModel.dart';
import 'package:bunyang/MenuItem/Land/LandPageView.dart';
import 'package:bunyang/MenuItem/MenuItemModel.dart';
import 'package:bunyang/MenuItem/MenuItemPresenter.dart';

class LandPagePresenter extends MenuItemPresenter<LandPageModel>
{
  LandPagePresenter(LandPageView landPageView) : super(new LandPageModel(), landPageView);

  void onRequestNotice(Notice_Code code, String panId, String ccrCnntSysDsCd, PanInfo panInfo)
  {
    model
      .fetchData(code, panId, ccrCnntSysDsCd, panInfo)
      .then((res) => (view as LandPageView).onLoadComplete(res))
      .catchError((onError) => view.onError());
  }
}