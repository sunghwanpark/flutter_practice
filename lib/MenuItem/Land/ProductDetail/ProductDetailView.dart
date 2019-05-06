import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/MenuItem/Land/LandPageModel.dart';
import 'package:bunyang/MenuItem/Land/ProductDetail/ProductDetailPresenter.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget
{
  ProductDetail(this.requestPageData);

  final DetailPageData requestPageData;

  @override
  ProductDetailView createState() => ProductDetailView(requestPageData);
}

class ProductDetailView extends State<ProductDetail>
{
  ProductDetailView(this.requestPageData);

  final DetailPageData requestPageData;

  ProductDetailPresenter _presenter;

  LoadingState loadingState = LoadingState.LOADING;

  List<Widget> _contents = new List<Widget>();
  
  @override
  void initState() 
  {
    super.initState();
    _presenter = new ProductDetailPresenter(this);
    _presenter.onRequestDetailinfo(requestPageData);
  }
  
  void onComplete(Map<String, List<Map<String, String>>> res)
  {

  }

  void onError()
  {

  }

  Widget getContentSection()
  {
    switch (loadingState)
    {
      case LoadingState.DONE:
        return SliverList
        (
          delegate: SliverChildBuilderDelegate
          (
            (context, index) => _contents[index],
            childCount: _contents.length
          ),
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
            expandedHeight: 300,
            iconTheme: IconThemeData
            (
              color: Colors.black
            ),
            flexibleSpace: FlexibleSpaceBar
            (
              titlePadding: EdgeInsets.only(top: 200, left: 80, right: 80),
              centerTitle: true,
              title: Text
              (
                "토지 상세 정보",
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
                    tag: constNoticeCodeMap[Notice_Code.land].code,
                    child: FadeInImage
                    (
                      fit: BoxFit.cover,
                      placeholder: AssetImage("assets/image/placeholder.jpg"),
                      image: constNoticeCodeMap[Notice_Code.land].image
                    )
                  )
                ]
              )
            ),
          ),
          getContentSection()
        ], 
      ),
    );
  }
}