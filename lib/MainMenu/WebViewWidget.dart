import 'package:flutter/material.dart';
import 'package:flutter_practice/Data/ListItem.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

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
        title: Text(_item.panName),
      ),
    );
  }
}