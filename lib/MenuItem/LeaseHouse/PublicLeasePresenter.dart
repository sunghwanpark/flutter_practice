import 'package:bunyang/MenuItem/IntallmentHouse/IntallmentChangeSale/InstallmentChangeSalePresenter.dart';
import 'package:bunyang/MenuItem/LeaseHouse/PublicLeaseModel.dart';
import 'package:bunyang/MenuItem/LeaseHouse/PublicLeaseView.dart';

class PublicLeasePresenter extends InstallmentChangeSalePresenter<PublicLeaseViewWidget>
{
  PublicLeasePresenter(PublicLeaseViewWidget view) : super.model(new PublicLeaseModel(), view);
}