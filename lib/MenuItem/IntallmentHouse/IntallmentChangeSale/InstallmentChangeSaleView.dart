import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/Abstract/AbstractInstallmentHouseView.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/IntallmentChangeSale/InstallmentChangeSalePresenter.dart';
import 'package:bunyang/Util/Util.dart';

class InstallmentChangeSale extends AbstractInstallmentHouse
{
  InstallmentChangeSale(MenuData data) : super(data);

  @override
  InstallmentChangeSaleView createState() => InstallmentChangeSaleView(data);
}

class InstallmentChangeSaleView extends AbstractInstallmentHouseView<InstallmentChangeSale>
{
  InstallmentChangeSaleView(MenuData data) : super(data);

  final Map<String, List<Map<String, String>>> _defaultData = new Map<String, List<Map<String, String>>>();
  final List<Map<String, String>> _typeofHouseData = new List<Map<String, String>>();
  final List<Map<String, String>> _typeofHouseDataAttachment = new List<Map<String, String>>();

  int _tabLen = 0;

  @override
  void initState() 
  {
    super.initState();
    presenter = new InstallmentChangeSalePresenter(this);
    (presenter as InstallmentChangeSalePresenter).onRequestDetail(type, panId, ccrCnntSysDsCd);
  }

  void onResponseDetail(Map<String, List<Map<String, String>>> res)
  {
    _defaultData.clear();
    _defaultData.addAll(res);

    res["dsSbdInf"].forEach((map)
    {
      (presenter as InstallmentChangeSalePresenter).onRequestHouseType(
        panId, ccrCnntSysDsCd, map["SBD_LGO_NO"], map["LTR_NOT"], map["LTR_UNT_NO"], map["SN"]);
      
      (presenter as InstallmentChangeSalePresenter).onRequestHouseTypeAttatchment(
        panId, ccrCnntSysDsCd, map["SBD_LGO_NO"], map["LTR_NOT"], map["LTR_UNT_NO"], map["SN"]);
    });

    _tabLen = res["dsSbdInf"].length;
  }

  void onResponseHouseType(Map<String, List<Map<String, String>>> res)
  {
    _typeofHouseData.add(res["dsHtyInf"].length > 0 ? res["dsHtyInf"].first : null);

    if(_typeofHouseData.length == _tabLen && _typeofHouseDataAttachment.length == _tabLen)
    {
      setState(() {
       loadingState = LoadingState.DONE; 
      });
    }
  }

  void onResponseHouseAttatchment(Map<String, List<Map<String, String>>> res)
  {
    _typeofHouseDataAttachment.add(res["dsSdbAhflInf"].length > 0 ? res["dsSdbAhflInf"].first : null);

    if(_typeofHouseData.length == _tabLen && _typeofHouseDataAttachment.length == _tabLen)
    {
      setState(() {
       loadingState = LoadingState.DONE; 
      });
    }
  }

  @override
  void onResponseSuccessPanInfo(Map<String, String> panInfo) {}
}
