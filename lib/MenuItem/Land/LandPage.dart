import 'package:flutter/material.dart';
import 'package:bunyang/Data/ListItem.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:bunyang/Abstract/LoadingStateWidget.dart';
import 'package:bunyang/MenuItem/Land/SupplyDate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
  Map<String, Map<String, String>> _dataSetMap = new Map<String, Map<String, String>>();
  List<Widget> _contents = new List<Widget>();

  @override
  void loadpage() async
  {
    try 
    {
      var xmldocument = await cachingData.requestItem(item.type, item.getParameter("PAN_ID"), item.getParameter("CCR_CNNT_SYS_DS_CD"));

      var dataSet = xmldocument.findAllElements("Dataset");
      dataSet.forEach((elem)
      {
        _dataSetMap[elem.getAttribute('id')] = new Map<String, String>();
        print(elem.getAttribute('id'));
        elem.findAllElements('Col')
        .forEach((colElem)
        {
          print(colElem.toString());
          _dataSetMap[elem.getAttribute('id')][colElem.getAttribute('id')] = colElem.text;
        });
      });

      _contents.add(SupplyDate
            (
              applyDate: _dataSetMap['dsSplScdList']['RQS_DTTM'],
              applyReserveDepositEndDate: _dataSetMap['dsSplScdList']['CLSG_DTTM'],
              pickDate: _dataSetMap['dsLndInf']['LTR_DTTM'],
              resultNoticeDate: _dataSetMap['dsLndInf']['PZWR_NT_DTTM'],
              contractDateStartAt: _dataSetMap['dsLndInf']['CTRT_ST_DT'],
              contractDateEndAt: _dataSetMap['dsLndInf']['CTRT_ED_DT'],
            ));

      _contents.add(Text('haha', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)));

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
        return StaggeredGridView.countBuilder
        (
          primary: false,
          crossAxisCount: 1,
          mainAxisSpacing: 4,
          itemCount: _contents.length,
          itemBuilder: (context, index) => _contents[index],
          staggeredTileBuilder: (index) => StaggeredTile.fit(1),
        );

      case LoadingState.ERROR:
        return MyText("데이터를 불러오지 못했습니다!");

      case LoadingState.LOADING:
        return CircularProgressIndicator(backgroundColor: Colors.white);

      default:
        return Container();
    }
  }

  
}
