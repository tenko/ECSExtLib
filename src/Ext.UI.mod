MODULE UI IN Ext;

IMPORT SYSTEM;

CONST
    ForEachContinue* 		        = 0;
    ForEachStop*                    = 1;
    AlignFill*                      = 0;
	AlignStart*                     = 1;
	AlignCenter*                    = 2;
	AlignEnd*                       = 3;
    AtLeading*                      = 0;
	AtTop*                          = 1;
	AtTrailing*                     = 2;
	AtBottom*                       = 3;
    WindowResizeEdgeLeft*           = 0;
	WindowResizeEdgeTop*            = 1;
	WindowResizeEdgeRight*          = 2;
	WindowResizeEdgeBottom*         = 3;
	WindowResizeEdgeTopLeft*        = 4;
	WindowResizeEdgeTopRight*       = 5;
	WindowResizeEdgeBottomLeft*     = 6;
	WindowResizeEdgeBottomRight*    = 7;
    DrawBrushTypeSolid*             = 0;
	DrawBrushTypeLinearGradient*    = 1;
	DrawBrushTypeRadialGradient*    = 2;
	DrawBrushTypeImage*             = 3;
    DrawLineCapFlat*                = 0;
	DrawLineCapRound*               = 1;
	DrawLineCapSquare*              = 2;
    DrawLineJoinMiter*              = 0;
	DrawLineJoinRound*              = 1;
	DrawLineJoinBevel*              = 2;
    DrawFillModeWinding*            = 0;
	DrawFillModeAlternate*          = 1;
    TableValueTypeString*           = 0;
	TableValueTypeImage*            = 1;
	TableValueTypeInt*              = 2;
	TableValueTypeColor*            = 3;
    TableModelColumnNeverEditable*  = -1;
    TableModelColumnAlwaysEditable* = -2;
    TableSelectionModeNone*         = 0;
    TableSelectionModeZeroOrOne*    = 1;
    TableSelectionModeOne*          = 3;
    TableSelectionModeZeroOrMany*   = 4;
    SortIndicatorNone*              = 0;
	SortIndicatorAscending*         = 1;
	SortIndicatorDescending*        = 2;

TYPE
    ADDRESS = SYSTEM.ADDRESS;
    SIZE_T = LENGTH;
    InitOptions* = RECORD-
        size* : SIZE_T;
    END;

    TM* = RECORD-
        tm_sec*    : INTEGER;
        tm_min*    : INTEGER;
        tm_hour*   : INTEGER;
        tm_mday*   : INTEGER;
        tm_mon*    : INTEGER;
        tm_year*   : INTEGER;
        tm_wday*   : INTEGER;
        tm_yday*   : INTEGER;
        tm_isdst*  : INTEGER;
    END;

    TableSelectionPtr* = POINTER TO TableSelection;
    TableSelection* = RECORD-
        NumRows*  : INTEGER;
        Rows*     : ADDRESS;
    END;

    TableTextColumnOptionalParams* = RECORD-
        ColorModelColumn*     : INTEGER;
    END;

    TableParams* = RECORD-
        Model*                              : ADDRESS;
        RowBackgroundColorModelColumn*      : INTEGER;
    END;

    Callback* = PROCEDURE;
    CallbackInteger* = PROCEDURE(): INTEGER;
    App* = RECORD opts: InitOptions END;
    Control* = RECORD ptr: ADDRESS END;
    Window* = RECORD (Control) END;
    Button* = RECORD (Control) END;
    Box* = RECORD (Control) END;
    Checkbox* = RECORD (Control) END;
    Entry* = RECORD (Control) END;
    Label* = RECORD (Control) END;
    Tab* = RECORD (Control) END;
    Group* = RECORD (Control) END;
    Spinbox* = RECORD (Control) END;
    Slider* = RECORD (Control) END;
    ProgressBar* = RECORD (Control) END;
    Separator* = RECORD (Control) END;
    Combobox* = RECORD (Control) END;
    EditableCombobox* = RECORD (Control) END;
    RadioButtons* = RECORD (Control) END;
    DateTimePicker* = RECORD (Control) END;
    MultilineEntry* = RECORD (Control) END;
    MenuItem* = RECORD (Control) END;
    Menu* = RECORD (Control) END;
    ColorButton* = RECORD (Control) END;
    Form* = RECORD (Control) END;
    Grid* = RECORD (Control) END;
    
(* Callback shim code *)
VAR ^ winui_onCallback ["_winui_onCallback"]: SYSTEM.BYTE;

(* Function types *)
PROCEDURE ^ uiInit ["uiInit"] (opts: ADDRESS): ADDRESS;
PROCEDURE ^ uiUninit ["uiUninit"] (): ADDRESS;
PROCEDURE ^ uiFreeInitError ["uiFreeInitError"] (err: ADDRESS);
PROCEDURE ^ uiMain ["uiMain"] ();
PROCEDURE ^ uiQuit ["uiQuit"] ();
PROCEDURE ^ uiFreeText ["uiFreeText"] (text: ADDRESS);

(* Control *)
PROCEDURE ^ uiControlDestroy ["uiControlDestroy"] (c: ADDRESS);
PROCEDURE ^ uiControlToplevel ["uiControlToplevel"] (c: ADDRESS): INTEGER;
PROCEDURE ^ uiControlVisible ["uiControlVisible"] (c: ADDRESS): INTEGER;
PROCEDURE ^ uiControlShow ["uiControlShow"] (c: ADDRESS);
PROCEDURE ^ uiControlHide ["uiControlHide"] (c: ADDRESS);
PROCEDURE ^ uiControlEnabled ["uiControlEnabled"] (c: ADDRESS): INTEGER;
PROCEDURE ^ uiControlEnable ["uiControlEnable"] (c: ADDRESS);
PROCEDURE ^ uiControlDisable ["uiControlDisable"] (c: ADDRESS);

(* Window *)
PROCEDURE ^ uiNewWindow ["uiNewWindow"] (title: ADDRESS; width, height, hasMenubar: INTEGER): ADDRESS;
PROCEDURE ^ uiWindowTitle ["uiWindowTitle"] (w: ADDRESS): ADDRESS;
PROCEDURE ^ uiWindowSetTitle ["uiWindowTitle"] (w: ADDRESS; title: ADDRESS);
PROCEDURE ^ uiWindowPosition ["uiWindowPosition"] (w: ADDRESS; VAR x, y : INTEGER);
PROCEDURE ^ uiWindowSetPosition ["uiWindowSetPosition"] (w: ADDRESS; x, y : INTEGER);
PROCEDURE ^ uiWindowOnPositionChanged ["uiWindowOnPositionChanged"] (w: ADDRESS; proc: ADDRESS; data: Callback);
PROCEDURE ^ uiWindowContentSize ["uiWindowContentSize"] (w: ADDRESS; VAR width, height : INTEGER);
PROCEDURE ^ uiWindowSetContentSize ["uiWindowSetContentSize"] (w: ADDRESS; width, height : INTEGER);
PROCEDURE ^ uiWindowFullscreen ["uiWindowFullscreen"] (w: ADDRESS): INTEGER;
PROCEDURE ^ uiWindowSetFullscreen ["uiWindowSetFullscreen"] (w: ADDRESS; fullscreen: INTEGER);
PROCEDURE ^ uiWindowOnContentSizeChanged ["uiWindowOnContentSizeChanged"] (w: ADDRESS; proc: ADDRESS; data: Callback);
PROCEDURE ^ uiWindowOnClosing ["uiWindowOnClosing"] (w: ADDRESS; proc: ADDRESS; data: CallbackInteger);
PROCEDURE ^ uiWindowOnFocusChanged ["uiWindowOnFocusChanged"] (w: ADDRESS; proc: ADDRESS; data: Callback);
PROCEDURE ^ uiWindowFocused ["uiWindowFocused"] (w: ADDRESS): INTEGER;
PROCEDURE ^ uiWindowBorderless ["uiWindowBorderless"] (w: ADDRESS): INTEGER;
PROCEDURE ^ uiWindowSetBorderless ["uiWindowSetBorderless"] (w: ADDRESS; borderless: INTEGER);
PROCEDURE ^ uiWindowSetChild ["uiWindowSetChild"] (w: ADDRESS; child: ADDRESS);
PROCEDURE ^ uiWindowMargined ["uiWindowMargined"] (w: ADDRESS): INTEGER;
PROCEDURE ^ uiWindowSetMargined ["uiWindowSetMargined"] (w: ADDRESS; margined: INTEGER);
PROCEDURE ^ uiWindowResizeable ["uiWindowResizeable"] (w: ADDRESS): INTEGER;
PROCEDURE ^ uiWindowSetResizeable ["uiWindowSetResizeable"] (w: ADDRESS; resizeable: INTEGER);

(* Button *)
PROCEDURE ^ uiNewButton ["uiNewButton"] (text: ADDRESS): ADDRESS;
PROCEDURE ^ uiButtonText ["uiButtonText"] (b : ADDRESS): ADDRESS;
PROCEDURE ^ uiButtonSetText ["uiButtonSetText"] (b : ADDRESS; title : ADDRESS);
PROCEDURE ^ uiButtonOnClicked ["uiButtonOnClicked"] (w: ADDRESS; callback: ADDRESS; data: Callback);

