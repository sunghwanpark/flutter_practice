import "package:flutter/material.dart";
import "package:bunyang/Data/CachingData.dart";
import "package:bunyang/Data/ListItem.dart";
import "package:bunyang/MainMenu/ListItemWidget.dart";
import 'package:bunyang/Util/Util.dart';
import 'package:bunyang/Abstract/LoadingStateWidget.dart';

class MainMenu extends LoadingStateful
{
  MainMenu(this.requestCode, String appBarTitle) :super(appBarTitle);

  final String requestCode;
  final CachingData cachingData = CachingData.instance();

  @override
  MainMenuWidgetState createState() => MainMenuWidgetState(requestCode, appBarTitle);
}

class MainMenuWidgetState extends LoadingStateWidget<MainMenu> 
{
  MainMenuWidgetState(this.requestCode, String appBarTitle) : super(appBarTitle);

  final String requestCode;

  List<ListItem> _items = List();

  @override
  void loadpage() async
  {
    try 
    {
      var items = await cachingData.request(requestCode);
      setState(() 
      {
        loadingState =LoadingState.DONE;
        _items.addAll(items); 
      });  
    } 
    catch (e) 
    {
      setState(() => loadingState = LoadingState.ERROR);
    }
  }

  @override
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
}