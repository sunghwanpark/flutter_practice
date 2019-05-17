import 'package:auto_size_text/auto_size_text.dart';
import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/MenuItem/MenuItemPageView.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';

abstract class AbstractInstallmentHouse extends MenuItemPage
{
  AbstractInstallmentHouse(MenuData data) : super(data);

  @override
  State<StatefulWidget> createState() {
    return super.createState();
  }
}

abstract class AbstractInstallmentHouseView<T extends AbstractInstallmentHouse> extends MenuItemPageView<T>
{
  AbstractInstallmentHouseView(MenuData data) : super(data)
  {
    uppAisTpCd = this.data.getUppAisTPCD();

    var _tabNames = ['공고내용', '공급정보', '공고일정'];
    for(int i = 0; i < _tabNames.length; i++)
    {
      tabs.add(Tab
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

  @protected
  String uppAisTpCd;
  
  @protected
  List<Widget> infoView = new List<Widget>();
  @protected
  List<Widget> scheduleView = new List<Widget>();

  Widget _getContentSection(int idx)
  {
    switch (loadingState)
    {
      case LoadingState.DONE:
        if(idx == 0)
          return ListView(children: contents);
        else if(idx == 1)
          return ListView(children: infoView);
        return ListView(children: scheduleView);
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