(* Box *)
PROCEDURE ^ uiNewVerticalBox ["uiNewVerticalBox"] (): ADDRESS;
PROCEDURE ^ uiNewHorizontalBox ["uiNewHorizontalBox"] (): ADDRESS;
PROCEDURE ^ uiBoxAppend ["uiBoxAppend"] (b: ADDRESS; child: ADDRESS; stretchy: INTEGER);
PROCEDURE ^ uiBoxNumChildren ["uiBoxNumChildren"] (b: ADDRESS): INTEGER;
PROCEDURE ^ uiBoxDelete ["uiBoxDelete"] (b: ADDRESS; index: INTEGER);
PROCEDURE ^ uiBoxPadded ["uiBoxPadded"] (b: ADDRESS): INTEGER;
PROCEDURE ^ uiBoxSetPadded ["uiBoxSetPadded"] (b: ADDRESS; padded: INTEGER);

(* Checkbox *)
PROCEDURE ^ uiNewCheckbox ["uiNewCheckbox"] (text: ADDRESS): ADDRESS;
PROCEDURE ^ uiCheckboxText ["uiCheckboxText"] (c : ADDRESS): ADDRESS;
PROCEDURE ^ uiCheckboxSetText ["uiCheckboxSetText"] (c : ADDRESS; title : ADDRESS);
PROCEDURE ^ uiCheckboxOnToggled ["uiCheckboxOnToggled"] (c: ADDRESS; callback: ADDRESS; data: Callback);
PROCEDURE ^ uiCheckboxChecked ["uiCheckboxChecked"] (c: ADDRESS): INTEGER;
PROCEDURE ^ uiCheckboxSetChecked ["uiCheckboxSetChecked"] (c: ADDRESS; checked: INTEGER);

(* Entry *)
PROCEDURE ^ uiNewEntry ["uiNewEntry"] (): ADDRESS;
PROCEDURE ^ uiNewPasswordEntry ["uiNewPasswordEntry"] (): ADDRESS;
PROCEDURE ^ uiNewSearchEntry ["uiNewSearchEntry"] (): ADDRESS;
PROCEDURE ^ uiEntryText ["uiEntryText"] (e : ADDRESS): ADDRESS;
PROCEDURE ^ uiEntrySetText ["uiEntrySetText"] (e : ADDRESS; text : ADDRESS);
PROCEDURE ^ uiEntryOnChanged ["uiEntryOnChanged"] (e: ADDRESS; callback: ADDRESS; data: Callback);
PROCEDURE ^ uiEntryReadOnly ["uiEntryReadOnly"] (e: ADDRESS): INTEGER;
PROCEDURE ^ uiEntrySetReadOnly ["uiEntrySetReadOnly"] (e: ADDRESS; readonly: INTEGER);

(* Label *) 
PROCEDURE ^ uiNewLabel ["uiNewLabel"] (text: ADDRESS): ADDRESS;
PROCEDURE ^ uiLabelText ["uiLabelText"] (l : ADDRESS): ADDRESS;
PROCEDURE ^ uiLabelSetText ["uiLabelSetText"] (l : ADDRESS; text : ADDRESS);

(* Tab *) 
PROCEDURE ^ uiNewTab ["uiNewTab"] (): ADDRESS;
PROCEDURE ^ uiTabAppend ["uiTabAppend"] (t: ADDRESS; name: ADDRESS; control: ADDRESS);
PROCEDURE ^ uiTabInsertAt ["uiTabInsertAt"] (t: ADDRESS; name: ADDRESS; index: INTEGER; control: ADDRESS);
PROCEDURE ^ uiTabDelete ["uiTabDelete"] (t: ADDRESS; index: INTEGER);
PROCEDURE ^ uiTabNumPages ["uiTabNumPages"] (t: ADDRESS): INTEGER;
PROCEDURE ^ uiTabMargined ["uiTabMargined"] (t: ADDRESS; index: INTEGER): INTEGER;
PROCEDURE ^ uiTabSetMargined ["uiTabSetMargined"] (t: ADDRESS; index: INTEGER; margined: INTEGER);

(* Group *)
PROCEDURE ^ uiNewGroup ["uiNewGroup"] (): ADDRESS;
PROCEDURE ^ uiGroupTitle ["uiGroupTitle"] (g : ADDRESS) : ADDRESS;
PROCEDURE ^ uiGroupSetTitle ["uiGroupSetTitle"] (g : ADDRESS; title : ADDRESS);
PROCEDURE ^ uiGroupSetChild ["uiGroupSetChild"] (g : ADDRESS; control : ADDRESS);
PROCEDURE ^ uiGroupMargined ["uiGroupMargined"] (g : ADDRESS) : INTEGER;
PROCEDURE ^ uiGroupSetMargined ["uiGroupSetMargined"] (g : ADDRESS; margined : INTEGER);

(* Spinbox *)  
PROCEDURE ^ uiNewSpinbox ["uiNewSpinbox"] (min, max : INTEGER): ADDRESS;
PROCEDURE ^ uiSpinboxValue ["uiSpinboxValue"] (s : ADDRESS) : INTEGER;
PROCEDURE ^ uiSpinboxSetValue ["uiSpinboxSetValue"] (s : ADDRESS; value : INTEGER);
PROCEDURE ^ uiSpinboxOnChanged ["uiSpinboxOnChanged"] (s : ADDRESS; callback : ADDRESS; data : Callback);

(* Slider *)   
PROCEDURE ^ uiNewSlider ["uiNewSlider"] (min, max : INTEGER): ADDRESS;
PROCEDURE ^ uiSliderValue ["uiSliderValue"] (s : ADDRESS) : INTEGER;
PROCEDURE ^ uiSliderSetValue ["uiSliderSetValue"] (s : ADDRESS; value : INTEGER);
PROCEDURE ^ uiSliderHasToolTip ["uiSliderHasToolTip"] (s : ADDRESS) : INTEGER;
PROCEDURE ^ uiSliderSetHasToolTip ["uiSliderSetHasToolTip"] (s : ADDRESS; hasToolTip : INTEGER);
PROCEDURE ^ uiSliderOnChanged ["uiSliderOnChanged"] (s : ADDRESS; callback : ADDRESS; data : Callback);
PROCEDURE ^ uiSliderOnReleased ["uiSliderOnReleased"] (s : ADDRESS; callback : ADDRESS; data : Callback);
PROCEDURE ^ uiSliderSetRange ["uiSliderSetRange"] (s : ADDRESS; min, max : INTEGER);

(* ProgressBar *)  
PROCEDURE ^ uiNewProgressBar ["uiNewProgressBar"] (): ADDRESS;
PROCEDURE ^ uiProgressBarValue ["uiProgressBarValue"] (p : ADDRESS) : INTEGER;
PROCEDURE ^ uiProgressBarSetValue ["uiProgressBarSetValue"] (p : ADDRESS; value : INTEGER);

(* Separator *)  
PROCEDURE ^ uiNewHorizontalSeparator ["uiNewHorizontalSeparator"] (): ADDRESS;
PROCEDURE ^ uiNewVerticalSeparator ["uiNewVerticalSeparator"] (): ADDRESS;

(* Combobox *) 
PROCEDURE ^ uiNewCombobox ["uiNewCombobox"] (): ADDRESS;
PROCEDURE ^ uiComboboxAppend ["uiComboboxAppend"] (c : ADDRESS; text : ADDRESS);
PROCEDURE ^ uiComboboxInsertAt ["uiComboboxInsertAt"] (c : ADDRESS; index : INTEGER; text : ADDRESS);
PROCEDURE ^ uiComboboxDelete ["uiComboboxDelete"] (c : ADDRESS; index : INTEGER);
PROCEDURE ^ uiComboboxClear ["uiComboboxClear"] (c : ADDRESS);
PROCEDURE ^ uiComboboxNumItems ["uiComboboxNumItems"] (c : ADDRESS): INTEGER;
PROCEDURE ^ uiComboboxSelected ["uiComboboxSelected"] (c : ADDRESS): INTEGER;
PROCEDURE ^ uiComboboxSetSelected ["uiComboboxSetSelected"] (c : ADDRESS; index : INTEGER);
PROCEDURE ^ uiComboboxOnSelected ["uiComboboxOnSelected"] (c : ADDRESS; callback : ADDRESS; data : Callback);

(* EditableCombobox *)
PROCEDURE ^ uiNewEditableCombobox ["uiNewEditableCombobox"] (): ADDRESS;
PROCEDURE ^ uiEditableComboboxAppend ["uiEditableComboboxAppend"] (c : ADDRESS; text : ADDRESS);
PROCEDURE ^ uiEditableComboboxText ["uiEditableComboboxText"] (c : ADDRESS) : ADDRESS;
PROCEDURE ^ uiEditableComboboxSetText ["uiEditableComboboxSetText"] (c : ADDRESS; text : ADDRESS);
PROCEDURE ^ uiEditableComboboxOnChanged ["uiEditableComboboxOnChanged"] (c : ADDRESS; callback : ADDRESS; data : Callback);

(* RadioButtons *)
PROCEDURE ^ uiNewRadioButtons ["uiNewRadioButtons"] (): ADDRESS;
PROCEDURE ^ uiRadioButtonsAppend ["uiRadioButtonsAppend"] (r : ADDRESS; text : ADDRESS);
PROCEDURE ^ uiRadioButtonsSelected ["uiRadioButtonsSelected"] (r : ADDRESS): INTEGER;
PROCEDURE ^ uiRadioButtonsSetSelected ["uiRadioButtonsSetSelected"] (r : ADDRESS; index : INTEGER);
PROCEDURE ^ uiRadioButtonsOnSelected ["uiRadioButtonsOnSelected"] (r : ADDRESS; callback : ADDRESS; data : Callback);

