import 'package:bunyang/Menu/Model/MenuModel.dart';
import 'package:bunyang/MenuItem/HoneymoonTown/HoneymoonTownView.dart';
import 'package:bunyang/MenuItem/IntallmentHouse/InstallmentHouseView.dart';
import 'package:bunyang/MenuItem/Land/LandPageView.dart';
import 'package:bunyang/MenuItem/LeaseHouse/PublicLeaseView.dart';
import 'package:flutter/material.dart';
import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/Util/Util.dart';

import 'IntallmentHouse/IntallmentChangeSale/InstallmentChangeSaleView.dart';

class NoticeElementRouteFactory
{
  static Widget buildElement(MenuData item)
  {
    switch (item.getServiceType())
    {
      case MenuItemType.land:
        return LandPage(item);
      case MenuItemType.installment_house:
        return InstallmentHousePage(item);
      case MenuItemType.installment_change_sale:
        return InstallmentChangeSale(item);
      case MenuItemType.lease_house_installment:
        return PublicLeaseView(item);
      case MenuItemType.honeymoon_lease:
        return HoneymoonTownView(item);
      default:
        return myText('아직 개발중이야~');
    }
  }
}