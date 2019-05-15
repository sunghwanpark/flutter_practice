import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/Abstract/AbstractInstallmentHouseView.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/IntallmentChangeSale/InstallmentChangeSalePresenter.dart';

class InstallmentChangeSale extends AbstractInstallmentHouse
{
  InstallmentChangeSale(MenuData data) : super(data);

  @override
  InstallmentChangeSaleView createState() => InstallmentChangeSaleView(data);
}

class InstallmentChangeSaleView extends AbstractInstallmentHouseView<InstallmentChangeSale>
{
  InstallmentChangeSaleView(MenuData data) : super(data);

  @override
  void initState() 
  {
    super.initState();
    presenter = new InstallmentChangeSalePresenter(this);
    (presenter as InstallmentChangeSalePresenter).onRequestDetail(type, panId, ccrCnntSysDsCd);
  }

  void onResponseDetail(Map<String, List<Map<String, String>>> res)
  {

  }

  @override
  void onResponseSuccessPanInfo(Map<String, String> panInfo) {}
}
