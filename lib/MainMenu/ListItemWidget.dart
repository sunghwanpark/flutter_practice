import 'package:flutter/material.dart';
import 'package:bunyang/Data/ListItem.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:bunyang/MainMenu/WebViewWidget.dart';
import 'package:bunyang/Util/Util.dart';

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
        child: MyText(item.typeString),
      ),
      content: new MaterialButton
      (
        height: 200,
        minWidth: MediaQuery.of(context).size.width,
        color: Colors.blue,
        child: MyText(item.panName),
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