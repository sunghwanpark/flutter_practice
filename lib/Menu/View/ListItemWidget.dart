import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/MenuItem/NoticeElementRouteFactory.dart';
import 'package:flutter/material.dart';

class ListItemWidget extends StatelessWidget 
{
  ListItemWidget(this.item, this.index);

  final int index;
  final MenuData item;

  IconData getIcon()
  {
    switch (item.type)
    {
      case Notice_Code.land:
        return Icons.landscape;
      case Notice_Code.installment_house:
        return Icons.grid_on;
      case Notice_Code.lease_house:
        return Icons.home;
      case Notice_Code.house_welfare:
        return Icons.favorite;
      case Notice_Code.shopping_district:
        return Icons.shopping_cart;
      case Notice_Code.public_installment_house:
        return Icons.group;
      default:
        return Icons.perm_device_information;
    }
  }

  Widget build(BuildContext context)
  {
    return Row
    (
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>
      [
        Icon
        (
          getIcon(),
          color: Colors.white.withOpacity(0.5),
          size: 80,
        ),
        Card
        (
          elevation: 2,
          margin: EdgeInsets.only(top: 10, bottom: 10, left: 0, right: 0),
          color: Colors.white.withOpacity(0.5),
          shape: RoundedRectangleBorder
          (
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container
          (
            child: Column
            (
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>
              [
                Text
                (
                  item.detailNoticeCode,
                  textAlign: TextAlign.center,
                  style: TextStyle
                  (
                    color: Colors.black,
                    fontFamily: 'NanumGothic',
                    fontWeight: FontWeight.w700,
                    fontSize: 25
                  ),
                ),
                Container
                (
                  padding: EdgeInsets.all(10),
                  height: 150,
                  width: MediaQuery.of(context).size.width - 150,
                  child: InkWell
                  (
                    child: AutoSizeText
                    (
                      item.panName,
                      maxLines: 4,
                      style: TextStyle
                      (
                        color: Colors.black,
                        fontFamily: "TmonTium",
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                      )
                    ),
                    onTap: ()
                    {
                      Navigator.push
                      (
                        context,
                        MaterialPageRoute
                        (
                          builder: (context) => 
                            NoticeElementRouteFactory.buildElement(item)
                        )
                      );
                    }
                  ),
                )
              ],
            )
          )
        )
      ]
    );
  }
}