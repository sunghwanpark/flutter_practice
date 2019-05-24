import 'package:auto_size_text/auto_size_text.dart';
import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';

abstract class TabStatefull extends StatefulWidget
{
  TabStatefull(
    {
      @required this.noticeCode,
      @required this.appBarTitle,
      double expandedHeight = 300,
      EdgeInsetsGeometry edgeInsets = const EdgeInsets.only(bottom: 50, left: 80, right: 80) }) 
  : _expandedHeight = expandedHeight,
  _edgeInsetsGeometry = edgeInsets;

  final Notice_Code noticeCode;
  final String appBarTitle;
  final double _expandedHeight;
  final EdgeInsetsGeometry _edgeInsetsGeometry;
  
  @override
  State<StatefulWidget> createState() {
    return null;
  }
}

abstract class TabStateView<T extends TabStatefull> extends State<T> with SingleTickerProviderStateMixin
{
  LoadingState loadingState = LoadingState.LOADING;

  ScrollController _scrollController;
  TabController _tabController;

  @protected
  List<String> tabNames = new List<String>();

  @protected
  Map<int, List<Widget>> contents = new Map<int, List<Widget>>();

  @override
  void initState() 
  {
    super.initState();

    _scrollController = ScrollController();
    _tabController = TabController(length: tabNames.length, vsync: this, initialIndex: 0);
  }

  @override
  void dispose()
  {
    _scrollController.dispose();
    _tabController.dispose();
    
    super.dispose();
  }

  void onError()
  {
    setState(() {
      loadingState = LoadingState.ERROR; 
    });
  }

  Widget _getContentSection(List<Widget> content)
  {
    switch (loadingState)
    {
      case LoadingState.DONE:
        return ListView(children: content);
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
                tabs: tabNames.map((str)
                {
                  return Tab
                  (
                    icon: Text
                    (
                      str,
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
                  );
                }).toList(),
                controller: _tabController,
                indicatorWeight: 5,
                indicatorColor: Colors.black26,
              ),
              expandedHeight: widget._expandedHeight,
              iconTheme: IconThemeData
              (
                color: Colors.black
              ),
              flexibleSpace: FlexibleSpaceBar
              (
                titlePadding: widget._edgeInsetsGeometry,
                centerTitle: true,
                title: AutoSizeText
                (
                  widget.appBarTitle,
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
                      tag: constNoticeCodeMap[widget.noticeCode].code,
                      child: FadeInImage
                      (
                        fit: BoxFit.cover,
                        placeholder: AssetImage("assets/image/placeholder.jpg"),
                        image: constNoticeCodeMap[widget.noticeCode].image
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
          children: contents.values.map((content) => _getContentSection(content)).toList()
        ),
      ),
    );
  }
}