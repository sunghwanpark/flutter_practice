import "package:flutter/material.dart";
import "package:flutter_practice/Data/CachingData.dart";
import "package:flutter_practice/Data/ListItem.dart";
import "package:flutter_practice/MainMenu/ListItemWidget.dart";

enum LoadingState { DONE, LOADING, WAITING, ERROR }

class MainMenu extends StatefulWidget
{
  final CachingData cachingData = CachingData.instance();

  @override
  MainMenuWidgetState createState() => MainMenuWidgetState();
}

class MainMenuWidgetState extends State<MainMenu> 
{
  List<ListItem> _items = List();
  LoadingState _loadingState = LoadingState.LOADING;

  loadpage() async
  {
    try 
    {
      var items = await widget.cachingData.requestTest();
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
    return Center(child: _getContentSection());
  }

  Widget _getContentSection() 
  {
    switch (_loadingState) {
      case LoadingState.DONE:
        return ListView.builder(
          itemCount: _items.length,
          itemBuilder: (BuildContext context, int index)
          {
            return ListItemWidget(_items[index], index);
          }
        );
      case LoadingState.ERROR:
        return Text('Sorry, there was an error loading the data!');
      case LoadingState.LOADING:
        return CircularProgressIndicator();
      default:
        return Container();
    }
  }
}