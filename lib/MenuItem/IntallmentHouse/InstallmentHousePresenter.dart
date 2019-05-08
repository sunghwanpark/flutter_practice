import 'package:bunyang/MenuItem/IntallmentHouse/InstallmentHouseModel.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/InstallmentHouseView.dart';
import 'package:bunyang/MenuItem/MenuItemPresenter.dart';

class InstallmentHousePresenter extends MenuItemPresenter<InstallmentHouseModel>
{
  InstallmentHousePresenter(InstallmentHouseView view) : super(new InstallmentHouseModel(), view);
}