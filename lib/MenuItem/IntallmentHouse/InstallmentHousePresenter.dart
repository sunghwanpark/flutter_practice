import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/InstallmentHouseModel.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/InstallmentHouseView.dart';

class InstallmentHousePresenter
{
  InstallmentHouseModel _model;
  InstallmentHouseView _view;

  InstallmentHousePresenter(this._view)
  {
    _model = new InstallmentHouseModel();
  }
}