(* DateTimePicker *)  
PROCEDURE ^ uiNewDateTimePicker ["uiNewDateTimePicker"] (): ADDRESS;
PROCEDURE ^ uiNewDatePicker ["uiNewDatePicker"] (): ADDRESS;
PROCEDURE ^ uiNewTimePicker ["uiNewTimePicker"] (): ADDRESS;
PROCEDURE ^ uiDateTimePickerTime ["uiDateTimePickerTime"] (d : ADDRESS; VAR time : TM);
PROCEDURE ^ uiDateTimePickerSetTime ["uiDateTimePickerSetTime"] (d : ADDRESS; VAR time : TM);
PROCEDURE ^ uiDateTimePickerOnChanged ["uiDateTimePickerOnChanged"] (d : ADDRESS; callback : ADDRESS; data : Callback);

(* MultilineEntry *)
PROCEDURE ^ uiNewMultilineEntry ["uiNewMultilineEntry"] (): ADDRESS;
PROCEDURE ^ uiNewNonWrappingMultilineEntry ["uiNewNonWrappingMultilineEntry"] (): ADDRESS;
PROCEDURE ^ uiMultilineEntryText ["uiMultilineEntryText"] (e : ADDRESS) : ADDRESS;
PROCEDURE ^ uiMultilineEntrySetText ["uiMultilineEntrySetText"] (e : ADDRESS; text : ADDRESS);
PROCEDURE ^ uiMultilineEntryAppend ["uiMultilineEntryAppend"] (e : ADDRESS; text : ADDRESS);
PROCEDURE ^ uiMultilineEntryOnChanged ["uiMultilineEntryOnChanged"] (e : ADDRESS; callback : ADDRESS; data : Callback);
PROCEDURE ^ uiMultilineEntryReadOnly ["uiMultilineEntryReadOnly"] (e : ADDRESS): INTEGER;
PROCEDURE ^ uiMultilineEntrySetReadOnly ["uiMultilineEntrySetReadOnly"] (e : ADDRESS; readonly : INTEGER);

(* MenuItem *)
PROCEDURE ^ uiMenuItemEnable ["uiMenuItemEnable"] (c : ADDRESS);
PROCEDURE ^ uiMenuItemDisable ["uiMenuItemDisable"] (c : ADDRESS);
PROCEDURE ^ uiMenuItemOnClicked ["uiMenuItemOnClicked"] (i : ADDRESS; callback : ADDRESS; data : Callback);
PROCEDURE ^ uiMenuItemChecked ["uiMenuItemChecked"] (i : ADDRESS): INTEGER;
PROCEDURE ^ uiMenuItemSetChecked ["uiMenuItemSetChecked"] (i : ADDRESS; checked : INTEGER);

(* Menu *) 
PROCEDURE ^ uiNewMenu ["uiNewMenu"] (name : ADDRESS): ADDRESS;
PROCEDURE ^ uiMenuAppendItem ["uiMenuAppendItem"] (m : ADDRESS; name : ADDRESS): ADDRESS;
PROCEDURE ^ uiMenuAppendCheckItem ["uiMenuAppendCheckItem"] (m : ADDRESS; name : ADDRESS): ADDRESS;
PROCEDURE ^ uiMenuAppendQuitItem ["uiMenuAppendQuitItem"] (m : ADDRESS): ADDRESS;
PROCEDURE ^ uiMenuAppendPreferencesItem ["uiMenuAppendPreferencesItem"] (m : ADDRESS): ADDRESS;
PROCEDURE ^ uiMenuAppendAboutItem ["uiMenuAppendAboutItem"] (m : ADDRESS): ADDRESS;
PROCEDURE ^ uiMenuAppendSeparator ["uiMenuAppendSeparator"] (m : ADDRESS);

(* Standard Dialogs *)
PROCEDURE ^ uiOpenFile ["uiOpenFile"] (w: ADDRESS): ADDRESS;
PROCEDURE ^ uiOpenFolder ["uiOpenFolder"] (w: ADDRESS): ADDRESS;
PROCEDURE ^ uiSaveFile ["uiSaveFile"] (w: ADDRESS): ADDRESS;
PROCEDURE ^ uiMsgBox ["uiMsgBox"] (w: ADDRESS; title, description: ADDRESS);
PROCEDURE ^ uiMsgBoxError ["uiMsgBoxError"] (w: ADDRESS; title, description: ADDRESS);

(* Area *)
(* PROCEDURE ^ uiNewArea ["uiNewArea"] (VAR ah : AreaHandler): ADDRESS; *)
(* PROCEDURE ^ uiNewScrollingArea ["uiNewScrollingArea"] (VAR ah : AreaHandler; width : INTEGER; height : INTEGER): ADDRESS; *)
PROCEDURE ^ uiAreaSetSize ["uiAreaSetSize"] (a : ADDRESS; width : INTEGER; height : INTEGER);
PROCEDURE ^ uiAreaQueueRedrawAll ["uiAreaQueueRedrawAll"] (a : ADDRESS);
PROCEDURE ^ uiAreaScrollTo ["uiAreaScrollTo"] (a : ADDRESS; x : REAL; y : REAL; width : REAL; height : REAL);

(* DrawPath *)
PROCEDURE ^ uiDrawNewPath ["uiDrawNewPath"] (fillMode : INTEGER): ADDRESS;
PROCEDURE ^ uiDrawFreePath ["uiDrawFreePath"] (p : ADDRESS);
PROCEDURE ^ uiDrawPathNewFigure ["uiDrawPathNewFigure"] (p : ADDRESS; x : REAL; y  : REAL);
PROCEDURE ^ uiDrawPathNewFigureWithArc ["uiDrawPathNewFigureWithArc"] (p : ADDRESS; xCenter : REAL; yCenter  : REAL; radius : REAL; startAngle : REAL; sweep : REAL; negative : INTEGER);
PROCEDURE ^ uiDrawPathLineTo ["uiDrawPathLineTo"] (p : ADDRESS; x : REAL; y  : REAL);
PROCEDURE ^ uiDrawPathArcTo ["uiDrawPathArcTo"] (p : ADDRESS; xCenter : REAL; yCenter  : REAL; radius : REAL; startAngle : REAL; sweep : REAL; negative : INTEGER);
PROCEDURE ^ uiDrawPathBezierTo ["uiDrawPathBezierTo"] (p : ADDRESS; c1x : REAL; c1y  : REAL; c2x : REAL; c2y  : REAL; endX : REAL; endY : REAL);
PROCEDURE ^ uiDrawPathCloseFigure ["uiDrawPathCloseFigure"] (p : ADDRESS);
PROCEDURE ^ uiDrawPathAddRectangle ["uiDrawPathAddRectangle"] (p : ADDRESS; x : REAL; y  : REAL; width : REAL; height : REAL);
PROCEDURE ^ uiDrawPathEnded ["uiDrawPathEnded"] (p : ADDRESS) : INTEGER;
PROCEDURE ^ uiDrawPathEnd ["uiDrawPathEnd"] (p : ADDRESS);

(* Matrix *)
PROCEDURE ^ uiDrawMatrixSetIdentity ["uiDrawMatrixSetIdentity"] (m : ADDRESS);
PROCEDURE ^ uiDrawMatrixTranslate ["uiDrawMatrixTranslate"] (m : ADDRESS; x, y : REAL);
PROCEDURE ^ uiDrawMatrixScale ["uiDrawMatrixScale"] (m : ADDRESS; xCenter, yCenter, x, y : REAL);
PROCEDURE ^ uiDrawMatrixRotate ["uiDrawMatrixRotate"] (m : ADDRESS; x, y, amount : REAL);
PROCEDURE ^ uiDrawMatrixSkew ["uiDrawMatrixSkew"] (m : ADDRESS; x, y, xamount, yamount : REAL);
PROCEDURE ^ uiDrawMatrixMultiply ["uiDrawMatrixMultiply"] (dst, src : ADDRESS);
PROCEDURE ^ uiDrawMatrixInvertible ["uiDrawMatrixInvertible"] (m : ADDRESS) : INTEGER;
PROCEDURE ^ uiDrawMatrixInvert ["uiDrawMatrixInvert"] (m : ADDRESS) : INTEGER;
PROCEDURE ^ uiDrawMatrixTransformPoint ["uiDrawMatrixTransformPoint"] (m : ADDRESS; VAR x : REAL; VAR y : REAL);
PROCEDURE ^ uiDrawMatrixTransformSize ["uiDrawMatrixTransformSize"] (m : ADDRESS; VAR x : REAL; VAR y : REAL);

(* DrawContext *)
PROCEDURE ^ uiDrawSave ["uiDrawSave"] (c : ADDRESS);
PROCEDURE ^ uiDrawRestore ["uiDrawRestore"] (c : ADDRESS);
PROCEDURE ^ uiDrawTransform ["uiDrawTransform"] (c : ADDRESS; m : ADDRESS);
PROCEDURE ^ uiDrawClip ["uiDrawClip"] (c : ADDRESS; path : ADDRESS);
PROCEDURE ^ uiDrawStroke ["uiDrawStroke"] (c : ADDRESS; path : ADDRESS; b : ADDRESS; s : ADDRESS);
(* PROCEDURE ^ uiDrawFill ["uiDrawFill"] (c : ADDRESS; path : ADDRESS; b : DrawBrushPtr); *)

(* ColorButton *) 
PROCEDURE ^ uiNewColorButton ["uiNewColorButton"] (): ADDRESS;
PROCEDURE ^ uiColorButtonColor ["uiColorButtonColor"] (b : ADDRESS; r, g, bl, a : ADDRESS);
PROCEDURE ^ uiColorButtonSetColor ["uiColorButtonSetColor"] (b : ADDRESS; r, g, bl, a : REAL);
PROCEDURE ^ uiColorButtonOnChanged ["uiColorButtonOnChanged"] (b : ADDRESS; callback : ADDRESS; data : Callback);

