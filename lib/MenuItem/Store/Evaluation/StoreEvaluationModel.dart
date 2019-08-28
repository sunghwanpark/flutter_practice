import 'package:bunyang/MenuItem/MenuItemModel.dart';

class StoreEvaluationModel extends MenuItemModel
{
  StoreEvaluationModel() : super(detailFormURL: "OCMC_LCC_SIL_SILSNOT_R0013");

  String _supplyDataURL;

  @override
  String defaultDetailFormXml = '''<?xml version="1.0" encoding="UTF-8"?>
    <Root xmlns="http://www.nexacroplatform.com/platform/dataset">
      <Dataset id="dsSch">
        <ColumnInfo>
          <Column id="PAN_ID" type="STRING" size="256"  />
          <Column id="CCR_CNNT_SYS_DS_CD" type="STRING" size="256"  />
          <Column id="PREVIEW" type="STRING" size="256"  />
          <Column id="PAN_GBN" type="STRING" size="256"  />
        </ColumnInfo>
      </Dataset>
    </Root>''';

  String _supplyDataFormXml = '''<?xml version="1.0" encoding="UTF-8"?>
    <Root xmlns="http://www.nexacroplatform.com/platform/dataset">
      <Dataset id="dsSch">
        <ColumnInfo>
          <Column id="PAN_ID" type="STRING" size="256"  />
          <Column id="CCR_CNNT_SYS_DS_CD" type="STRING" size="256"  />
          <Column id="SBD_NM" type="STRING" size="256"  />
        </ColumnInfo>
      </Dataset>
    </Root>''';

  Future<Map<String, List<Map<String, String>>>> fetchSupplyData(Map<String, String> params)
  {
    return fetch(_supplyDataURL, _supplyDataFormXml, params);
  }
}