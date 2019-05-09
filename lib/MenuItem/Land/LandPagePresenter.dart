import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/MenuItem/Land/LandPageModel.dart';
import 'package:bunyang/MenuItem/Land/LandPageView.dart';
import 'package:bunyang/MenuItem/MenuItemPresenter.dart';

class LandPagePresenter extends MenuItemPresenter<LandPageModel>
{
  LandPagePresenter(LandPageView landPageView) : super(new LandPageModel(), landPageView);

  void onRequestNotice(Notice_Code code, String panId, String ccrCnntSysDsCd, String panKDCD, String otxtPanId)
  {
    model
      .fetchData(code, panId, ccrCnntSysDsCd, panKDCD, otxtPanId)
      .then((res) => (view as LandPageView).onLoadComplete(res))
      .catchError((onError) => view.onError());
  }
}