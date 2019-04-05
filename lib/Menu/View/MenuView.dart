import 'dart:ui';

import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/Menu/Presenter/MenuPresenter.dart';
import "package:flutter/material.dart";
import "package:bunyang/Menu/View/ListItemWidget.dart";
import 'package:bunyang/Util/Util.dart';

class Menu extends StatefulWidget
{
  Menu(this.appBarTitle, this.menuData);

  final String appBarTitle;
  final MainMenuData menuData;

  @override
  MenuView createState() => MenuView(appBarTitle, menuData);
}

class MenuView extends State<Menu>
{
  MenuView(this.appBarTitle, this.menuData);

  final String appBarTitle;
  final MainMenuData menuData;

  MenuPresenter _menuPresenter;

  LoadingState loadingState = LoadingState.LOADING;

  List<MenuData> _items = new List<MenuData>();

  @override
  void initState() 
  {
    super.initState();
    _menuPresenter = new MenuPresenter(this);
    _menuPresenter.onRequestNotice(menuData.code);
  }
  
  void onLoadComplete(List<MenuData> items)
  {
    _items.addAll(items); 
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
        if(_items.length == 0)
          return myText('데이터가 없어요!', Colors.black);

        return ListView.builder
        (
          itemCount: _items.length,
          itemBuilder: (BuildContext context, int index)
          {
            return ListItemWidget(_items[index], index);
          }
        );
      case LoadingState.ERROR:
        return myText('데이터를 불러들이지 못했어요!', Colors.black);
      case LoadingState.LOADING:
        return CircularProgressIndicator(strokeWidth: 1.0);
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Stack
    (
      fit: StackFit.expand,
      children: <Widget>
      [
        Positioned.fill
        (
          child: Hero
          (
            tag: menuData.code,
            child: FadeInImage
            ( 
              placeholder: AssetImage("assets/image/placeholder.jpg"),
              image: menuData.image,
              fit: BoxFit.cover,
            )
          ),
        ),
        BackdropFilter
        (
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: new Container
          (
            color: Colors.black.withOpacity(0.2)
          )
        ),
        Scaffold
        (
          backgroundColor: Colors.transparent,
          appBar: AppBar
          (
            title: myText(appBarTitle, Colors.black),
            iconTheme: IconThemeData
            (
              color: Colors.black
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
          ),
          body: Center
          (
            child: getContentSection()
          )
        )
      ],
    );
  }
}