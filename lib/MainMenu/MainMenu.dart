import "package:flutter/material.dart";
import "package:bunyang/Data/CachingData.dart";
import "package:bunyang/Data/ListItem.dart";
import "package:bunyang/MainMenu/ListItemWidget.dart";
import 'package:bunyang/Util/Util.dart';

enum LoadingState { DONE, LOADING, WAITING, ERROR }

class MainMenu extends StatefulWidget
{
  MainMenu(this.requestCode);

  final String requestCode;
  final CachingData cachingData = CachingData.instance();

  @override
  MainMenuWidgetState createState() => MainMenuWidgetState(requestCode);
}

class MainMenuWidgetState extends State<MainMenu> 
{
  MainMenuWidgetState(this.requestCode);

  final String requestCode;
  List<ListItem> _items = List();
  LoadingState _loadingState = LoadingState.LOADING;

  loadpage() async
  {
    try 
    {
      var items = await widget.cachingData.request(requestCode);
      setState(() 
      {
        _loadingState =LoadingState.DONE;
        _items.addAll(items); 
      });  
    } 
    catch (e) 
    {
      setState(() => _loadingState = LoadingState.ERROR);
    }
  }

  @override
  void initState() {
    super.initState();

    loadpage();
  }

  @override
  Widget build(BuildContext context)
  {
    String _title = _items.isEmpty ? "" : _items[0] .typeString;
    return Scaffold
    (
      appBar: new AppBar(title: MyText(_title)),
      body: _getContentSection(),
    );
  }

  Widget _getContentSection() 
  {
    switch (_loadingState) {
      case LoadingState.DONE:
        if(_items.length == 0)
          return Container
          (

            alignment: Alignment.center,
            child: MyText("공고가 없어요!"),
            color: Colors.white,
          );

        return ListView.builder(
          itemCount: _items.length,
          itemBuilder: (BuildContext context, int index)
          {
            return ListItemWidget(_items[index], index);
          }
        );
      case LoadingState.ERROR:
      return MyText('데이터를 불러들이지 못했어요!');
      case LoadingState.LOADING:
        return CircularProgressIndicator(backgroundColor: Colors.white);
      default:
        return Container();
    }
  }
}