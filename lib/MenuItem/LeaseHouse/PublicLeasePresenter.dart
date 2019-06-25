import 'package:bunyang/MenuItem/LeaseHouse/PublicLeaseModel.dart';
import 'package:bunyang/MenuItem/MenuItemModel.dart';
import 'package:bunyang/MenuItem/MenuItemPageView.dart';
import 'package:bunyang/MenuItem/MenuItemPresenter.dart';

class PublicLeasePresenter extends MenuItemPresenter<PublicLeaseModel>
{
  PublicLeasePresenter(MenuItemPageView<MenuItemPage> view) : super(new PublicLeaseModel(), view);
  
}