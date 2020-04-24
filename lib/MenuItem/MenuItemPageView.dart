import 'dart:async';

import 'package:async/async.dart';
import 'package:bunyang/Abstract/TabStateView.dart';
import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/MenuItem/MenuItemPresenter.dart';
import 'package:bunyang/Notification/NotificationManager.dart';
import 'package:bunyang/Util/Util.dart';
import 'package:flutter/material.dart';

enum NotifyState
{
  None,
  Enable,
  Disable
}

class NotifyInfo
{
  NotifyInfo(this.dateTime, this.notifyElementName);

  final DateTime dateTime;
  final String notifyElementName;
  bool bNotifyOn = false;
}

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

    _notificationId = this.data.panIdHashCode;
  }

  final MenuData data;
  Notice_Code type;
  String panId;
  String ccrCnntSysDsCd;
  String appBarTitle;
  int _notificationId;
  NotifyState _currentNotifyState = NotifyState.None;
  MenuItemPresenter presenter;

  final AsyncMemoizer _memoizer = AsyncMemoizer();

  @protected
  Set<NotifyInfo> notifyInfos = Set<NotifyInfo>();

  bool _isBeforeNotifyDateTime()
  {
    return notifyInfos.where((notifyInfo)
    {
      return DateTime.now().isBefore(notifyInfo.dateTime);
    }).isEmpty;
  }

  Future<bool> _isHasSubscribeNotify() async
  {
    if(notifyInfos.isEmpty)
    {
      return false;
    }

    var ids = notifyInfos.map((notifyInfo)
    {
      return _notificationId + notifyInfo.dateTime.millisecond;
    });

    return _memoizer.runOnce(() async
    {
      bool isHasSubscribeNotify = false;
      for(int i = 0; i < ids.length; i++)
      {
        int id = ids.elementAt(i);
        bool hasSubscribe = await NotificationManager().isSubscribeNotification(id);
        notifyInfos.elementAt(i).bNotifyOn = hasSubscribe;

        isHasSubscribeNotify |= hasSubscribe;
      }
      return isHasSubscribeNotify;
    });
  }

  void _cancelNotify()
  {
    if(notifyInfos.isEmpty)
    {
      return;
    }

    notifyInfos.forEach((notifyInfo)
    {
      int id = _notificationId + notifyInfo.dateTime.millisecond;
      NotificationManager().cancelSubscribeNotification(id);
    });
  }

  Widget _notifyIconButton()
  {
    assert(_currentNotifyState != NotifyState.None);

    if(notifyInfos.isEmpty)
    {
      if(_currentNotifyState == NotifyState.Enable)
      {
        _cancelNotify();
      }

      return SizedBox();
    }

    if(_isBeforeNotifyDateTime())
    {
      if(_currentNotifyState == NotifyState.Enable)
      {
        _cancelNotify();
      }

      return SizedBox();
    }

    IconData iconData = _currentNotifyState == NotifyState.Enable ? 
      Icons.notifications_active : Icons.notifications_none;

    return IconButton
    (
      icon: Icon(iconData),
      onPressed: onPressedNotification
    );
  }

  Widget _notifyIconWidget()
  {
    if(loadingState == LoadingState.DONE)
    {
      if(_currentNotifyState == NotifyState.None)
      {
        return FutureBuilder<bool>
        (
          initialData: false,
          future: _isHasSubscribeNotify(),
          builder: (context, snapshot)
          {
            if(snapshot.hasData)
            {
              _currentNotifyState = snapshot.data ? NotifyState.Enable : NotifyState.Disable;
            }
            return _notifyIconButton();
          }
        );
      }
      else
      {
        return _notifyIconButton();
      }
    }
    else
    {
      return SizedBox();
    }
  }

  void onResponseSuccessPanInfo(Map<String, String> panInfo);

  void onPressedNotification()
  {
    showDialog
    (
      context: this.context,
      barrierDismissible: false,
      builder: (BuildContext _context)
      {
        return AlertDialog
        (
          title: Center(child: Text('알림 등록', textAlign: TextAlign.left, style: TextStyle(color: Colors.deepPurpleAccent[800], fontWeight: FontWeight.w600, fontSize: 30, fontFamily: 'TmonTium'))),
          shape: RoundedRectangleBorder
          (
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(style: BorderStyle.solid, color: Colors.black.withOpacity(0.2))
          ),
          backgroundColor: Colors.white,
          elevation: 0.2,
          contentPadding: EdgeInsets.all(0),
          content: Container
          (
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height,
            child: ListView.builder
            (
              itemCount: notifyInfos.length,
              itemBuilder: (_context, index)
              {
                return Radio<bool>
                (
                  value: notifyInfos.elementAt(index).bNotifyOn,
                  groupValue: null,
                  onChanged: (bool value)
                  {
                    notifyInfos.elementAt(index).bNotifyOn = value;
                  }
                );
              }
            )
          ),
          actions: <Widget>
          [
            FlatButton
            (
              child: myText('닫기'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      }
    );
  }

  void addNotifyDateTime(DateTime dateTime, String dataName)
  {
    notifyInfos.add(NotifyInfo(dateTime, dataName));
  }

  @override
  Widget notifyIcon()
  {
    return Align
    (
      alignment: Alignment.centerRight,
      child : _notifyIconWidget()
    );
  }
}