import 'package:flutter/material.dart';

enum Notice_Code
{
  land,                       // 토지
  installment_house,          // 분양주택
  lease_house,                // 임대주택
  house_welfare,              // 주거복지
  shopping_district,          // 상가
  public_installment_house    // 신혼희망타운
}

enum MenuItemType
{
  land,                       // 토지매각공고상세내역
  installment_house,          // 분양주택분양공고상세내역
  installment_change_sale,    // 분양전환일반매각공고상세내역
}

class MainMenuData
{
  const MainMenuData(this.code, this.image);

  final String code;
  final AssetImage image;
}

final constNoticeCodeMap = const 
{
  Notice_Code.land : MainMenuData("01", AssetImage("assets/image/land.jpg")),
  Notice_Code.installment_house : MainMenuData("05", AssetImage("assets/image/house.jpg")),
  Notice_Code.lease_house : MainMenuData("06", AssetImage("assets/image/sublease.jpg")),
  Notice_Code.house_welfare : MainMenuData("13", AssetImage("assets/image/family.jpg")),
  Notice_Code.shopping_district : MainMenuData("22", AssetImage("assets/image/store.jpg")),
  Notice_Code.public_installment_house : MainMenuData("39", AssetImage("assets/image/parents.jpg"))
};

getNoticeType(String typeString)
{
  switch(typeString)
  {
    case "토지":  return Notice_Code.land;
    case "분양주택": return Notice_Code.installment_house;
    case "임대주택": return Notice_Code.lease_house;
    case "주거복지": return Notice_Code.house_welfare;
    case "상가": return Notice_Code.shopping_district;
    case "공공분양(신혼희망)": return Notice_Code.public_installment_house;
  }
}

getNoticeString(Notice_Code code)
{
  switch(code)
  {
    case Notice_Code.land:                     return "토지";
    case Notice_Code.installment_house:        return "분양주택";
    case Notice_Code.lease_house:              return "임대주택";
    case Notice_Code.house_welfare:            return "주거복지";
    case Notice_Code.shopping_district:        return "상가";
    case Notice_Code.public_installment_house: return "공공분양(신혼희망)";
  }
}