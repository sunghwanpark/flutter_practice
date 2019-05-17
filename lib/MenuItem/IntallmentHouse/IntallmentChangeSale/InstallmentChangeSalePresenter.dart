import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/IntallmentChangeSale/InstallmentChangeSaleModel.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/IntallmentChangeSale/InstallmentChangeSaleView.dart';
import 'package:bunyang/MenuItem/MenuItemPresenter.dart';

class InstallmentChangeSalePresenter extends MenuItemPresenter<InstallmentChangeSaleModel>
{
  InstallmentChangeSalePresenter(InstallmentChangeSaleView view) : super(new InstallmentChangeSaleModel(), view);

  void onRequestDetail(Notice_Code code, String panId, String ccrCnntSysDsCd)
  {
    model
      .fetchData(code, panId, ccrCnntSysDsCd)
      .then((res) => (view as InstallmentChangeSaleView).onResponseDetail(res))
      .catchError((onError) => view.onError());
  }

  void onRequestHouseType(String panId, String ccrCnntSysDsCd, String sbdLgoNo, String ltrNot, String ltrUntNo, String sn) async
  {
    var res1 = await model.fetchHouseType(panId, ccrCnntSysDsCd, sbdLgoNo, ltrNot, ltrUntNo, sn, false)
                          .catchError((onError) => view.onError());
    var res2 = await model.fetchHouseType(panId, ccrCnntSysDsCd, sbdLgoNo, ltrNot, ltrUntNo, sn, true)
                          .catchError((onError) => view.onError());

    if(res1 != null)
      (view as InstallmentChangeSaleView).onResponseHouseType(res1);
    if(res2 != null)
      (view as InstallmentChangeSaleView).onResponseHouseAttatchment(res2);
  }
}