(* Form *)
PROCEDURE ^ uiNewForm ["uiNewForm"] (): ADDRESS;
PROCEDURE ^ uiFormAppend ["uiFormAppend"] (f : ADDRESS; name : ADDRESS; control : ADDRESS; stretchy : INTEGER);
PROCEDURE ^ uiFormNumChildren ["uiFormNumChildren"] (f : ADDRESS): INTEGER;
PROCEDURE ^ uiFormDelete ["uiFormDelete"] (f : ADDRESS; index : INTEGER);
PROCEDURE ^ uiFormPadded ["uiFormPadded"] (f : ADDRESS) : INTEGER;
PROCEDURE ^ uiFormSetPadded ["uiFormSetPadded"] (f : ADDRESS; padded : INTEGER);

(* Grid *)
PROCEDURE ^ uiNewGrid ["uiNewGrid"] (): ADDRESS;
PROCEDURE ^ uiGridAppend ["uiGridAppend"] (g : ADDRESS; control : ADDRESS; left, top, xpan, yspan, hexpand, halign, vexpand, valign : INTEGER);
PROCEDURE ^ uiGridInsertAt ["uiGridInsertAt"] (g : ADDRESS; control, existing : ADDRESS; at, xpan, yspan, hexpand, halign, vexpand, valign : INTEGER);
PROCEDURE ^ uiGridPadded ["uiGridPadded"] (g : ADDRESS) : INTEGER;
PROCEDURE ^ uiGridSetPadded ["uiGridSetPadded"] (g : ADDRESS; padded : INTEGER);

(* Image *)  
PROCEDURE ^ uiNewImage ["uiNewImage"] (width, height : REAL): ADDRESS;
PROCEDURE ^ uiFreeImage ["uiFreeImage"] (i : ADDRESS);
PROCEDURE ^ uiImageAppend ["uiImageAppend"] (i : ADDRESS; pixels : ADDRESS; pixelWidth, pixelHeight, byteStride : INTEGER);

(* TableValue *)
PROCEDURE ^ uiTableValueGetType ["uiTableValueGetType"] (t : ADDRESS): INTEGER;
PROCEDURE ^ uiNewTableValueString ["uiNewTableValueString"] (str : ADDRESS) : ADDRESS;
PROCEDURE ^ uiTableValueString ["uiTableValueString"] (t : ADDRESS): ADDRESS;
PROCEDURE ^ uiNewTableValueImage ["uiNewTableValueImage"] (img : ADDRESS) : ADDRESS;
PROCEDURE ^ uiTableValueImage ["uiTableValueImage"] (t : ADDRESS): ADDRESS;
PROCEDURE ^ uiNewTableValueInt ["uiNewTableValueInt"] (i : INTEGER) : ADDRESS;
PROCEDURE ^ uiTableValueInt ["uiTableValueInt"] (t : ADDRESS): INTEGER;
PROCEDURE ^ uiNewTableValueColor ["uiNewTableValueColor"] (r, g, b, a : REAL) : ADDRESS;
PROCEDURE ^ uiTableValueColor ["uiTableValueColor"] (t : ADDRESS; VAR r : REAL; VAR g : REAL; VAR b : REAL; VAR a : REAL);

(* Table *)   
PROCEDURE ^ uiNewTable ["uiNewTable"] (VAR params : TableParams): ADDRESS;
PROCEDURE ^ uiTableAppendTextColumn ["uiTableAppendTextColumn"] (t : ADDRESS; name : ADDRESS; textModelColumn : INTEGER; textEditableModelColumn : INTEGER; VAR textParams : TableTextColumnOptionalParams);
PROCEDURE ^ uiTableAppendImageColumn ["uiTableAppendImageColumn"] (t : ADDRESS; name : ADDRESS; imageModelColumn : INTEGER);
PROCEDURE ^ uiTableAppendImageTextColumn ["uiTableAppendImageTextColumn"] (t : ADDRESS; name : ADDRESS; imageModelColumn : INTEGER; textModelColumn : INTEGER; textEditableModelColumn : INTEGER; VAR textParams : TableTextColumnOptionalParams);
PROCEDURE ^ uiTableAppendCheckboxColumn ["uiTableAppendCheckboxColumn"] (t : ADDRESS; name : ADDRESS; checkboxModelColumn : INTEGER; checkboxEditableModelColumn : INTEGER);
PROCEDURE ^ uiTableAppendCheckboxTextColumn ["uiTableAppendCheckboxTextColumn"] (t : ADDRESS; name : ADDRESS; checkboxModelColumn : INTEGER; checkboxEditableModelColumn : INTEGER; textModelColumn : INTEGER; textEditableModelColumn : INTEGER; VAR textParams : TableTextColumnOptionalParams);
PROCEDURE ^ uiTableAppendProgressBarColumn ["uiTableAppendProgressBarColumn"] (t : ADDRESS; name : ADDRESS; progressModelColumn : INTEGER);
PROCEDURE ^ uiTableAppendButtonColumn ["uiTableAppendButtonColumn"] (t : ADDRESS; name : ADDRESS; buttonModelColumn : INTEGER;  buttonClickableModelColumn : INTEGER);
PROCEDURE ^ uiTableHeaderVisible ["uiTableHeaderVisible"] (t : ADDRESS): INTEGER;
PROCEDURE ^ uiTableHeaderSetVisible ["uiTableHeaderSetVisible"] (t : ADDRESS; visible : INTEGER);
PROCEDURE ^ uiTableOnRowClicked ["uiTableOnRowClicked"] (t : ADDRESS; callback : ADDRESS; data : ADDRESS);
PROCEDURE ^ uiTableOnRowDoubleClicked ["uiTableOnRowDoubleClicked"] (t : ADDRESS; callback : ADDRESS; data : ADDRESS);
PROCEDURE ^ uiTableHeaderSetSortIndicator ["uiTableHeaderSetSortIndicator"] (t : ADDRESS; column : INTEGER; indicator : INTEGER);
PROCEDURE ^ uiTableHeaderSortIndicator ["uiTableHeaderSortIndicator"] (t : ADDRESS; column : INTEGER) : INTEGER;
PROCEDURE ^ uiTableHeaderOnClicked ["uiTableHeaderOnClicked"] (t : ADDRESS; callback : ADDRESS; data : ADDRESS);
PROCEDURE ^ uiTableColumnWidth ["uiTableColumnWidth"] (t : ADDRESS; column : INTEGER) : INTEGER;
PROCEDURE ^ uiTableColumnSetWidth ["uiTableColumnSetWidth"] (t : ADDRESS; column : INTEGER; width : INTEGER);
PROCEDURE ^ uiTableGetSelectionMode ["uiTableGetSelectionMode"] (t : ADDRESS) : INTEGER;
PROCEDURE ^ uiTableSetSelectionMode ["uiTableSetSelectionMode"] (t : ADDRESS; mode : INTEGER);
PROCEDURE ^ uiTableOnSelectionChanged ["uiTableOnSelectionChanged"] (t : ADDRESS; callback : ADDRESS; data : ADDRESS);
PROCEDURE ^ uiTableGetSelection ["uiTableGetSelection"] (t : ADDRESS) : TableSelectionPtr;
PROCEDURE ^ uiTableSetSelection ["uiTableSetSelection"] (t : ADDRESS; selection : TableSelectionPtr);
PROCEDURE ^ uiFreeTableSelection ["uiFreeTableSelection"] (selection : TableSelectionPtr);

(* Raw C-string procedures *)
PROCEDURE CStringLength(adr : ADDRESS): LENGTH;
VAR
    i : LENGTH;
    ch : CHAR;
BEGIN
    IF adr = 0 THEN RETURN 0 END;
    i := 0; ch := 00X;
    LOOP
        SYSTEM.GET(adr, ch);
        IF ch = 00X THEN EXIT END;
        INC(i); INC(adr);
    END;
    RETURN i
END CStringLength;

PROCEDURE CStringCopy*(VAR dst : ARRAY OF CHAR; adr : ADDRESS);
VAR
    i : LENGTH;
    ch : CHAR;
BEGIN
    IF adr = 0 THEN dst[0] := 00X; RETURN END;
    FOR i := 0 TO LEN(dst) - 1 DO
        SYSTEM.GET(adr, ch);
        dst[i] := ch;
        IF ch = 00X THEN RETURN END;
        INC(adr);
    END
END CStringCopy;

(*
   Procedures
*)

(** Signal Quit to application *)
PROCEDURE Quit*(): BOOLEAN;
BEGIN
    uiQuit();
    RETURN TRUE;
END Quit;

(*
   App
*)

(** Start main loop *)
PROCEDURE (VAR this : App) Main*();
BEGIN uiMain()
END Main;

(** Deallocate resources *)
PROCEDURE (VAR this : App) Destroy*();
BEGIN IGNORE(uiUninit());
END Destroy;

(** Initialize App *)
PROCEDURE InitApp*(VAR this : App);
VAR  err : ADDRESS;
BEGIN
    this.opts.size := 0;
    err := uiInit(SYSTEM.ADR(this.opts));
    IF err # 0 THEN uiFreeInitError(err) END
END InitApp;

(*
-  Control base class
*)

(** Dispose Control and all allocated resources *)
PROCEDURE (VAR this : Control) Destroy*();
BEGIN uiControlDestroy(this.ptr);
END Destroy;

(** Returns TRUE if control is a top level control.*)
PROCEDURE (VAR this : Control) IsTopLevel*(): BOOLEAN;
BEGIN RETURN uiControlToplevel(this.ptr) # 0;
END IsTopLevel;

