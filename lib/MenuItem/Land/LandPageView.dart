import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/Map/MyGoogleMapView.dart';
import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/MenuItem/Land/LandPageModel.dart';
import 'package:bunyang/MenuItem/Land/LandPagePresenter.dart';
import 'package:bunyang/MenuItem/Land/SupplyDateView.dart';
import 'package:bunyang/MenuItem/Land/SupplyLotOfLandInfoView.dart';
import 'package:flutter/material.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:tuple/tuple.dart';

class LandPage extends StatefulWidget
{
  LandPage(this.data);

  final MenuData data;

  @override
  LandPageView createState() => LandPageView(data);
}

class LandPageView extends State<LandPage> 
{
  LandPageView(this.data)
  {
    type = this.data.type;
    pan_id = this.data.getParameter("PAN_ID");
    ccr_cnnt_sys_ds_cd = this.data.getParameter("CCR_CNNT_SYS_DS_CD");
    appBarTitle = this.data.panName;
  }

  LandPagePresenter _presenter;
  
  final MenuData data;
  Notice_Code type;
  String pan_id;
  String ccr_cnnt_sys_ds_cd;
  String appBarTitle;

  LoadingState loadingState = LoadingState.LOADING;
  
  List<Widget> _contents = new List<Widget>();

  @override
  void initState() 
  {
    super.initState();
    _presenter = new LandPagePresenter(this);
    _presenter.onRequestPanInfo(type, pan_id, ccr_cnnt_sys_ds_cd);
  }

  void onResponseSuccessPanInfo(PanInfo panInfo)
  {
    _presenter.onRequestNotice(type, pan_id, ccr_cnnt_sys_ds_cd, panInfo);
  }

  void onLoadComplete(Map<String, List<Map<String, String>>> landDatas)
  {
    if(landDatas["dsSplInfBidList"].length > 0)
    {
      _contents.add(SupplyDateView(true, landDatas["dsLndInf"].first, landDatas["dsSplScdList"].where((data) => data["RNK_TYPE"] == "01").first));
      _contents.add(SupplyLotOfLandInfoView(true, landDatas["dsSplInfBidList"]));
    }

    if(landDatas["dsSplInfLtrList"].length > 0)
    {
      _contents.add(SupplyDateView(false, landDatas["dsLndInf"].first, landDatas["dsSplScdList"].where((data) => data["RNK_TYPE"] == "02").first));
      _contents.add(SupplyLotOfLandInfoView(false, landDatas["dsSplInfLtrList"]));
    }
    
    if(landDatas["dsLndInf"].first["CTRT_PLC_ADR"].isNotEmpty && landDatas["dsLndInf"].first["CTRT_PLC_DTL_ADR"].isNotEmpty)
    {
      StringBuffer addressBuffer = StringBuffer();
      addressBuffer.write(landDatas["dsLndInf"].first["CTRT_PLC_ADR"]);
      addressBuffer.write(" ");
      addressBuffer.write(landDatas["dsLndInf"].first["CTRT_PLC_DTL_ADR"]);

      _contents.add(MyGoogleMap("계약장소 정보", addressBuffer.toString()));
    }

    setState(() => loadingState = LoadingState.DONE);
  }

  void onLoadError()
  {
    setState(() => loadingState = LoadingState.ERROR);
  }

  Widget getContentSection()
  {
    switch (loadingState)
    {
      case LoadingState.DONE:
        return SliverList
        (
          delegate: SliverChildBuilderDelegate
          (
            (context, index) => _contents[index],
            childCount: _contents.length
          ),
        );
      case LoadingState.ERROR:
        return SliverList
        (
          delegate: SliverChildListDelegate(<Widget>
          [
            myText("데이터를 불러오지 못했습니다!")
          ])
        );
      case LoadingState.LOADING:
        return SliverList
        (
          delegate: SliverChildListDelegate(<Widget>
          [
            Container
            (
              alignment: Alignment.center,
              child: CircularProgressIndicator(backgroundColor: Colors.white)
            )
          ])
        );
      default:
        return SliverList
        (
          delegate: SliverChildListDelegate(<Widget>
          [
            Container()
          ])
        );
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      backgroundColor: Colors.white,
      body: CustomScrollView
      (
        primary: false,
        slivers: <Widget>
        [
          SliverAppBar
          (
            expandedHeight: 300,
            iconTheme: IconThemeData
            (
              color: Colors.black
            ),
            flexibleSpace: FlexibleSpaceBar
            (
              titlePadding: EdgeInsets.only(top: 200, left: 80, right: 80),
              centerTitle: true,
              title: AutoSizeText
              (
                appBarTitle,
                style: TextStyle
                (
                  color: Colors.white,
                  fontFamily: "TmonTium",
                  fontSize: 25,
                  fontWeight: FontWeight.w800
                ),
                maxLines: 3,
              ),
              background: Stack
              (
                fit: StackFit.expand,
                children: <Widget>
                [
                  Hero
                  (
                    tag: constNoticeCodeMap[type].code,
                    child: FadeInImage
                    (
                      fit: BoxFit.cover,
                      placeholder: AssetImage("assets/image/placeholder.jpg"),
                      image: constNoticeCodeMap[type].image
                    )
                  )
                ]
              )
            ),
          ),
          getContentSection()
        ], 
      ),
    );
  }
}
