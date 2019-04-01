import 'dart:ui';

import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/MenuItem/NoticeElementRouteFactory.dart';
import 'package:flutter/material.dart';
import 'package:bunyang/Util/Util.dart';

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
    return Card
    (
      margin: EdgeInsets.only(left: 10, right: 10),
      color: Colors.white.withOpacity(0.5),
      shape: RoundedRectangleBorder
      (
        borderRadius: BorderRadius.circular(20),
        //side: BorderSide(color: Colors.black12)
      ),
      child: Container
      (
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>
          [
            Row
            (
              children: <Widget>
              [
                Icon
                (
                  getIcon(),
                  color: Colors.black,
                  size: 20,
                ),
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
              ]
            ),
            Container
            (
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: InkWell
              (
                child: myText(item.panName, Colors.black),
                onTap: ()
                {
                  Navigator.push
                  (
                    context,
                    MaterialPageRoute
                    (
                      builder: (context) => NoticeElementRouteFactory.buildElement(item)
                    )
                  );
                }
              ),
            )
          ],
        )
      )
    );
  }
}