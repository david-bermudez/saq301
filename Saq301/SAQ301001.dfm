�
 TFRMSAQ301001MAIN 0M  TPF0TfrmSAQ301001MainfrmSAQ301001MainLeft Top4Width Height�Caption-   Administración de Actas de Pago V4 Ellipse 8Color	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style Menu	MainMenu1OldCreateOrderOnCreate
FormCreate	OnDestroyFormDestroyPixelsPerInch`
TextHeight TPanelPanel1Left Top WidthHeightrAlignalTop
BevelInner	bvLoweredBorderWidthTabOrder  TLabelLabel1LeftTopWidth2HeightCaption&ContratistaFocusControlEdtSupplierCode  TLabelLabel2LeftTop%Width(HeightCaption	C&ontratoFocusControlEdtContractCode  TLabelLabel3LeftTop>WidthAHeightCaption&Acta de PagoFocusControlEdtActPaidNo  TLabelLabel4LeftTopWWidth!HeightCaption&EstadoFocusControl	CmbStatus  TSpeedButtonBtnSuppliersLeft� Top	WidthHeightHintSeleccionar Contratista
Glyph.Data
z  v  BMv      v   (                                        �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ��� 333333D3333333w33333344C3333377s33333CDC33333sws333344D3333377w333  CDC333��sws33 3?�D333�36gw330�33�338c33f�330333?3383336�333333033�33338333333033�3333833�333033�f333833�333033�f3338330��33338ff33�330��38338�f36�333 33 3333�33�33333  333333��3333	NumGlyphsParentShowHintShowHint	OnClickBtnSuppliersClick  TEditEdtSupplierCodeLeftXTopWidthyHeightTabOrder   TEditEdtContractCodeLeftXTop!WidthyHeightTabOrder  TEditEdtActPaidNoLeftXTop:WidthyHeightTabOrder  	TComboBox	CmbStatusLeftWTopSWidth{Height
ItemHeightTabOrder  TButton	BtnSearchLeft� TopWidthiHeightCaptionBuscarTabOrderOnClickBtnSearchClick  TButtonBtnNewSearchLeft� Top?WidthiHeightCaptionNueva BusquedaTabOrderOnClickBtnNewSearchClick  TAnimateanmFindActsLeft`Top$Width0Height-Active	CommonAVIaviFindComputer	StopFrame  	TCheckBoxCkBxTodaJerarquiaLeft� TopWidth� HeightCaption    Todas las actas en la jerarquíaTabOrder   TDBGridGrdActsPaidLeft ToprWidthHeight0AlignalClient
DataSourcedmActs.StblSearchOptionsdgTitlesdgIndicatordgColumnResize
dgColLines
dgRowLinesdgTabsdgRowSelectdgAlwaysShowSelectiondgConfirmDeletedgCancelOnExit ReadOnly	TabOrderTitleFont.CharsetDEFAULT_CHARSETTitleFont.ColorclWindowTextTitleFont.Height�TitleFont.NameMS Sans SerifTitleFont.Style 
OnDblClickGrdActsPaidDblClickColumnsExpanded	FieldNameCONTRACT_NOTitle.CaptionContratoWidthGVisible	 Expanded	FieldName
PORTION_NOTitle.Caption   PorciónWidth-Visible	 Expanded	FieldNameACT_PAID_NOTitle.CaptionActa de PagoWidthVVisible	 Expanded	FieldNameSTATUSTitle.CaptionEstadoWidthBVisible	 Expanded	FieldNameSUPPLIER_NAMETitle.CaptionContratistaWidth� Visible	 Expanded	FieldNameUSER_IDTitle.CaptionUsuario ApruebaWidthdVisible	 Expanded	FieldNamePOSITION_IDTitle.CaptionPosicionWidthdVisible	 Expanded	FieldName
EXT_INV_NOTitle.Caption
Factura E8Width� Visible	    
TStatusBar	StbStatusLeft Top�WidthHeightPanelsText0 Registros encontrados Width�  Width�  StylepsOwnerDrawWidth2  SimplePanelOnDrawPanelStbStatusDrawPanel  	TMainMenu	MainMenu1Left�Top 	TMenuItemMTDocumentsCaptionActas de PagoHelpContext4OnClickMTDocumentsClick 	TMenuItemMDNewCaptionNuevaHelpContext>ShortCutN@OnClick
MDNewClick  	TMenuItemMDOpenCaptionAbrirHelpContextHShortCutO@OnClickGrdActsPaidDblClick  	TMenuItem	MDPutNullCaptionAnularHelpContextRShortCutA@OnClickMDPutNullClick  	TMenuItemMDSendCaptionEnviarHelpContext\ShortCutE@OnClickMDSendClick  	TMenuItem	MDApproveCaptionAprobarHelpContextfShortCutR@OnClickMDApproveClick  	TMenuItemMDUnApproveCaption
DesaprobarHelpContext�ShortCutB@OnClickMDUnApproveClick  	TMenuItemMDPrintCaptionImprimirHelpContextpShortCutP@OnClickMDPrintClick  	TMenuItemN1Caption-  	TMenuItemMDExitCaptionSalirHelpContextzShortCutS@OnClickMDExitClick   	TMenuItem	MTReportsCaptionReportesHelpContext�OnClickMTReportsClick 	TMenuItemMRRep01CaptionTotales por ContratistaHelpContext�ShortCutT@OnClickMRRep01Click  	TMenuItemMRRep02CaptionTotales por ContratoHelpContext�ShortCutL@OnClickMRRep02Click  	TMenuItemMRRep03CaptionResumen de ContratosHelpContext�ShortCutU@OnClickMRRep03Click  	TMenuItemMRRep04CaptionActas por contratoHelpContext�ShortCutJ@OnClickMRRep04Click  	TMenuItemN3Caption-  	TMenuItemMRAPSummaryCaptionActa de Pago ResumidaHelpContext�ShortCutM@OnClickMRAPSummaryClick   	TMenuItemMTHelpCaptionAyudaHelpContext� 	TMenuItemMHMIMSCaptionMIMSHelpContext	OnClickMHMIMSClick  	TMenuItemMHApplicationsCaptionAplicacionesHelpContext	OnClickMHApplicationsClick  	TMenuItem
MHActsPaidCaptionActas de PagoHelpContext	OnClickMHActsPaidClick  	TMenuItemN2Caption-  	TMenuItemMHAboutCaption	Acerca deHelpContext$	OnClickMHAboutClick     