(** Returns TRUE if control is visible *)
PROCEDURE (VAR this : Control) IsVisible*(): BOOLEAN;
BEGIN RETURN uiControlVisible(this.ptr) # 0;
END IsVisible;

(** Shows the control *)
PROCEDURE (VAR this : Control) Show*();
BEGIN uiControlShow(this.ptr);
END Show;

(** Hides the control *)
PROCEDURE (VAR this : Control) Hide*();
BEGIN uiControlHide(this.ptr);
END Hide;

(** Returns TRUE if the control is enabled *)
PROCEDURE (VAR this : Control) IsEnabled*(): BOOLEAN;
BEGIN RETURN uiControlEnabled(this.ptr) # 0;
END IsEnabled;

(** Enable control *)
PROCEDURE (VAR this : Control) Enable*();
BEGIN uiControlEnable(this.ptr);
END Enable;

(** Disable control *)
PROCEDURE (VAR this : Control) Disable*();
BEGIN uiControlDisable(this.ptr);
END Disable;

(*
   Window
*)

(** Initialize Window *)
PROCEDURE InitWindow*(VAR w : Window; title- : ARRAY OF CHAR; width, height : INTEGER; hasMenubar : BOOLEAN);
BEGIN
    w.ptr := uiNewWindow(SYSTEM.ADR(title[0]), width, height, INTEGER(hasMenubar));
END InitWindow;

(** Get window title. *)
PROCEDURE (VAR this : Window) Title*(VAR title: ARRAY OF CHAR);
VAR adr : ADDRESS;
BEGIN
    adr := uiWindowTitle(this.ptr);
    IF adr = 0 THEN title[0] := 00X; RETURN END;
    CStringCopy(title, adr)
END Title;

(** Set window title. *)
PROCEDURE (VAR this : Window) SetTitle*(title-: ARRAY OF CHAR);
BEGIN uiWindowSetTitle(this.ptr,  SYSTEM.ADR(title[0]));
END SetTitle;

(** Get window position. *)
PROCEDURE (VAR this : Window) Position*(VAR x, y: INTEGER);
BEGIN uiWindowPosition(this.ptr, x, y);
END Position;

(** Set OnPositionChanged callback. *)
PROCEDURE (VAR this : Window) OnPositionChanged*(callback: Callback);
BEGIN uiWindowOnPositionChanged(this.ptr, SYSTEM.ADR(winui_onCallback), callback);
END OnPositionChanged;

(** Set window position. *)
PROCEDURE (VAR this : Window) SetPosition*(x, y: INTEGER);
BEGIN uiWindowSetPosition(this.ptr, x, y);
END SetPosition;

(** Get window content size. *)
PROCEDURE (VAR this : Window) ContentSize*(VAR width, height: INTEGER);
BEGIN uiWindowContentSize(this.ptr, width, height);
END ContentSize;

(** Set window content size. *)
PROCEDURE (VAR this : Window) SetContentSize*(width, height: INTEGER);
BEGIN uiWindowSetContentSize(this.ptr, width, height);
END SetContentSize;

(** Get window fullscreen flag. *)
PROCEDURE (VAR this : Window) IsFullscreen*(): BOOLEAN;
BEGIN RETURN BOOLEAN(uiWindowFullscreen(this.ptr));
END IsFullscreen;

(** Set window fullscreen flag. *)
PROCEDURE (VAR this : Window) SetFullscreen*(fullscreen: BOOLEAN);
BEGIN uiWindowSetFullscreen(this.ptr, INTEGER(fullscreen));
END SetFullscreen;

(** Set OnContentSizeChanged callback. *)
PROCEDURE (VAR this : Window) OnContentSizeChanged*(callback: Callback);
BEGIN uiWindowOnContentSizeChanged(this.ptr, SYSTEM.ADR(winui_onCallback), callback);
END OnContentSizeChanged;

(** Set OnClosing callback. *)
PROCEDURE (VAR this : Window) OnClosing*(callback: CallbackInteger);
BEGIN uiWindowOnClosing(this.ptr, SYSTEM.ADR(winui_onCallback), callback);
END OnClosing;

(** Set OnFocusChanged callback. *)
PROCEDURE (VAR this : Window) OnFocusChanged*(callback: Callback);
BEGIN uiWindowOnFocusChanged(this.ptr, SYSTEM.ADR(winui_onCallback), callback);
END OnFocusChanged;

(** Get window focus status. *)
PROCEDURE (VAR this : Window) IsFocused*(): BOOLEAN;
BEGIN RETURN BOOLEAN(uiWindowFocused(this.ptr));
END IsFocused;

(** Get window borderless flag. *)
PROCEDURE (VAR this : Window) IsBorderless*(): BOOLEAN;
BEGIN RETURN BOOLEAN(uiWindowBorderless(this.ptr));
END IsBorderless;

(** Set window borderless flag. *)
PROCEDURE (VAR this : Window) SetBorderless*(borderless: BOOLEAN);
BEGIN uiWindowSetBorderless(this.ptr, INTEGER(borderless));
END SetBorderless;
                                   
(** Set child control *)
PROCEDURE (VAR this : Window) SetChild*(child- : Control);
BEGIN
    uiWindowSetChild(this.ptr, child.ptr);
    uiControlShow(this.ptr);
END SetChild;

(** Get window margined flag. *)
PROCEDURE (VAR this : Window) IsMargined*(): BOOLEAN;
BEGIN RETURN BOOLEAN(uiWindowMargined(this.ptr));
END IsMargined;

(** Set window margined flag. *)
PROCEDURE (VAR this : Window) SetMargined*(margined: BOOLEAN);
BEGIN uiWindowSetMargined(this.ptr, INTEGER(margined));
END SetMargined;

(** Get window resizeable flag. *)
PROCEDURE (VAR this : Window) IsResizeable*(): BOOLEAN;
BEGIN RETURN BOOLEAN(uiWindowResizeable(this.ptr));
END IsResizeable;

(** Set window resizeable flag. *)
PROCEDURE (VAR this : Window) SetResizeable*(resizeable: BOOLEAN);
BEGIN uiWindowSetResizeable(this.ptr, INTEGER(resizeable));
END SetResizeable;

(** File chooser dialog window to select a single file. *)
PROCEDURE (VAR this : Window) OpenFile*(VAR filename: ARRAY OF CHAR): BOOLEAN;
VAR adr : ADDRESS;
BEGIN
    adr := uiOpenFile(this.ptr);
    IF adr = 0 THEN RETURN FALSE END;
    CStringCopy(filename, adr);
    RETURN TRUE
END OpenFile;

(** Folder chooser dialog window to select a single folder. *)
PROCEDURE (VAR this : Window) OpenFolder*(VAR filename: ARRAY OF CHAR): BOOLEAN;
VAR adr : ADDRESS;
BEGIN
    adr := uiOpenFolder(this.ptr);
    IF adr = 0 THEN RETURN FALSE END;
    CStringCopy(filename, adr);
    RETURN TRUE
END OpenFolder;

(** Save file dialog window. *)
PROCEDURE (VAR this : Window) SaveFile*(VAR filename: ARRAY OF CHAR): BOOLEAN;
VAR adr : ADDRESS;
BEGIN
    adr := uiSaveFile(this.ptr);
    IF adr = 0 THEN RETURN FALSE END;
    CStringCopy(filename, adr);
    RETURN TRUE
END SaveFile;

(** Message box dialog window. *)
PROCEDURE (VAR this : Window) MsgBox*(title- : ARRAY OF CHAR; description- : ARRAY OF CHAR);
BEGIN uiMsgBox(this.ptr, SYSTEM.ADR(title[0]), SYSTEM.ADR(description[0]));
END MsgBox;

(** Error message box dialog window. *)
PROCEDURE (VAR this : Window) MsgBoxError*(title- : ARRAY OF CHAR; description- : ARRAY OF CHAR);
BEGIN uiMsgBoxError(this.ptr, SYSTEM.ADR(title[0]), SYSTEM.ADR(description[0]));
END MsgBoxError;

(*
   Button
*)

(** Initialize Button *)
PROCEDURE InitButton*(VAR b : Button; text- : ARRAY OF CHAR);
VAR ret : ADDRESS;
BEGIN
    ret := uiNewButton(SYSTEM.ADR(text[0]));
    b.ptr := ret;
END InitButton;

(** Get button text. *)
PROCEDURE (VAR this : Button) Text*(VAR text: ARRAY OF CHAR);
VAR adr : ADDRESS;
BEGIN
    adr := uiButtonText(this.ptr);
    IF adr = 0 THEN text[0] := 00X; RETURN END;
    CStringCopy(text, adr)
END Text;

(** Set button text. *)
PROCEDURE (VAR this : Button) SetText*(text-: ARRAY OF CHAR);
BEGIN uiButtonSetText(this.ptr,  SYSTEM.ADR(text[0]));
END SetText;

(** Set button OnClicked callback. *)
PROCEDURE (VAR this : Button) OnClicked*(callback: Callback);
BEGIN uiButtonOnClicked(this.ptr,  SYSTEM.ADR(winui_onCallback), callback);
END OnClicked;

(*
   Box
*)

(** Initialize vertical Box *)
PROCEDURE InitVerticalBox*(VAR b : Box);
VAR ret : ADDRESS;
BEGIN
    ret := uiNewVerticalBox();
    b.ptr := ret;
END InitVerticalBox;

(** Initialize horizontal Box *)
PROCEDURE InitHorizontalBox*(VAR b : Box);
VAR ret : ADDRESS;
BEGIN
    ret := uiNewHorizontalBox();
    b.ptr := ret;
