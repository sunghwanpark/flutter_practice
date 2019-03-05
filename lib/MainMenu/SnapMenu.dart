import 'package:flutter/material.dart';
import 'package:snaplist/snaplist.dart';
import 'package:bunyang/MainMenu/MainMenu.dart';
import 'package:bunyang/Data/Address.dart';

class SnapMenu extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    final Size cardSize = Size(300, 400);
    return SnapList
    (
      count: constNoticeCodeMap.length,

      padding: EdgeInsets.only
      (
        left: (MediaQuery.of(context).size.width - cardSize.width) / 2
      ),
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

        return ClipRRect
        (
          borderRadius: new BorderRadius.circular(16),
          child: new MaterialButton
          (
            child: materialImage,
            onPressed: ()
            {
              Navigator.push
              (
                context, 
                new MaterialPageRoute
                (
                  builder: (context) => new MainMenu(constNoticeCodeMap[Notice_Code.values[index]].code)
                )
              );
            }
          ),
        );
      },
    );
  }
}