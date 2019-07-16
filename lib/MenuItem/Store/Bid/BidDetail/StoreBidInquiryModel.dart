import 'package:bunyang/MenuItem/MenuItemModel.dart';

class StoreBidInquiryModel extends MenuItemModel
{
  StoreBidInquiryModel() : super(detailFormURL : "OCMC_LCC_SIL_AIS_R0003");

  @override
  String defaultDetailFormXml = '''<?xml version="1.0" encoding="UTF-8"?>
    <Root xmlns="http://www.nexacroplatform.com/platform/dataset">
	    <Dataset id="dsSch">
		    <ColumnInfo>
			    <Column id="CCR_CNNT_SYS_DS_CD" type="STRING" size="256"  />
          <Column id="PAN_ID" type="STRING" size="256"  />
          <Column id="AIS_INF_SN" type="STRING" size="256"  />
          <Column id="DNG_SN" type="STRING" size="256"  />
          <Column id="SBD_NO" type="STRING" size="256"  />
          <Column id="SSDH_SL_ADM_NO" type="STRING" size="256"  />
          <Column id="SL_CST_NO" type="STRING" size="256"  />
          <Column id="PR1_SH1_RST_YN" type="STRING" size="256"  />
          <Column id="JNU" type="STRING" size="256"  />
          <Column id="TOY" type="STRING" size="256"  />
          <Column id="PREVIEW" type="STRING" size="256"  />
          <Column id="HC_BLK_CD" type="STRING" size="256"  />
          <Column id="BZDT_CD" type="STRING" size="256"  />
		    </ColumnInfo>''';
  
  Future<Map<String, List<Map<String, String>>>> fetchData(Map<String, String> params) async
  {
    return fetch(detailFormURL, defaultDetailFormXml, params);
  }
}