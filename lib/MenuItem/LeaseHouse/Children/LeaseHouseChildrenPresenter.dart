import 'package:bunyang/MenuItem/LeaseHouse/Children/LeaseHouseChildrenModel.dart';
import 'package:bunyang/MenuItem/LeaseHouse/Children/LeaseHouseChildrenView.dart';
import 'package:bunyang/MenuItem/MenuItemPresenter.dart';

class LeaseHouseChildrenPresenter extends MenuItemPresenter<LeaseHouseChildrenModel>
{
  LeaseHouseChildrenPresenter(LeaseHouseChildrenViewState view) : super(LeaseHouseChildrenModel(), view);

  void onRequestDetail(Map<String, String> params)
  {
    model
      .fetchData(params)
      .then((res) => (view as LeaseHouseChildrenViewState).onResponseDetail(res))
      .catchError((onError) => view.onError(onError));
  }

  void onRequestHouseType(String panId, String ccrCnntSysDsCd, String sbdLgoNo, String ltrNot, String ltrUntNo, String sn) async
  {
    var res1 = await model.fetchHouseType({'PAN_ID' : panId, 'CCR_CNNT_SYS_DS_CD' : ccrCnntSysDsCd, 
                          'SBD_LGO_NO': sbdLgoNo, 'LTR_NOT': ltrNot, 'LTR_UNT_NO': ltrUntNo, 'SN': sn}, false)
                          .catchError((onError) => view.onError(onError));
    var res2 = await model.fetchHouseType({'PAN_ID' : panId, 'CCR_CNNT_SYS_DS_CD' : ccrCnntSysDsCd, 
                          'SBD_LGO_NO': sbdLgoNo, 'LTR_NOT': ltrNot, 'LTR_UNT_NO': ltrUntNo, 'SN': sn}, true)
                          .catchError((onError) => view.onError(onError));

    if(res1 != null)
      (view as LeaseHouseChildrenViewState).onResponseHouseType(res1);
    if(res2 != null)
      (view as LeaseHouseChildrenViewState).onResponseHouseAttatchment(res2);
  }
}