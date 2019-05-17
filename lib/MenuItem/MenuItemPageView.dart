import 'package:auto_size_text/auto_size_text.dart';
import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/MenuItem/MenuItemPresenter.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';

abstract class MenuItemPage extends StatefulWidget
{
  MenuItemPage(this.data);

  final MenuData data;

  @override
  State<StatefulWidget> createState() {
    return null;
  }
}

abstract class MenuItemPageView<T extends MenuItemPage> extends State<T> with SingleTickerProviderStateMixin
{
  MenuItemPageView(this.data)
  {
    type = this.data.type;
    panId = this.data.getParameter("PAN_ID");
    ccrCnntSysDsCd = this.data.getParameter("CCR_CNNT_SYS_DS_CD");
    appBarTitle = this.data.panName;
  }

  final MenuData data;
  Notice_Code type;
  String panId;
  String ccrCnntSysDsCd;
  String appBarTitle;
  
  //List<Widget> contents = new List<Widget>();

  LoadingState loadingState = LoadingState.LOADING;

  MenuItemPresenter presenter;

  void onResponseSuccessPanInfo(Map<String, String> panInfo);

  void onError()
  {
    setState(() {
      loadingState = LoadingState.ERROR; 
    });
  }

  ScrollController _scrollController;
  TabController _tabController;

  @protected
  List<Tab> tabs = new List<Tab>();
  @protected
  List<List<Widget>> contents = new List<List<Widget>>();

  @override
  void initState() 
  {
    super.initState();

    _scrollController = ScrollController();
    _tabController = TabController(length: tabs.length, vsync: this, initialIndex: 0);
  }

  @override
  void dispose()
  {
    _scrollController.dispose();
    _tabController.dispose();
    
    super.dispose();
  }

  Widget _getContentSection(int idx)
  {
    switch (loadingState)
    {
      case LoadingState.DONE:
        return ListView(children: contents[idx]);
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
                tabs: tabs,
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
          children: contents <Widget>
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