END InitHorizontalBox;

(**
Append control to Box.
If stretchy is TRUE the Control expand to the remaining space.
If multiple strechy Controls exists the space is equally shared.
*)
PROCEDURE (VAR this : Box) Append*(child- : Control; stretchy: BOOLEAN);
BEGIN uiBoxAppend(this.ptr, child.ptr, INTEGER(stretchy));
END Append;

(** Returns the number of controls contained within the box. *)
PROCEDURE (VAR this : Box) NumChildren*(): INTEGER;
BEGIN RETURN uiBoxNumChildren(this.ptr)
END NumChildren;

(** Removes the Control at index *)
PROCEDURE (VAR this : Box) Delete*(index : INTEGER);
BEGIN uiBoxDelete(this.ptr, index);
END Delete;

(** Returns TRUE if the Box is padded *)
PROCEDURE (VAR this : Box) IsPadded*(): BOOLEAN;
BEGIN RETURN uiBoxPadded(this.ptr) # 0;
END IsPadded;

(** Set Box padded flag *)
PROCEDURE (VAR this : Box) SetPadded*(padded : BOOLEAN);
BEGIN uiBoxSetPadded(this.ptr, INTEGER(padded));
END SetPadded;

(*
   Checkbox
*)

(** Initialize Checkbox *)
PROCEDURE InitCheckbox*(VAR c : Checkbox; text- : ARRAY OF CHAR);
VAR ret : ADDRESS;
BEGIN
    ret := uiNewButton(SYSTEM.ADR(text[0]));
    c.ptr := ret;
END InitCheckbox;

(** Get checkbox text. *)
PROCEDURE (VAR this : Checkbox) Text*(VAR text: ARRAY OF CHAR);
VAR adr : ADDRESS;
BEGIN
    adr := uiCheckboxText(this.ptr);
    IF adr = 0 THEN text[0] := 00X; RETURN END;
    CStringCopy(text, adr)
END Text;

(** Set checkbox text. *)
PROCEDURE (VAR this : Checkbox) SetText*(text-: ARRAY OF CHAR);
BEGIN uiCheckboxSetText(this.ptr,  SYSTEM.ADR(text[0]));
END SetText;

(** Set checkbox OnToggled callback. *)
PROCEDURE (VAR this : Checkbox) OnToggled*(callback: Callback);
BEGIN uiCheckboxOnToggled(this.ptr,  SYSTEM.ADR(winui_onCallback), callback);
END OnToggled;

(** Returns TRUE if the Checkbox is checked *)
PROCEDURE (VAR this : Checkbox) IsChecked*(): BOOLEAN;
BEGIN RETURN uiCheckboxChecked(this.ptr) # 0;
END IsChecked;

(** Set Checkbox checked flag *)
PROCEDURE (VAR this : Checkbox) SetChecked*(checked : BOOLEAN);
BEGIN uiCheckboxSetChecked(this.ptr, INTEGER(checked));
END SetChecked;

(*
   Entry
*)

(** Initialize Entry *)
PROCEDURE InitEntry*(VAR e : Entry);
VAR ret : ADDRESS;
BEGIN
    ret := uiNewEntry();
    e.ptr := ret;
END InitEntry;

(** Initialize password Entry *)
PROCEDURE InitPasswordEntry*(VAR e : Entry);
VAR ret : ADDRESS;
BEGIN
    ret := uiNewPasswordEntry();
    e.ptr := ret;
END InitPasswordEntry;

(** Initialize search Entry *)
PROCEDURE InitSearchEntry*(VAR e : Entry);
VAR ret : ADDRESS;
BEGIN
    ret := uiNewSearchEntry();
    e.ptr := ret;
END InitSearchEntry;

(** Get entry text. *)
PROCEDURE (VAR this : Entry) Text*(VAR text: ARRAY OF CHAR);
VAR adr : ADDRESS;
BEGIN
    adr := uiEntryText(this.ptr);
    IF adr = 0 THEN text[0] := 00X; RETURN END;
    CStringCopy(text, adr)
END Text;

(** Set entry text. *)
PROCEDURE (VAR this : Entry) SetText*(text-: ARRAY OF CHAR);
BEGIN uiEntrySetText(this.ptr,  SYSTEM.ADR(text[0]));
END SetText;

(** Set entry OnChanged callback. *)
PROCEDURE (VAR this : Entry) OnChanged*(callback: Callback);
BEGIN uiEntryOnChanged(this.ptr,  SYSTEM.ADR(winui_onCallback), callback);
END OnChanged;

(** Returns TRUE if the entry is readonly *)
PROCEDURE (VAR this : Entry) IsReadOnly*(): BOOLEAN;
BEGIN RETURN uiEntryReadOnly(this.ptr) # 0;
END IsReadOnly;

(** Set entry readonly flag *)
PROCEDURE (VAR this : Entry) SetReadOnly*(readOnly : BOOLEAN);
BEGIN uiEntrySetReadOnly(this.ptr, INTEGER(readOnly));
END SetReadOnly;

(*
   Label
*)

(** Initialize Label *)
PROCEDURE InitLabel*(VAR l : Label; text- : ARRAY OF CHAR);
VAR ret : ADDRESS;
BEGIN
    ret := uiNewLabel(SYSTEM.ADR(text[0]));
    l.ptr := ret;
END InitLabel;

(** Get label text. *)
PROCEDURE (VAR this : Label) Text*(VAR text: ARRAY OF CHAR);
VAR adr : ADDRESS;
BEGIN
    adr := uiLabelText(this.ptr);
    IF adr = 0 THEN text[0] := 00X; RETURN END;
    CStringCopy(text, adr)
END Text;

(** Set label text. *)
PROCEDURE (VAR this : Label) SetText*(text-: ARRAY OF CHAR);
BEGIN uiLabelSetText(this.ptr,  SYSTEM.ADR(text[0]));
END SetText;

(*
   Tab
*)

(** Initialize Tab *)
PROCEDURE InitTab*(VAR t : Tab);
VAR ret : ADDRESS;
BEGIN
    ret := uiNewTab();
    t.ptr := ret;
END InitTab;

(** Appends a control in form of a page/tab with label. *)
PROCEDURE (VAR this : Tab) Append*(name- : ARRAY OF CHAR; control : Control);
BEGIN uiTabAppend(this.ptr, SYSTEM.ADR(name[0]), control.ptr);
END Append;

(** Inserts a control in form of a page/tab with label at index. *)
PROCEDURE (VAR this : Tab) InsertAt*(name- : ARRAY OF CHAR; index : INTEGER; control : Control);
BEGIN uiTabInsertAt(this.ptr, SYSTEM.ADR(name[0]), index, control.ptr);
END InsertAt;

(** Removes the control at index. *)
PROCEDURE (VAR this : Tab) Delete*(index : INTEGER);
BEGIN uiTabDelete(this.ptr, index);
END Delete;

(** Returns the number of pages contained. *)
PROCEDURE (VAR this : Tab) NumPages*(): INTEGER;
BEGIN RETURN uiTabNumPages(this.ptr)
END NumPages;

(** Returns whether or not the page/tab at index has a margin. *)
PROCEDURE (VAR this : Tab) IsMargined*(index : INTEGER): BOOLEAN;
BEGIN RETURN BOOLEAN(uiTabMargined(this.ptr, index));
END IsMargined;

(** Sets whether or not the page/tab at index has a margin. *)
PROCEDURE (VAR this : Tab) SetMargined*(index : INTEGER; margined: BOOLEAN);
BEGIN uiTabSetMargined(this.ptr, index, INTEGER(margined));
END SetMargined;

(*
   Group
*)

(** Initialize Group *)
PROCEDURE InitGroup*(VAR g : Group);
VAR ret : ADDRESS;
BEGIN
    ret := uiNewTab();
    g.ptr := ret;
END InitGroup;

(** Get group title. *)
PROCEDURE (VAR this : Group) Title*(VAR title: ARRAY OF CHAR);
VAR adr : ADDRESS;
BEGIN
    adr := uiGroupTitle(this.ptr);
    IF adr = 0 THEN title[0] := 00X; RETURN END;
    CStringCopy(title, adr)
END Title;

(** Set group title. *)
PROCEDURE (VAR this : Group) SetTitle*(title-: ARRAY OF CHAR);
BEGIN uiGroupSetTitle(this.ptr,  SYSTEM.ADR(title[0]));
END SetTitle;

(** Set child control *)
PROCEDURE (VAR this : Group) SetChild*(child- : Control);
BEGIN
    uiGroupSetChild(this.ptr, child.ptr);
END SetChild;

(** Returns whether or not the group has a margin. *)
PROCEDURE (VAR this : Group) IsMargined*(): BOOLEAN;
BEGIN RETURN BOOLEAN(uiGroupMargined(this.ptr));
END IsMargined;

(** Sets whether or not the group has a margin. *)
PROCEDURE (VAR this : Group) SetMargined*(margined: BOOLEAN);
BEGIN uiGroupSetMargined(this.ptr, INTEGER(margined));
END SetMargined;

(*
   Spinbox
*)

(** Initialize Spinbox *)
PROCEDURE InitSpinbox*(VAR s : Spinbox; min, max : INTEGER);
VAR ret : ADDRESS;
BEGIN
    ret := uiNewSpinbox(min, max);
    s.ptr := ret;
END InitSpinbox;

(** Returns the Spinbox value. *)
PROCEDURE (VAR this : Spinbox) Value*():INTEGER;
BEGIN RETURN uiSpinboxValue(this.ptr)
END Value;

