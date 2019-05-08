import 'package:bunyang/Data/Address.dart';
import 'package:bunyang/Data/URL.dart';
import 'package:bunyang/MenuItem/MenuItemModel.dart';
import 'package:tuple/tuple.dart';
import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;

class InstallmentHouseModel extends MenuItemModel
{
  InstallmentHouseModel() : super("OCMC_LCC_SIL_SILSNOT_L0004");

  Map<String, List<Map<String, String>>> cachedLandInfos;

  generateRequestBody(String panId, String ccrCnntSysDsCd)
  {
  }
}