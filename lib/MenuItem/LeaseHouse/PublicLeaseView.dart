import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/IntallmentChangeSale/InstallmentChangeSaleView.dart';
import 'package:bunyang/MenuItem/LeaseHouse/PublicLeasePresenter.dart';

class PublicLeaseView extends InstallmentChangeSale
{
  PublicLeaseView(MenuData data) : super(data);

  @override
  PublicLeaseViewWidget createState() => PublicLeaseViewWidget(data);
}

class PublicLeaseViewWidget extends InstallmentChangeSaleView
{
  PublicLeaseViewWidget(MenuData data) : super(data);

  @override
  void request() 
  {
    presenter = new PublicLeasePresenter(this);
    (presenter as PublicLeasePresenter).onRequestDetail(type, panId, ccrCnntSysDsCd);
  }
}