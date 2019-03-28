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
        axis: Axis.vertical,
        alignment: Alignment(0.0, 0.1),
        count: constNoticeCodeMap.length,
        padding: EdgeInsets.only(top: (contextSize.height - cardSize.height) / 2),
        sizeProvider: (index, data) => cardSize,
        separatorProvider: (index, data) => Size(10, 10),
        builder: (context, index, data)
        {
          var materialImage = new Hero
          (
            child: FadeInImage
            ( 
              placeholder: AssetImage("assets/image/placeholder.jpg"),
              image: constNoticeCodeMap[Notice_Code.values[index]].image,
              fit: BoxFit.fitHeight,
              width: 300,
              height: 420,
            ),
            tag: constNoticeCodeMap[Notice_Code.values[index]].code
          );

          return Card
          (
            shape: RoundedRectangleBorder
            (
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.black12)
            ),
            child: Column
            (
              children : <Widget>
              [
                InkWell
                (
                  child: ClipRRect
                  (
                    borderRadius: BorderRadius.circular(10),
                    child: materialImage,
                  ),
                  onTap: ()
                  {
                    Navigator.of(context).push
                    (
                      PageRouteBuilder
                      (
                        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                          FadeTransition(opacity: animation, child: child),
                        pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation)
                        {
                          return Menu(getNoticeString(Notice_Code.values[index]), constNoticeCodeMap[Notice_Code.values[index]]);
                        }
                      )
                    );
                  }
                ),
                SizedBox
                (
                  height: 10
                ),
                Text
                (
                  getNoticeString(Notice_Code.values[index]),
                  style: TextStyle
                  (
                    color: Colors.black,
                    fontSize: 30,
                    fontFamily: "TmonTium",
                    fontWeight: FontWeight.w500
                  ),
                  overflow: TextOverflow.clip,
                ),
              ]
            )
          );
        }
      )
    );
  }
}