import 'package:bunyang/Abstract/TabStateView.dart';
import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/MenuItem/MenuItemPresenter.dart';
import 'package:bunyang/Notification/NotificationManager.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';

abstract class MenuItemPage extends TabStatefull
{
  MenuItemPage(this.data) : super(noticeCode: data.type, appBarTitle: data.getPanName());

  final MenuData data;

  @override
  State<StatefulWidget> createState() {
    return null;
  }
}

abstract class MenuItemPageView<T extends MenuItemPage> extends TabStateView<T>
{
  MenuItemPageView(this.data)
  {
    type = this.data.type;
    panId = this.data.getParameter("PAN_ID");
    ccrCnntSysDsCd = this.data.getParameter("CCR_CNNT_SYS_DS_CD");
    appBarTitle = this.data.getPanName();
  }

  final MenuData data;
  Notice_Code type;
  String panId;
  String ccrCnntSysDsCd;
  String appBarTitle;

  MenuItemPresenter presenter;

  void onResponseSuccessPanInfo(Map<String, String> panInfo);

  void onPressedNotification();

  @override
  Widget notifyIcon()
  {
    return Align
    (
      alignment: Alignment.centerRight,
      child : TweenAnimationBuilder<double>
      (
        tween: Tween(begin: 0, end: 100), 
        duration: Duration(milliseconds: 2000), 
        builder: (BuildContext context, double value, Widget child)
        {
          return IconButton
          (
            icon: child,
            color: Colors.black,
            onPressed: onPressedNotification
          );
        },
        child: loadingState != LoadingState.DONE ? 
        Icon(Icons.notifications_none) :
        FutureBuilder<bool>
        (
          future: NotificationManager().isSubscribeNotification(int.parse(panId)),
          builder: (context, snapshot)
          {
            IconData iconData = Icons.notifications_none;
            if(snapshot.hasData)
            {
              iconData = snapshot.data ? Icons.notifications_active : Icons.notifications_none;
            }
            return Icon(iconData);
          }
        )
      )
    );
  }
}