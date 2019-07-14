import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/MenuItem/Land/ProductDetail/BusinessShortInfoView.dart';
import 'package:bunyang/MenuItem/Land/ProductDetail/LocateInfoView.dart';
import 'package:bunyang/MenuItem/Land/ProductDetail/PlanView.dart';
import 'package:bunyang/MenuItem/Land/ProductDetail/ProductDetailPresenter.dart';
import 'package:bunyang/MenuItem/Land/SupplyLotOfLandInfoView.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget
{
  ProductDetail(this.requestPageData);

  final DetailPageData requestPageData;

  @override
  ProductDetailView createState() => ProductDetailView(requestPageData);
}

class ProductDetailView extends State<ProductDetail> with SingleTickerProviderStateMixin
{
  ProductDetailView(this.requestPageData);

  final int _tabCount = 2;
  var tabs = const <Tab>
  [
    Tab(icon: Text('사업개요')),
    Tab(icon: Text('필지안내'))
  ];

  final DetailPageData requestPageData;

  ProductDetailPresenter _presenter;

  LoadingState loadingState = LoadingState.LOADING;

  List<Widget> _businessView = new List<Widget>();
  List<Widget> _locateInfoView = new List<Widget>();

  ScrollController _scrollController;
  TabController _tabController;
  
  @override
  void initState() 
  {
    super.initState();

    _scrollController = ScrollController();
    _tabController = TabController(length: _tabCount, vsync: this, initialIndex: 0);

    _presenter = new ProductDetailPresenter(this);
    _presenter.onRequestDetailinfo(requestPageData);
  }

  @override
  void dispose()
  {
    _scrollController.dispose();
    _tabController.dispose();

    super.dispose();
  }
  
  void onComplete(Map<String, List<Map<String, String>>> res)
  {
    _makeBusinessView(res);
    _makeLocateInfoView(res);

    setState(() => loadingState = LoadingState.DONE);
  }

  void onError(dynamic err)
  {
    print(err);
    setState(() => loadingState = LoadingState.ERROR);
  }

  void _makeBusinessView(Map<String, List<Map<String, String>>> res)
  {
    _businessView.add(BusinessShortInfoView(res["dsLndInf"].first, res['dsAhflList']));
    if(res["dsLndHsList"].length > 0)
      _businessView.add(PlanView(res["dsLndHsList"]));
  }

  void _makeLocateInfoView(Map<String, List<Map<String, String>>> res)
  {
    _locateInfoView.add(LocateInfoView(res["dsLoldInf"].first,
      res["dsLndInf"].first["CCR_CNNT_SYS_DS_CD"],
      res["dsLndInf"].first["AIS_INF_SN"]));
  }

  Widget _getContentSection(int idx)
  {
    switch (loadingState)
    {
      case LoadingState.DONE:
        if(idx == 0)
          return ListView(children: _businessView);
        return ListView(children: _locateInfoView);
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
              pinned: true,
              floating: true,
              forceElevated: boxIsScrolled,
              expandedHeight: 200,
              iconTheme: IconThemeData
              (
                color: Colors.black
              ),
              bottom: TabBar(indicatorColor: Colors.black, tabs: tabs, controller: _tabController),
              flexibleSpace: FlexibleSpaceBar
              (
                titlePadding: EdgeInsets.only(bottom: 50, left: 80, right: 80),
                centerTitle: true,
                title: Text
                (
                  "토지 상세 정보",
                  style: TextStyle
                  (
                    color: Colors.white,
                    fontFamily: "TmonTium",
                    fontSize: 25,
                    fontWeight: FontWeight.w800
                  )
                ),
                background: Stack
                (
                  fit: StackFit.expand,
                  children: <Widget>
                  [
                    Hero
                    (
                      tag: constNoticeCodeMap[Notice_Code.land].code,
                      child: FadeInImage
                      (
                        fit: BoxFit.cover,
                        placeholder: AssetImage("assets/image/placeholder.jpg"),
                        image: constNoticeCodeMap[Notice_Code.land].image
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
            _getContentSection(1)
          ]
        ),
      ),
    );
  }
}