import 'package:bunyang/Data/Address.dart';
import 'package:flutter/material.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:bunyang/MenuItem/Land/SupplyDate.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class LandPage extends StatefulWidget
{
  LandPage(this.type, this.pan_id, this.ccr_cnnt_sys_ds_cd, this.appBarTitle);

  final Notice_Code type;
  final String pan_id;
  final String ccr_cnnt_sys_ds_cd;
  final String appBarTitle;

  @override
  LandPageView createState() => LandPageView(type, pan_id, ccr_cnnt_sys_ds_cd, appBarTitle);
}

class LandPageView extends State<LandPage> implements 
{
  LandPageView(this.type, this.pan_id, this.ccr_cnnt_sys_ds_cd, this.appBarTitle);

  final Notice_Code type;
  final String pan_id;
  final String ccr_cnnt_sys_ds_cd;
  final String appBarTitle;

  LoadingState loadingState = LoadingState.LOADING;
  Map<String, Map<String, String>> _dataSetMap = new Map<String, Map<String, String>>();
  List<Widget> _contents = new List<Widget>();

  @override
  void initState() 
  {
    super.initState();
    _menuPresenter.onRequestNotice(requestCode);
  }
  
  void loadpage() async
  {
    try 
    {
      var xmldocument = await cachingData.requestItem(type, pan_id, ccr_cnnt_sys_ds_cd);

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
