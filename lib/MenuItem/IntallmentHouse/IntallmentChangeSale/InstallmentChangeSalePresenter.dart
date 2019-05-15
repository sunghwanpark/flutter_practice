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
}