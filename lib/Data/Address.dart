enum Notice_Code
{
  land,
  installment_house,
  lease_house,
  house_welfare,
  shopping_district,
  public_installment_house
}

final constNoticeCodeMap = const 
{
  Notice_Code.land : "01",
  Notice_Code.installment_house : "05",
  Notice_Code.lease_house : "06",
  Notice_Code.house_welfare : "13",
  Notice_Code.shopping_district : "22",
  Notice_Code.public_installment_house : "39"
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