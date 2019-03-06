import 'package:flutter/material.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:bunyang/Data/CachingData.dart';

abstract class LoadingStateful extends StatefulWidget
{
  LoadingStateful(this.appBarTitle);
  final String appBarTitle;
}

abstract class LoadingStateWidget<T> extends State<LoadingStateful>
{
  LoadingStateWidget(this.appBarTitle);

  final CachingData cachingData = CachingData.instance();
  final String appBarTitle;

  LoadingState loadingState = LoadingState.LOADING;

  void loadpage();

  @override
  void initState() {
    super.initState();

    loadpage();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      backgroundColor: Colors.white,
      appBar: new AppBar(title: MyText(appBarTitle)),
      body: Center
      (
        child: getContentSection(),
      ),
    );
  }

  Widget getContentSection();
}