import 'package:auto_size_text/auto_size_text.dart';
import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/InstallmentHousePresenter.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/SummaryInfoView.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/SupplyInfoView.dart';
import 'package:bunyang/MenuItem/MenuItemModel.dart';
import 'package:bunyang/MenuItem/MenuItemPageView.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum DataListenState { DEFAULT, DETAIL, IMAGE }

class InstallmentHousePage extends MenuItemPage
{
  InstallmentHousePage(MenuData data) : super(data);

  @override
  InstallmentHouseView createState() => InstallmentHouseView(data);
}

class InstallmentHouseView extends MenuItemPageView<InstallmentHousePage> with SingleTickerProviderStateMixin
{
  InstallmentHouseView(MenuData data) : super(data)
  {
    _uppAisTpCd = this.data.getUppAisTPCD();

    var _tabNames = ['공고내용', '공급정보', '공고일정'];
    for(int i = 0; i < _tabNames.length; i++)
    {
      _tabs.add(Tab
      (
        icon: Text
        (
          _tabNames[i],
          style: TextStyle
          (
            fontSize: 18,
            inherit: true,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: 
            [
              Shadow( // bottomLeft
	              offset: Offset(-1.5, -1.5),
	              color: Colors.black
              ),
              Shadow( // bottomRight
	              offset: Offset(1.5, -1.5),
	              color: Colors.black
              ),
              Shadow( // topRight
	              offset: Offset(1.5, 1.5),
	              color: Colors.black
                ),
              Shadow( // topLeft
	              offset: Offset(-1.5, 1.5),
	              color: Colors.black
              ),
            ]
          )
        )
      ));
    }
  }

  String _uppAisTpCd;
  String _otxtPanId;
  String _aisInfSn;
  String _bztdCd;
  String _hcBlkCd;

  ScrollController _scrollController;
  TabController _tabController;

  List<Tab> _tabs = new List<Tab>();
  List<Widget> _infoView = new List<Widget>();
  List<Widget> _scheduleView = new List<Widget>();

  final Map<String, String> _defaultData = new Map<String, String>();
  final List<Map<String, String>> _publicInstallment = new List<Map<String, String>>();
  final List<Map<String, String>> _publicLease = new List<Map<String, String>>();
  final List<Map<String, String>> _publicInstallmentLease = new List<Map<String, String>>();

  @override
  void initState() 
  {
    super.initState();
    presenter = new InstallmentHousePresenter(this);
    presenter.onRequestPanInfo(type, RequestPanInfo(panId, ccrCnntSysDsCd, _uppAisTpCd));

    _scrollController = ScrollController();
    _tabController = TabController(length: _tabs.length, vsync: this, initialIndex: 0);
  }

  @override
  void dispose()
  {
    _scrollController.dispose();
    _tabController.dispose();
    
    super.dispose();

    _defaultData.clear();
    _publicInstallment.clear();
    _publicLease.clear();
    _publicInstallmentLease.clear();
  }

  @override
  void onResponseSuccessPanInfo(Map<String, String> panInfo) 
  {
    _otxtPanId = panInfo["OTXT_PAN_ID"];
    (presenter as InstallmentHousePresenter).onRequestDetail(type, panId, ccrCnntSysDsCd, _otxtPanId, _uppAisTpCd);
  }

  void onResponseDetail(Map<String, List<Map<String, String>>> res)
  {
    contents.add(SummaryInfoView(res["dsHsSlpa"].first));

    // list가 한개인 경우만
    if(res["dsHsAisList"].length == 1)
    {
      _aisInfSn = res["dsHsAisList"].first["AIS_INF_SN"];
      _bztdCd = res["dsHsAisList"].first["BZDT_CD"];
      _hcBlkCd = res["dsHsAisList"].first["HC_BLK_CD"];

      _defaultData.clear();
      _defaultData.addAll(res["dsHsAisList"].first);

      (presenter as InstallmentHousePresenter).onRequestSupplyInfoPublicInstallment(
        panId, ccrCnntSysDsCd, _aisInfSn, _otxtPanId, _uppAisTpCd, onResponsePublicInstallment);
    }
    else
    {
      setState(() {
        loadingState = LoadingState.DONE;
      });
    }
  }

  void onResponsePublicInstallment(Map<String, List<Map<String, String>>> res)
  {
    _publicInstallment.clear();
    _publicInstallment.addAll(res["dsHtyList"]);

    (presenter as InstallmentHousePresenter).onRequestSupplyInfoPublicInstallment(
        panId, ccrCnntSysDsCd, _aisInfSn, _otxtPanId, "06", onResponsePublicRentalType06, true, false);
  }

  void onResponsePublicRentalType06(Map<String, List<Map<String, String>>> res)
  {
    _publicLease.clear();
    _publicLease.addAll(res["dsHtyList"]);

    (presenter as InstallmentHousePresenter).onRequestSupplyInfoPublicInstallment(
        panId, ccrCnntSysDsCd, _aisInfSn, _otxtPanId, "06", onResponsePublicRentalType07, false, true);
  }

  void onResponsePublicRentalType07(Map<String, List<Map<String, String>>> res)
  {
    _publicInstallmentLease.clear();
    _publicInstallmentLease.addAll(res["dsHtyList"]);

    (presenter as InstallmentHousePresenter).onRequestSupplyInfoImage(
        panId, ccrCnntSysDsCd, _aisInfSn, _otxtPanId, _uppAisTpCd, onResponseFinally, _bztdCd, _hcBlkCd);
  }

  void onResponseFinally(Map<String, List<Map<String, String>>> res)
  {
    _infoView.add(SupplyInfo(_defaultData, _publicInstallment, _publicLease, _publicInstallmentLease, res["dsHsAhtlList"]));

    setState(() {
        loadingState = LoadingState.DONE;
    });
  }

  Widget _getContentSection(int idx)
  {
    switch (loadingState)
    {
      case LoadingState.DONE:
        if(idx == 0)
          return ListView(children: contents);
        else if(idx == 1)
          return ListView(children: _infoView);
        return ListView(children: _scheduleView);
      case LoadingState.ERROR:
        return myText("데이터를 불러오지 못했습니다!");
      case LoadingState.LOADING:
        return Container
        (
          alignment: Alignment.center,
          child: CircularProgressIndicator(backgroundColor: Colors.white)
        );
      default:
        return(Container());
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      backgroundColor: Colors.white,
      body: NestedScrollView
      (
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool boxIsScrolled)
        {
          return <Widget>
          [
            SliverAppBar
            (
              bottom: TabBar
              (
                tabs: _tabs,
                controller: _tabController,
                indicatorWeight: 5,
                indicatorColor: Colors.black26,
              ),
              expandedHeight: 300,
              iconTheme: IconThemeData
              (
                color: Colors.black
              ),
              flexibleSpace: FlexibleSpaceBar
              (
                titlePadding: EdgeInsets.only(bottom: 50, left: 80, right: 80),
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
          ];
        },
        body: TabBarView
        (
          controller: _tabController,
          children: <Widget>
          [
            _getContentSection(0),
            _getContentSection(1),
            _getContentSection(2)
          ]
        ),
      ),
    );
  }
}
