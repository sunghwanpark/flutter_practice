import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/Abstract/AbstractInstallmentHouseView.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/IntallmentChangeSale/ChargeSaleSummaryInfoView.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/IntallmentChangeSale/ChargeScheduleView.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/IntallmentChangeSale/InstallmentChangeSaleView.dart';
import 'package:bunyang/MenuItem/LeaseHouse/Children/LeaseHouseChildrenPresenter.dart';

class LeaseHouseChildrenView extends InstallmentChangeSale
{
  LeaseHouseChildrenView(MenuData data) : super(data);

  @override
  LeaseHouseChildrenViewState createState() => LeaseHouseChildrenViewState(data);
}

class LeaseHouseChildrenViewState extends InstallmentChangeSaleView
{
  LeaseHouseChildrenViewState(MenuData data) : super(data);
  
  @override
  void makePresenter() 
  {
    presenter = new LeaseHouseChildrenPresenter(this);
    (presenter as LeaseHouseChildrenPresenter).onRequestDetail({'PAN_ID': panId, 'CCR_CNNT_SYS_DS_CD': ccrCnntSysDsCd});
  }

  void onResponseDetail(Map<String, List<Map<String, String>>> res)
  {
    defaultData.clear();
    defaultData.addAll(res);
    contents[InstallmentTabState.Contents.index].add(ChargeSaleSummaryInfoView(defaultData));
    contents[InstallmentTabState.Schedule.index].add(ChargeScheduleView(defaultData));

    res["dsSbdInf"].forEach((map)
    {
      (presenter as LeaseHouseChildrenPresenter).onRequestHouseType(
        panId, ccrCnntSysDsCd, map["SBD_LGO_NO"], map["LTR_NOT"], map["LTR_UNT_NO"], map["SN"]);
    });

    tabLen = res["dsSbdInf"].length;
  }
}