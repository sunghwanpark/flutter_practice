import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/MenuItem/HoneymoonTown/HoneymoonInquiry/HoneymoonInquiryPresenter.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/InstallmentHouseInquiry/InstallmentHouseInquiryView.dart';

class HoneymoonInquiry extends InstallmentHouseInquiry
{
  HoneymoonInquiry(Map<String, String> requestData, String uppAisTpCd)
  : super.extend(requestData, uppAisTpCd, Notice_Code.honeymoon_lease, '신혼희망타운 상세정보', 200);

  @override
  HoneymoonInquiryView createState() => HoneymoonInquiryView();
}

class HoneymoonInquiryView extends InstallmentHouseInquiryView
{
  @override
  void makePresenter()
  {
    presenter = HoneymoonInquiryPresenter(this);
    (presenter as HoneymoonInquiryPresenter).onRequestData(
      widget.requestData['PAN_ID'],
      widget.requestData['CCR_CNNT_SYS_DS_CD'],
      widget.uppAisTpCd,
      widget.requestData['AIS_INF_SN'],
      widget.requestData['BZDT_CD'],
      widget.requestData['HC_BLK_CD']);
  }
}