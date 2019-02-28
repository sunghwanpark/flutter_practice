import 'package:flutter/material.dart';
import 'package:flutter_practice/Data/ListItem.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_practice/MainMenu/WebViewWidget.dart';

class ListItemWidget extends StatelessWidget 
{
  ListItemWidget(this.item, this.index);

  final int index;
  final ListItem item;
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  Widget build(BuildContext context)
  {
    return new StickyHeader
    (
      header: new Container
      (
        height: 50,
        color: Colors.blueGrey[700],
        padding: new EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        child: new Text
        (
          item.typeString,
          style : const TextStyle(color: Colors.white),
        ),
      ),
      content: new MaterialButton
      (
        height: 200,
        minWidth: MediaQuery.of(context).size.width,
        color: Colors.blue,
        child: new Text
        (
          item.panName,
          style: const TextStyle(color: Colors.white),
        ),
        onPressed: ()
        {
          Navigator.push
          (
            context,
            new MaterialPageRoute
            (
              builder: (context) => new WebViewWidget(item),
            )
          );
        }
      ),
    );
  }
}