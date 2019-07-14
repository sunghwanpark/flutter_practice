import 'package:flutter/material.dart';

enum Notice_Code
{
  land,                       // 토지
  installment_house,          // 분양주택
  honeymoon_lease,    // 신혼희망타운
  lease_house,                // 임대주택
  lease,                      // 매입임대 전세임대
  shopping_district,          // 상가
}

enum MenuItemType
{
  land,                       // 토지매각공고상세내역
  installment_house,          // 분양주택분양공고상세내역
  installment_change_sale,    // 분양전환일반매각공고상세내역
  lease_house_installment,    // 임대주택 공공임대
  honeymoon_lease,            // 신혼희망타운
  all_lease,                  // 매입/전세 임대
  store_bid,                  // 상가(입찰)
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
  Notice_Code.honeymoon_lease : MainMenuData("39", AssetImage("assets/image/parents.jpg")),
  Notice_Code.lease_house : MainMenuData("06", AssetImage("assets/image/sublease.jpg")),
  Notice_Code.lease : MainMenuData("13", AssetImage("assets/image/family.jpg")),
  Notice_Code.shopping_district : MainMenuData("22", AssetImage("assets/image/store.jpg"))
};

getNoticeType(String typeString)
{
  switch(typeString)
  {
    case "토지":  return Notice_Code.land;
    case "분양주택": return Notice_Code.installment_house;
    case "임대주택": return Notice_Code.lease_house;
    case "주거복지": return Notice_Code.lease;
    case "상가": return Notice_Code.shopping_district;
    case "공공분양(신혼희망)": return Notice_Code.honeymoon_lease;
  }
}

getNoticeString(Notice_Code code)
{
  switch(code)
  {
    case Notice_Code.land:                     return "토지";
    case Notice_Code.installment_house:        return "분양주택";
    case Notice_Code.lease_house:              return "임대주택";
    case Notice_Code.lease:                    return "매입임대/전세임대";
    case Notice_Code.shopping_district:        return "상가";
    case Notice_Code.honeymoon_lease: return "신혼희망타운";
  }
}

getNoticeCodeByUppAisTpCd(String uppAisTpCd)
{
  var result = constNoticeCodeMap.entries.firstWhere((map) => map.value.code == uppAisTpCd);

  return result.key;
}