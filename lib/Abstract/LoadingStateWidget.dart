import 'package:flutter/material.dart';
import 'package:bunyang/Util/Util.dart';

abstract class LoadingStateful extends StatefulWidget
{
  LoadingStateful(this.appBarTitle);
  final String appBarTitle;
}

abstract class LoadingStateWidget<T> extends State<LoadingStateful>
{
  LoadingStateWidget(this.appBarTitle);

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
              title: myText(appBarTitle, Colors.white),
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

  Widget getContentSection();
}