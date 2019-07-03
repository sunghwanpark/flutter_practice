
import 'package:bunyang/MenuItem/HoneymoonTown/HoneymoonInquiry/HoneymoonInquiryModel.dart';
import 'package:bunyang/MenuItem/HoneymoonTown/HoneymoonInquiry/HoneymoonInquiryView.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/InstallmentHouseInquiry/InstallmentHouseInquiryPresenter.dart';

class HoneymoonInquiryPresenter extends InstallmentHouseInquiryPresenter
{
  HoneymoonInquiryPresenter(HoneymoonInquiryView _view) : super.extend(HoneymoonInquiryModel(), _view);
}