import 'package:flutter/material.dart';
import 'package:snaplist/snaplist.dart';
import 'package:bunyang/Menu/View/MenuView.dart';
import 'package:bunyang/Data/Address.dart';

class SnapMenu extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    final Size cardSize = Size(300, 500);
    var contextSize = MediaQuery.of(context).size;

    return Container
    (
      color : Colors.white,
      child: SnapList
      (
        alignment: Alignment(0.0, 0.1),
        count: constNoticeCodeMap.length,
        padding: EdgeInsets.only(left: (contextSize.width - cardSize.width) / 2),
        sizeProvider: (index, data) => cardSize,
        separatorProvider: (index, data) => Size(10, 10),
        builder: (context, index, data)
        {
          var materialImage = new Image
          (
            image: constNoticeCodeMap[Notice_Code.values[index]].image,
            fit: BoxFit.fill,
            semanticLabel: getNoticeString(Notice_Code.values[index]),
          );

          return Card
          (

            color: Colors.black26,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: new Column
            (
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>
              [
                new MaterialButton
                (
                  child: materialImage,
                  onPressed: ()
                  {
                    Navigator.push
                    (
                      context, 
                      new MaterialPageRoute
                      (
                        builder: (context) => new Menu
                        (
                          constNoticeCodeMap[Notice_Code.values[index]].code,
                          getNoticeString(Notice_Code.values[index])
                        )
                      )
                    );
                  }
                ),
                new Text
                (
                  getNoticeString(Notice_Code.values[index]),
                  style: TextStyle
                  (
                    color: Colors.black38,
                    fontSize: 50,
                    fontFamily: "TmonTium"
                  ),
                  overflow: TextOverflow.fade,
                ),
              ]
            ),
          );
        },
      )
    );
  }
}