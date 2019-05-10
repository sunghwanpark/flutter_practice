import 'package:bunyang/Map/MyGoogleMapView.dart';
import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/MenuItem/Land/LandPagePresenter.dart';
import 'package:bunyang/MenuItem/Land/SupplyDateView.dart';
import 'package:bunyang/MenuItem/Land/SupplyLotOfLandInfoView.dart';
import 'package:bunyang/MenuItem/MenuItemModel.dart';
import 'package:bunyang/MenuItem/MenuItemPageView.dart';
import 'package:bunyang/Util/Util.dart';

class LandPage extends MenuItemPage
{
  LandPage(MenuData data) : super(data);

  @override
  LandPageView createState() => LandPageView(data);
}

class LandPageView extends MenuItemPageView<LandPage>
{
  LandPageView(MenuData data) : super(data);
  
  @override
  void initState() 
  {
    super.initState();
    presenter = new LandPagePresenter(this);
    presenter.onRequestPanInfo(type, RequestPanInfo(panId, ccrCnntSysDsCd, ''));
  }

  @override
  void onResponseSuccessPanInfo(Map<String, String> panInfo)
  {
    (presenter as LandPagePresenter).onRequestNotice(type, panId, ccrCnntSysDsCd, panInfo["PAN_KD_CD"], panInfo["OTXT_PAN_ID"]);
  }

  void onLoadComplete(Map<String, List<Map<String, String>>> landDatas)
  {
    if(landDatas["dsSplInfBidList"].length > 0)
    {
      contents.add(SupplyDateView(true, landDatas["dsLndInf"].first, landDatas["dsSplScdList"].where((data) => data["RNK_TYPE"] == "01").toList()));
      contents.add(SupplyLotOfLandInfoView(true, landDatas["dsSplInfBidList"]));
    }

    if(landDatas["dsSplInfLtrList"].length > 0)
    {
      contents.add(SupplyDateView(false, landDatas["dsLndInf"].first, landDatas["dsSplScdList"].where((data) => data["RNK_TYPE"] == "02").toList()));
      contents.add(SupplyLotOfLandInfoView(false, landDatas["dsSplInfLtrList"]));
    }
    
    if(landDatas["dsLndInf"].first["CTRT_PLC_ADR"].isNotEmpty && landDatas["dsLndInf"].first["CTRT_PLC_DTL_ADR"].isNotEmpty)
    {
      StringBuffer addressBuffer = StringBuffer();
      addressBuffer.write(landDatas["dsLndInf"].first["CTRT_PLC_ADR"]);
      addressBuffer.write(" ");
      addressBuffer.write(landDatas["dsLndInf"].first["CTRT_PLC_DTL_ADR"]);

      contents.add(MyGoogleMap("계약장소 정보", addressBuffer.toString()));
    }

    setState(() => loadingState = LoadingState.DONE);
  }
}
