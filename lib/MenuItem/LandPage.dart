import 'package:flutter/material.dart';
import 'package:bunyang/Data/ListItem.dart';
import 'package:xml/xml.dart' as xml;
import 'package:bunyang/Util/Util.dart';
import 'package:bunyang/Abstract/LoadingStateWidget.dart';

class LandPage extends LoadingStateful
{
  LandPage(this.item, String appBarTitle) : super(appBarTitle);

  final ListItem item;
  @override
  LandPageWidgetState createState() => LandPageWidgetState(item, appBarTitle);
}

class LandPageWidgetState extends LoadingStateWidget<LandPage>
{
  LandPageWidgetState(this.item, String appBarTitle) : super(appBarTitle);

  final ListItem item;
  xml.XmlDocument _xmldocument;

  @override
  void loadpage() async
  {
    try 
    {
      _xmldocument = await cachingData.requestItem(item.type, item.getParameter("PAN_ID"), item.getParameter("CCR_CNNT_SYS_DS_CD"));
      setState(() 
      {
        loadingState = LoadingState.DONE;
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
        return MyText("complete");

      case LoadingState.ERROR:
        return MyText("데이터를 불러오지 못했습니다!");

      default:
        return MyText("알수없는에러당");
    }
  }
}
