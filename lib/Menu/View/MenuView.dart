import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/Menu/Presenter/MenuPresenter.dart';
import "package:flutter/material.dart";
import "package:bunyang/Menu/View/ListItemWidget.dart";
import 'package:bunyang/Util/Util.dart';

class Menu extends StatefulWidget
{
  Menu(this.requestCode, this.appBarTitle);

  final String requestCode;
  final String appBarTitle;

  @override
  MenuView createState() => MenuView(requestCode, appBarTitle);
}

class MenuView extends State<Menu>
{
  MenuView(this.requestCode, this.appBarTitle);

  final String requestCode;
  final String appBarTitle;

  MenuPresenter _menuPresenter;

  LoadingState loadingState = LoadingState.LOADING;

  List<MenuData> _items = new List<MenuData>();

  @override
  void initState() 
  {
    super.initState();
    _menuPresenter = new MenuPresenter(this);
    _menuPresenter.onRequestNotice(requestCode);
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
          return MyText('데이터가 없어요!', Colors.black);

        return ListView.builder
        (
          itemCount: _items.length,
          itemBuilder: (BuildContext context, int index)
          {
            return ListItemWidget(_items[index], index);
          }
        );
      case LoadingState.ERROR:
        return MyText('데이터를 불러들이지 못했어요!', Colors.black);
      case LoadingState.LOADING:
        return CircularProgressIndicator(backgroundColor: Colors.white);
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Container
    (
      child: Stack
      (
        fit: StackFit.expand,
        children: <Widget>
        [
          Image.asset("assets/image/bg3.jpg", fit: BoxFit.fitHeight),
          Scaffold
          (
            backgroundColor: Colors.transparent,
            appBar: AppBar
            (
              title: MyText(appBarTitle, Colors.white),
              elevation: 0.0,
              backgroundColor: const Color(0xFF353535).withOpacity(0.2),
              centerTitle: true,
            ),
            body: Center
            (
              child: Container
              (
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(10.0),
                child: getContentSection(),
              ),
            ),
          )
        ]
      )
    );
  }
}