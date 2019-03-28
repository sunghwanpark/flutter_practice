import 'package:flutter/material.dart';
import 'package:bunyang/Data/ListItem.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:bunyang/Util/Util.dart';

class WebViewWidget extends StatelessWidget 
{
  WebViewWidget(this._item);

  final ListItem _item;

  Widget build(BuildContext context)
  {
    return new WebviewScaffold
    (
      url: _item.detailURL,
      appBar: new AppBar
      (
        title: myText(_item.panName),
      ),
      withJavascript: true,
    );
  }
}