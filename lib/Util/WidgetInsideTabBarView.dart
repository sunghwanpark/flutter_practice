import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class WidgetInsideTabBar extends StatefulWidget
{
  WidgetInsideTabBar
  (
    {
      @required List<String> tabNames,
      @required List<Widget> contents
    }
  ) : _tabNames = tabNames,
  _contents = contents;

  final List<String> _tabNames;
  final List<Widget> _contents;

  @override
  WidgetInsideTabBarView createState() => WidgetInsideTabBarView();
}

class WidgetInsideTabBarView extends State<WidgetInsideTabBar> with SingleTickerProviderStateMixin 
{
  ScrollController _scrollController;
  TabController _tabController;

  int _currentTabIdx = 0;

  @override
  void initState() 
  {
    super.initState();

    _scrollController = ScrollController();
    _tabController = TabController(length: widget._tabNames.length, vsync: this, initialIndex: 0);
    _tabController.addListener(()
    {
      if(_tabController.indexIsChanging)
      {
        setState(() {
          _currentTabIdx = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose()
  {
    _scrollController.dispose();
    _tabController.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return Container
    (
      width: MediaQuery.of(context).size.width,
      child: Column
      (
        children: <Widget>
        [
          SingleChildScrollView
          (
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 5, right: 5),
            child: TabBar
            (
              controller: _tabController,
              isScrollable: true,
              indicatorPadding: EdgeInsets.only(left: 5, right: 5),
              indicatorColor: Colors.blueGrey[600],
              tabs: widget._tabNames.map((str)
              {
                return Tab
                (
                  icon: Icon(Icons.home, size: 30, color: Colors.black),
                  child: Container
                  (
                    constraints: BoxConstraints.tightFor(width: 200),
                    alignment: Alignment.center,
                    child: AutoSizeText(str, maxLines: 1, style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'TmonTium'))
                  )
                );
              }).toList()
            )
          ),
          widget._contents[_currentTabIdx]
        ]
      )
    );
  }
}