(** Sets the spinbox value. *)
PROCEDURE (VAR this : Spinbox) SetValue*(value : INTEGER);
BEGIN uiSpinboxSetValue(this.ptr, value)
END SetValue;

(** Set spinbox OnChanged callback. *)
PROCEDURE (VAR this : Spinbox) OnChanged*(callback: Callback);
BEGIN uiSpinboxOnChanged(this.ptr,  SYSTEM.ADR(winui_onCallback), callback);
END OnChanged;

(*
    Slider
*)

(** Initialize Slider *)
PROCEDURE InitSlider*(VAR s : Slider; min, max : INTEGER);
VAR ret : ADDRESS;
BEGIN
    ret := uiNewSlider(min, max);
    s.ptr := ret;
END InitSlider;

(** Returns the Slider value. *)
PROCEDURE (VAR this : Slider) Value*():INTEGER;
BEGIN RETURN uiSliderValue(this.ptr)
END Value;

(** Sets the Slider value. *)
PROCEDURE (VAR this : Slider) SetValue*(value : INTEGER);
BEGIN uiSliderSetValue(this.ptr, value)
END SetValue;

(** Returns whether or not the slider har tooltip set. *)
PROCEDURE (VAR this : Slider) HasToolTip*(): BOOLEAN;
BEGIN RETURN BOOLEAN(uiSliderHasToolTip(this.ptr));
END HasToolTip;

(** Sets slide tooltip flag. *)
PROCEDURE (VAR this : Slider) SetHasToolTip*(margined: BOOLEAN);
BEGIN uiSliderSetHasToolTip(this.ptr, INTEGER(margined));
END SetHasToolTip;

(** Set slider OnChanged callback. *)
PROCEDURE (VAR this : Slider) OnChanged*(callback: Callback);
BEGIN uiSliderOnChanged(this.ptr,  SYSTEM.ADR(winui_onCallback), callback);
END OnChanged;

(** Set slider OnReleased callback. *)
PROCEDURE (VAR this : Slider) OnReleased*(callback: Callback);
BEGIN uiSliderOnReleased(this.ptr,  SYSTEM.ADR(winui_onCallback), callback);
END OnReleased;

(** Sets the slider range values. *)
PROCEDURE (VAR this : Slider) SetRange*(min, max : INTEGER);
BEGIN uiSliderSetRange(this.ptr, min, max)
END SetRange;

(*
    ProgressBar
*)

(** Initialize ProgressBar *)
PROCEDURE InitProgressBar*(VAR s : ProgressBar);
VAR ret : ADDRESS;
BEGIN
    ret := uiNewProgressBar();
    s.ptr := ret;
END InitProgressBar;

(** Returns the ProgressBar value. *)
PROCEDURE (VAR this : ProgressBar) Value*():INTEGER;
BEGIN RETURN uiProgressBarValue(this.ptr)
END Value;

(** Sets the ProgressBar value. *)
PROCEDURE (VAR this : ProgressBar) SetValue*(value : INTEGER);
BEGIN uiProgressBarSetValue(this.ptr, value)
END SetValue;

(*
    Separator
*)

(** Initialize HorizontalSeparator *)
PROCEDURE InitHorizontalSeparator*(VAR s : Separator);
VAR ret : ADDRESS;
BEGIN
    ret := uiNewHorizontalSeparator();
    s.ptr := ret;
END InitHorizontalSeparator;

(** Initialize VerticalSeparator *)
PROCEDURE InitVerticalSeparator*(VAR s : Separator);
VAR ret : ADDRESS;
BEGIN
    ret := uiNewVerticalSeparator();
    s.ptr := ret;
END InitVerticalSeparator;

(*
    Combobox
*)

(** Initialize Combobox *)
PROCEDURE InitCombobox*(VAR s : Combobox);
VAR ret : ADDRESS;
BEGIN
    ret := uiNewCombobox();
    s.ptr := ret;
END InitCombobox;

(** Append text. *)
PROCEDURE (VAR this : Combobox) Append*(text- : ARRAY OF CHAR);
BEGIN uiComboboxAppend(this.ptr, SYSTEM.ADR(text))
END Append;

(** Insert text at index. *)
PROCEDURE (VAR this : Combobox) InsertAt*(index : INTEGER; text- : ARRAY OF CHAR);
BEGIN uiComboboxInsertAt(this.ptr, index, SYSTEM.ADR(text))
END InsertAt;

(** Delete text at index. *)
PROCEDURE (VAR this : Combobox) Delete*(index : INTEGER);
BEGIN uiComboboxDelete(this.ptr, index)
END Delete;

(** Clear items. *)
PROCEDURE (VAR this : Combobox) Clear*();
BEGIN uiComboboxClear(this.ptr)
END Clear;

(** Returns the number of items. *)
PROCEDURE (VAR this : Combobox) NumItems*():INTEGER;
BEGIN RETURN uiComboboxNumItems(this.ptr)
END NumItems;

(** Returns selected item index. *)
PROCEDURE (VAR this : Combobox) Selected*():INTEGER;
BEGIN RETURN uiComboboxSelected(this.ptr)
END Selected;

(** Select item at index. *)
PROCEDURE (VAR this : Combobox) SetSelected*(index : INTEGER);
BEGIN uiComboboxSetSelected(this.ptr, index)
END SetSelected;

(** Set Combobox OnSelected callback. *)
PROCEDURE (VAR this : Combobox) OnSelected*(callback: Callback);
BEGIN uiComboboxOnSelected(this.ptr,  SYSTEM.ADR(winui_onCallback), callback);
END OnSelected;

(*
    EditableCombobox
*)

(** Initialize EditableCombobox *)
PROCEDURE InitEditableCombobox*(VAR s : EditableCombobox);
VAR ret : ADDRESS;
BEGIN
    ret := uiNewEditableCombobox();
    s.ptr := ret;
END InitEditableCombobox;

(** Append text. *)
PROCEDURE (VAR this : EditableCombobox) Append*(text- : ARRAY OF CHAR);
BEGIN uiEditableComboboxAppend(this.ptr, SYSTEM.ADR(text))
END Append;

(** Get text lenght. *)
PROCEDURE (VAR this : EditableCombobox) TextLength*(): LENGTH;
VAR adr : ADDRESS;
BEGIN
    adr := uiEditableComboboxText(this.ptr);
    RETURN CStringLength(adr)
END TextLength;

(** Get text. *)
PROCEDURE (VAR this : EditableCombobox) Text*(VAR text : ARRAY OF CHAR);
VAR adr : ADDRESS;
BEGIN
    adr := uiEditableComboboxText(this.ptr);
    IF adr = 0 THEN text[0] := 00X; RETURN END;
    CStringCopy(text, adr)
END Text;

(** Set text. *)
PROCEDURE (VAR this : EditableCombobox) SetText*(text- : ARRAY OF CHAR);
BEGIN uiEditableComboboxSetText(this.ptr, SYSTEM.ADR(text))
END SetText;

(** Set OnChanged callback. *)
PROCEDURE (VAR this : EditableCombobox) OnChanged*(callback: Callback);
BEGIN uiEditableComboboxOnChanged(this.ptr,  SYSTEM.ADR(winui_onCallback), callback);
END OnChanged;

(*
    RadioButtons
*)

(** Initialize EditableCombobox *)
PROCEDURE InitRadioButtons*(VAR s : RadioButtons);
VAR ret : ADDRESS;
BEGIN
    ret := uiNewRadioButtons();
    s.ptr := ret;
END InitRadioButtons;

(** Append button. *)
PROCEDURE (VAR this : RadioButtons) Append*(text- : ARRAY OF CHAR);
BEGIN uiRadioButtonsAppend(this.ptr, SYSTEM.ADR(text))
END Append;

(** Returns selected button index. *)
PROCEDURE (VAR this : RadioButtons) Selected*():INTEGER;
BEGIN RETURN uiRadioButtonsSelected(this.ptr)
END Selected;

(** Select button at index. *)
PROCEDURE (VAR this : RadioButtons) SetSelected*(index : INTEGER);
BEGIN uiRadioButtonsSetSelected(this.ptr, index)
END SetSelected;

(** Set Combobox OnSelected callback. *)
PROCEDURE (VAR this : RadioButtons) OnSelected*(callback: Callback);
BEGIN uiRadioButtonsOnSelected(this.ptr,  SYSTEM.ADR(winui_onCallback), callback);
END OnSelected;

(*
    DateTimePicker
*)

(** Initialize DateTimePicker *)
PROCEDURE InitDateTimePicker*(VAR s : DateTimePicker);
VAR ret : ADDRESS;
BEGIN
    ret := uiNewDateTimePicker();
    s.ptr := ret;
END InitDateTimePicker;

(** Initialize DatePicker *)
PROCEDURE InitDatePicker*(VAR s : DateTimePicker);
VAR ret : ADDRESS;
BEGIN
    ret := uiNewDatePicker();
    s.ptr := ret;
END InitDatePicker;

(** Initialize TimePicker *)
PROCEDURE InitTimePicker*(VAR s : DateTimePicker);
VAR ret : ADDRESS;
BEGIN
    ret := uiNewTimePicker();
    s.ptr := ret;
END InitTimePicker;

(** Get datetime value. *)
PROCEDURE (VAR this : DateTimePicker) Time*(VAR time : TM);
BEGIN uiDateTimePickerTime(this.ptr, time)
END Time;

(** Set datetime value. *)
PROCEDURE (VAR this : DateTimePicker) SetTime*(VAR time : TM);
BEGIN uiDateTimePickerSetTime(this.ptr, time)
END SetTime;

