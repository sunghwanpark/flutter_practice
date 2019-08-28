import 'package:bunyang/MenuItem/MenuItemModel.dart';

class StoreDrawModel extends MenuItemModel
{
  StoreDrawModel() : super(detailFormURL: 'OCMC_LCC_SIL_SILSNOT_R0011');

  final String _attachmentURL = 'OCMC_LCC_SIL_SILSNOT_L0005';
  final String _supplyDetailURL = 'OCMC_LCC_SIL_SILSNOT_R0012';

  @override
  String defaultDetailFormXml ='''<?xml version="1.0" encoding="UTF-8"?>
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

  String _attachmentFormXml = '''<?xml version="1.0" encoding="UTF-8"?>
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
  
  String _supplyDetailFormXml = '''<?xml version="1.0" encoding="UTF-8"?>
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

  Future<Map<String, List<Map<String, String>>>> fetchAttachment(Map<String, String> params)
  {
    return fetch(_attachmentURL, _attachmentFormXml, params);
  }

  Future<Map<String, List<Map<String, String>>>> fetchDetail(Map<String, String> params)
  {
    return fetch(_supplyDetailURL, _supplyDetailFormXml, params);
  }
}