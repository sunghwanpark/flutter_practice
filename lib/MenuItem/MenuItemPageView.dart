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

abstract class MenuItemPageView<T extends MenuItemPage> extends State<T>
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
  
  List<Widget> contents = new List<Widget>();

  LoadingState loadingState = LoadingState.LOADING;

  MenuItemPresenter presenter;

  void onResponseSuccessPanInfo(Map<String, String> panInfo);

  void onError()
  {
    setState(() {
      loadingState = LoadingState.ERROR; 
    });
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
            (context, index) => contents[index],
            childCount: contents.length
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