(** Set OnChanged callback. *)
PROCEDURE (VAR this : DateTimePicker) OnChanged*(callback: Callback);
BEGIN uiDateTimePickerOnChanged(this.ptr,  SYSTEM.ADR(winui_onCallback), callback);
END OnChanged;

(*
    MultilineEntry
*)

(** Initialize MultilineEntry *)
PROCEDURE InitMultilineEntry*(VAR s : MultilineEntry);
VAR ret : ADDRESS;
BEGIN
    ret := uiNewMultilineEntry();
    s.ptr := ret;
END InitMultilineEntry;

(** Initialize NonWrappingMultilineEntry *)
PROCEDURE InitNonWrappingMultilineEntry*(VAR s : MultilineEntry);
VAR ret : ADDRESS;
BEGIN
    ret := uiNewNonWrappingMultilineEntry();
    s.ptr := ret;
END InitNonWrappingMultilineEntry;

(** Get text lenght. *)
PROCEDURE (VAR this : MultilineEntry) TextLength*(): LENGTH;
VAR adr : ADDRESS;
BEGIN
    adr := uiMultilineEntryText(this.ptr);
    RETURN CStringLength(adr)
END TextLength;

(** Get text. *)
PROCEDURE (VAR this : MultilineEntry) Text*(VAR text : ARRAY OF CHAR);
VAR adr : ADDRESS;
BEGIN
    adr := uiMultilineEntryText(this.ptr);
    IF adr = 0 THEN text[0] := 00X; RETURN END;
    CStringCopy(text, adr)
END Text;

(** Set text. *)
PROCEDURE (VAR this : MultilineEntry) SetText*(text- : ARRAY OF CHAR);
BEGIN uiMultilineEntrySetText(this.ptr, SYSTEM.ADR(text))
END SetText;

(** Append text. *)
PROCEDURE (VAR this : MultilineEntry) Append*(text- : ARRAY OF CHAR);
BEGIN uiMultilineEntryAppend(this.ptr, SYSTEM.ADR(text))
END Append;

(** Set OnChanged callback. *)
PROCEDURE (VAR this : MultilineEntry) OnChanged*(callback: Callback);
BEGIN uiMultilineEntryOnChanged(this.ptr,  SYSTEM.ADR(winui_onCallback), callback);
END OnChanged;

(** Returns TRUE if the entry is readonly *)
PROCEDURE (VAR this : MultilineEntry) IsReadOnly*(): BOOLEAN;
BEGIN RETURN uiMultilineEntryReadOnly(this.ptr) # 0;
END IsReadOnly;

(** Set entry readonly flag *)
PROCEDURE (VAR this : MultilineEntry) SetReadOnly*(readOnly : BOOLEAN);
BEGIN uiMultilineEntrySetReadOnly(this.ptr, INTEGER(readOnly));
END SetReadOnly;

(*
    MenuItem
*)

(** Enable. *)
PROCEDURE (VAR this : MenuItem) Enable*();
BEGIN uiMenuItemEnable(this.ptr)
END Enable;

(** Disable. *)
PROCEDURE (VAR this : MenuItem) Disable*();
BEGIN uiMenuItemDisable(this.ptr)
END Disable;

(** Set checkbox OnClicked callback. *)
PROCEDURE (VAR this : MenuItem) OnClicked*(callback: Callback);
BEGIN uiMenuItemOnClicked(this.ptr,  SYSTEM.ADR(winui_onCallback), callback);
END OnClicked;

(** Returns TRUE if item is checked *)
PROCEDURE (VAR this : MenuItem) IsChecked*(): BOOLEAN;
BEGIN RETURN uiMenuItemChecked(this.ptr) # 0;
END IsChecked;

(** Set checked flag *)
PROCEDURE (VAR this : MenuItem) SetChecked*(checked : BOOLEAN);
BEGIN uiMenuItemSetChecked(this.ptr, INTEGER(checked));
END SetChecked;

(*
    Menu
*)

(** Initialize Menu *)
PROCEDURE InitMenu*(VAR s : Menu; name- : ARRAY OF CHAR);
VAR ret : ADDRESS;
BEGIN
    ret := uiNewMenu(SYSTEM.ADR(name[0]));
    s.ptr := ret;
END InitMenu;

(** Append item *)
PROCEDURE  (VAR this : MenuItem) AppendItem*(VAR m : MenuItem; name- : ARRAY OF CHAR);
VAR ret : ADDRESS;
BEGIN
    ret := uiMenuAppendItem(this.ptr, SYSTEM.ADR(name[0]));
    m.ptr := ret;
END AppendItem;

(** Append check item *)
PROCEDURE  (VAR this : MenuItem) AppendCheckItem*(VAR m : MenuItem; name- : ARRAY OF CHAR);
VAR ret : ADDRESS;
BEGIN
    ret := uiMenuAppendCheckItem(this.ptr, SYSTEM.ADR(name[0]));
    m.ptr := ret;
END AppendCheckItem;

(** Append quit item *)
PROCEDURE  (VAR this : MenuItem) AppendQuitItem*(VAR m : MenuItem);
VAR ret : ADDRESS;
BEGIN
    ret := uiMenuAppendQuitItem(this.ptr);
    m.ptr := ret;
END AppendQuitItem;

(** Append preferences item *)
PROCEDURE  (VAR this : MenuItem) AppendPreferencesItem*(VAR m : MenuItem);
VAR ret : ADDRESS;
BEGIN
    ret := uiMenuAppendPreferencesItem(this.ptr);
    m.ptr := ret;
END AppendPreferencesItem;

(** Append about item *)
PROCEDURE  (VAR this : MenuItem) AppendAboutItem*(VAR m : MenuItem);
VAR ret : ADDRESS;
BEGIN
    ret := uiMenuAppendAboutItem(this.ptr);
    m.ptr := ret;
END AppendAboutItem;

(** Append separator item *)
PROCEDURE (VAR this : MenuItem) AppendSeparator*();
BEGIN uiMenuAppendSeparator(this.ptr)
END AppendSeparator;

(*
    ColorButton
*)

(** Initialize ColorButton *)
PROCEDURE InitColorButton*(VAR s : ColorButton);
VAR ret : ADDRESS;
BEGIN
    ret := uiNewColorButton();
    s.ptr := ret;
END InitColorButton;

(** Get color. *)
PROCEDURE (VAR this : ColorButton) Color*(VAR r, g, b, a : REAL);
BEGIN uiColorButtonColor(this.ptr, SYSTEM.ADR(r), SYSTEM.ADR(g), SYSTEM.ADR(b), SYSTEM.ADR(a))
END Color;

(** GSt color. *)
PROCEDURE (VAR this : ColorButton) SetColor*(r, g, b, a : REAL);
BEGIN uiColorButtonSetColor(this.ptr, r, g, b, a)
END SetColor;

(** Set OnChanged callback. *)
PROCEDURE (VAR this : ColorButton) OnChanged*(callback: Callback);
BEGIN uiColorButtonOnChanged(this.ptr,  SYSTEM.ADR(winui_onCallback), callback);
END OnChanged;

(*
    Form
*)

(** Initialize Form *)
PROCEDURE InitForm*(VAR s : Form);
BEGIN s.ptr := uiNewForm()
END InitForm;

(** Append control *)
PROCEDURE (VAR this : Form) Append*(child- : Control; name- : ARRAY OF CHAR; stretchy : INTEGER);
BEGIN
    uiFormAppend(this.ptr, SYSTEM.ADR(name[0]), child.ptr, stretchy);
END Append;

(** Get number of children. *)
PROCEDURE (VAR this : Form) NumChildren*(): INTEGER;
BEGIN RETURN uiFormNumChildren(this.ptr);
END NumChildren;

(** Removes the control at index. *)
PROCEDURE (VAR this : Form) Delete*(index : INTEGER);
BEGIN uiFormDelete(this.ptr, index);
END Delete;

(** Returns TRUE if the Form is padded *)
PROCEDURE (VAR this : Form) IsPadded*(): BOOLEAN;
BEGIN RETURN uiFormPadded(this.ptr) # 0;
END IsPadded;

(** Set Form padded flag *)
PROCEDURE (VAR this : Form) SetPadded*(padded : BOOLEAN);
BEGIN uiFormSetPadded(this.ptr, INTEGER(padded));
END SetPadded;

(*
    Grid
*)

(** Initialize Grid *)
PROCEDURE InitGrid*(VAR s : Grid);
BEGIN s.ptr := uiNewGrid()
END InitGrid;

(** Append control *)
PROCEDURE (VAR this : Grid) Append*(child- : Control; left, top, xpan, yspan, hexpand, halign, vexpand, valign : INTEGER);
BEGIN
    uiGridAppend(this.ptr, child.ptr, left, top, xpan, yspan, hexpand, halign, vexpand, valign);
END Append;

(** Insert control *)
PROCEDURE (VAR this : Grid) Insert*(control-,  existing-: Control; at, xpan, yspan, hexpand, halign, vexpand, valign : INTEGER);
BEGIN
    uiGridInsertAt(this.ptr, control.ptr, existing.ptr, at, xpan, yspan, hexpand, halign, vexpand, valign);
END Insert;

(** Returns TRUE if the Grid is padded *)
PROCEDURE (VAR this : Grid) IsPadded*(): BOOLEAN;
BEGIN RETURN uiGridPadded(this.ptr) # 0;
END IsPadded;

(** Set Grid padded flag *)
PROCEDURE (VAR this : Grid) SetPadded*(padded : BOOLEAN);
BEGIN uiGridSetPadded(this.ptr, INTEGER(padded));
END SetPadded;

END UI.