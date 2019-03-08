import 'package:flutter/material.dart';
import 'package:bunyang/Data/ListItem.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:bunyang/MenuItem/ItemWidgetFactory.dart';

class ListItemWidget extends StatelessWidget 
{
  ListItemWidget(this.item, this.index);

  final int index;
  final ListItem item;
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  Widget build(BuildContext context)
  {
    return Container
    (
      child: Flex
      (
        direction: Axis.vertical,
        children: <Widget>
        [
          Container
          (
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration
            (
              color: Colors.white24,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row
            (
              children: <Widget>
              [
                SizedBox(width: 20),
                Icon
                (
                  Icons.landscape,
                  color: Colors.white,
                ),
                SizedBox(width: 20),
                Text
                (
                  item.detailNoticeCode,
                  textAlign: TextAlign.center,
                  style: TextStyle
                  (
                    color: Colors.white,
                    fontFamily: 'NanumGothic',
                    fontWeight: FontWeight.w700,
                    fontSize: 25
                  ),
                ),
              ]
            ),
          ),
          Container
          (
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: MaterialButton
            (
              child: MyText(item.panName, Colors.white),
              height: 200,
              minWidth: MediaQuery.of(context).size.width,
              onPressed: ()
              {
                Navigator.push
                (
                  context,
                  MaterialPageRoute
                  (
                    builder: (context) => ItemWidgetFactory.buildItemWidget(item)
                  )
                );
              }
            ),
          )
        ]
      ),
    );
  }
}