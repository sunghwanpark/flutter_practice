abstract class MenuItemModel
{
  MenuItemModel(this.detailForm);

  final String detailForm;
  final String detailFormUrl = "/lhCmcNoSessionAdapter.lh";
  final String defaultDetailFormXml =
    '''<?xml version="1.0" encoding="UTF-8"?>
      <Root xmlns="http://www.nexacroplatform.com/platform/dataset">
	    <Dataset id="dsSch">
		    <ColumnInfo>
			  <Column id="PAN_ID" type="STRING" size="256"  />
			  <Column id="CCR_CNNT_SYS_DS_CD" type="STRING" size="256"  />
			  <Column id="PG_SZ" type="STRING" size="256"  />
			  <Column id="PAGE" type="STRING" size="256"  />
			  <Column id="PAN_LOLD_TYPE" type="STRING" size="256"  />
			  <Column id="PREVIEW" type="STRING" size="256"  />
			  <Column id="PAN_KD_CD" type="STRING" size="256"  />
			  <Column id="OTXT_PAN_ID" type="STRING" size="256"  />
			  <Column id="TRET_PAN_ID" type="STRING" size="256"  />
			  <Column id="TMP_PAN_SS" type="STRING" size="256"  />
		  </ColumnInfo>
    </Dataset>
  </Root>'''; 
}