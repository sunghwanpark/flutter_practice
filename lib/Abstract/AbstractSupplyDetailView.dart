import 'package:bunyang/Abstract/IErrorCallBack.dart';
import 'package:bunyang/Abstract/IMakePresenter.dart';
import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';

abstract class AbstractSupplyDetailView extends StatefulWidget
{
  AbstractSupplyDetailView(
    {
      @required Map<String, String> params,
      @required Notice_Code code
    }) : this.requestParams = params, noticeCode = code;

  final Map<String, String> requestParams;
  final Notice_Code noticeCode;

  @override
  AbstractSupplyDetailWidget createState();
}

abstract class AbstractSupplyDetailWidget<T extends AbstractSupplyDetailView> extends State<T> implements IErrorCallBack, IMakePresenter
{
  LoadingState _loadingState = LoadingState.LOADING;

  @override
  void initState()
  {
    super.initState();
    makePresenter();
  }

  @override
  void makePresenter()
  {
  }

  void onError(dynamic err)
  {
    print(err);
    print(StackTrace.current);
    setState(() {
     _loadingState = LoadingState.ERROR; 
    });
  }

  @protected
  List<Widget> getContents();

  void onComplete(Map<String, List<Map<String, String>>> res);

  void loadingComplete()
  {
    setState(() {
      _loadingState = LoadingState.DONE;
    });
  }

  Widget _getContentSection(BuildContext context)
  {
    switch (_loadingState)
    {
      case LoadingState.DONE:
        return SliverList
        (
          delegate: SliverChildListDelegate(getContents())
        );
      case LoadingState.ERROR:
        return SliverList
        (
          delegate: SliverChildListDelegate(<Widget>
          [
            myText("데이터를 불러오지 못했습니다!")
          ])
        );
      case LoadingState.LOADING:
        return SliverList
        (
          delegate: SliverChildListDelegate(<Widget>
          [
            Container
            (
              alignment: Alignment.center,
              child: CircularProgressIndicator(backgroundColor: Colors.white)
            )
          ])
        );
      default:
        return SliverList
        (
          delegate: SliverChildListDelegate(<Widget>
          [
            Container()
          ])
        );
    }
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      backgroundColor: Colors.white,
      body: CustomScrollView
      (
        primary: false,
        slivers: <Widget>
        [
          SliverAppBar
          (
            expandedHeight: 200,
            iconTheme: IconThemeData
            (
              color: Colors.black
            ),
            flexibleSpace: FlexibleSpaceBar
            (
              titlePadding: EdgeInsets.only(bottom: 20, left: 80, right: 80),
              centerTitle: true,
              title: Text
              (
                "공급정보 상세보기",
                style: TextStyle
                (
                  color: Colors.white,
                  fontFamily: "TmonTium",
                  fontSize: 25,
                  fontWeight: FontWeight.w800
                )
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
          _getContentSection(context)
        ], 
      ),
    );
  }
}