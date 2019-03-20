import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/MenuItem/Land/LandPageModel.dart';
import 'package:bunyang/MenuItem/Land/LandPagePresenter.dart';
import 'package:bunyang/MenuItem/Land/SupplyDateView.dart';
import 'package:flutter/material.dart';
import 'package:bunyang/Util/Util.dart';
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

class LandPageView extends State<LandPage> 
{
  LandPageView(this.type, this.pan_id, this.ccr_cnnt_sys_ds_cd, this.appBarTitle);

  LandPagePresenter _presenter;
  
  final Notice_Code type;
  final String pan_id;
  final String ccr_cnnt_sys_ds_cd;
  final String appBarTitle;

  LoadingState loadingState = LoadingState.LOADING;
  
  List<Widget> _contents = new List<Widget>();

  @override
  void initState() 
  {
    super.initState();
    _presenter = new LandPagePresenter(this);
    _presenter.onRequestNotice(type, pan_id, ccr_cnnt_sys_ds_cd);
  }

  void onLoadComplete(SupplyDate supplyDate)
  {
    _contents.add(SupplyDateView(supplyDate));
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
