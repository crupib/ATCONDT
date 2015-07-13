#COMPILE EXE
#CONSOLE OFF
#DIM ALL        '   This is helpful to prevent errors in coding

' --------------------
#INCLUDE ".\includes\ezgui50.inc"                          ' EZGUI Include file for Declares
' --------------------
#RESOURCE ".\rcdata\scanctrl.pbr"

' -------------------------------------------------------------------------------------
%RealBackEnd   =    1         ' set this to 1 when using the real backend include file
' -------------------------------------------------------------------------------------
DECLARE SUB SETUPFORM_XSTART_Events(MyID&, CMsg&, CVal&, Cancel&)
DECLARE SUB SETUPFORM_XEND_Events(MyID&, CMsg&, CVal&, Cancel&)
DECLARE SUB SETUPFORM_YSTART_Events(MyID&, CMsg&, CVal&, Cancel&)
DECLARE SUB SETUPFORM_YEND_Events(MyID&, CMsg&, CVal&, Cancel&)
DECLARE SUB SETUPFORM_XINDEX_Events(MyID&, CMsg&, CVal&, Cancel&)
DECLARE SUB SETUPFORM_YINDEX_Events(MyID&, CMsg&, CVal&, Cancel&)
DECLARE SUB SETUPFORM_XSPEED_Events(MyID&, CMsg&, CVal&, Cancel&)
DECLARE SUB SETUPFORM_YSPEED_Events(MyID&, CMsg&, CVal&, Cancel&)
DECLARE SUB SETUPFORM_XPOS_Events(MyID&, CMsg&, CVal&, Cancel&)
DECLARE SUB SETUPFORM_YPOS_Events(MyID&, CMsg&, CVal&, Cancel&)
DECLARE SUB SETUPFORM_XCTIN_Events(MyID&, CMsg&, CVal&, Cancel&)
DECLARE SUB SETUPFORM_YCTIN_Events(MyID&, CMsg&, CVal&, Cancel&)
DECLARE SUB SETUPFORM_XPLUSMIN_Events(MyID&, CMsg&, CVal&, Cancel&)
DECLARE SUB SETUPFORM_YPLUSMIN_Events(MyID&, CMsg&, CVal&, Cancel&)
DECLARE SUB SETUPFORM_INDEX_Events(MyID&, CMsg&, CVal&, Cancel&)
DECLARE SUB SETUPFORM_IDXHL_Events(MyID&, CMsg&, CVal&, Cancel&)
DECLARE SUB SETUPFORM_XONOFF_Events(MyID&, CMsg&, CVal&, Cancel&)
DECLARE SUB SETUPFORM_YONOFF_Events(MyID&, CMsg&, CVal&, Cancel&)
DECLARE SUB SETUPFORM_AUTOHD_Events(MyID&, CMsg&, CVal&, Cancel&)
DECLARE SUB SETUPFORM_DUALRAS_Events(MyID&, CMsg&, CVal&, Cancel&)
DECLARE SUB SETUPFORM_OVERLAP_Events(MyID&, CMsg&, CVal&, Cancel&)
DECLARE SUB SETUPFORM_APOS_Events(MyID&, CMsg&, CVal&, Cancel&)
DECLARE SUB SETUPFORM_ACTIN_Events(MyID&, CMsg&, CVal&, Cancel&)
DECLARE SUB SETUPFORM_CALBTN_Events(MyID&, CMsg&, CVal&, Cancel&)
' -------------------------------------------------------------------------------------
DECLARE FUNCTION Main_Initialize(BYVAL VerNum&) AS LONG
DECLARE SUB InitGraphicStack(BYVAL MaxTasks&)
DECLARE SUB InitOtherGlobals()
DECLARE SUB SetUserInput(BYVAL CID&, BYVAL CMsg&, BYVAL CVal&)
DECLARE SUB CopyCanvas()

' *************************************************************************************
'                               GRAPHIC Form
' *************************************************************************************
DECLARE SUB EZ_GRAPHIC_Display(BYVAL FParent$)
DECLARE SUB EZ_GRAPHIC_Design()
DECLARE SUB EZ_GRAPHIC_ParseEvents(CID&, CMsg&, CVal&, Cancel&)
DECLARE SUB GRAPHIC_Events(CID&, CMsg&, CVal&, Cancel&)
' ------------------------------------------------

%GRAPHIC_BACKCANVAS         = 100
%GRAPHIC_FRONTCANVAS         = 105

DECLARE SUB GRAPHIC_BACKCANVAS_Draw(BYVAL FMode&)
DECLARE SUB GRAPHIC_FRONTCANVAS_Events(MyID&, CMsg&, CVal&, Cancel&)
DECLARE SUB SetBitmapSize(BYVAL N&)

' *************************************************************************************
'                               SPLASH Form
' *************************************************************************************
DECLARE SUB EZ_SPLASH_Display(BYVAL FParent$)
DECLARE SUB EZ_SPLASH_Design()
DECLARE SUB EZ_SPLASH_ParseEvents(CID&, CMsg&, CVal&, Cancel&)
DECLARE SUB SPLASH_Events(CID&, CMsg&, CVal&, Cancel&)
DECLARE SUB SPLASH_TimerEvents(BYVAL FormName$, BYVAL CID&, BYVAL CMsg&, CVal&, Cancel&)
' ------------------------------------------------
%SPLASH_Timer_ID         = 3
' -------------------------------
%SPLASH_LABELAPPNAME       = 100
%SPLASH_LABELAPPINFO       = 105
' *************************************************************************************
'                              INPUTBOX Form
' *************************************************************************************
DECLARE SUB EZ_INPUTBOX_Display(BYVAL FParent$)
DECLARE SUB EZ_INPUTBOX_Design()
DECLARE SUB EZ_INPUTBOX_ParseEvents(CID&, CMsg&, CVal&, Cancel&)
' ------------------------------------------------
%INPUTBOX_LABELDESCRIPTION   = 100
%INPUTBOX_TEXTINPUTDATA      = 105
%INPUTBOX_BUTTONAPPLY        = 110
%INPUTBOX_BUTTONCANCEL       = 115
' *************************************************************************************
'                               MAIN Form
' *************************************************************************************
DECLARE SUB EZ_MAIN_Display(BYVAL FParent$)
DECLARE SUB EZ_MAIN_Design()
DECLARE SUB EZ_MAIN_ParseEvents(CID&, CMsg&, CVal&, Cancel&)
DECLARE SUB MAIN_CANVASJOGCONTROL_Draw(BYVAL FMode&)
DECLARE SUB MAIN_MAINCANVAS_Draw(BYVAL FMode&)
DECLARE SUB MAIN_MAINCANVAS_Events(MyID&, CMsg&, CVal&, Cancel&)
' ----------------------------------------------------------
%MAIN_FILEMENU                               = 9000
%MAIN_FILE1                                  = 9005
GLOBAL App_MAIN_FILE_Count&
%MAIN_EXITAPP                                = 9099
%MAIN_SETUPMENU                              = 9100
%MAIN_SETUP1                                 = 9105
GLOBAL App_MAIN_SETUP_Count&
%MAIN_WINMENU                                = 9200
%MAIN_WINDOW1                                = 9205
GLOBAL App_MAIN_WINDOW_Count&
%MAIN_ABOUTMENU                              = 9300
%MAIN_ABOUTBOX                               = 9305
' ----------------------------------------------------------
%MAIN_TEXTXPOS           = 100
%MAIN_BUTTONXPOS         = 105
%MAIN_BUTTONXONOFF       = 110
%MAIN_TEXTYPOS           = 115
%MAIN_BUTTONYPOS         = 120
%MAIN_BUTTONYONOFF       = 125
%MAIN_TEXTRPOS           = 130
%MAIN_BUTTONRPOS         = 135
%MAIN_BUTTONRONOFF       = 140
%MAIN_BUTTONPOLAR        = 145
%MAIN_BUTTONCARTESIAN    = 150
%MAIN_BUTTONALLPOS       = 155
%MAIN_BUTTONALLOFF       = 160
%MAIN_BUTTONALLON        = 165
%MAIN_BUTTONGOSCAN       = 170
%MAIN_BUTTONEXTRASCAN    = 175
%MAIN_BUTTONSTOPSCAN     = 180
%MAIN_BUTTONJOGYPLUS     = 185
%MAIN_BUTTONJOGXMINUS    = 190
%MAIN_BUTTONJOGXPLUS     = 195
%MAIN_BUTTONJOGYMINUS    = 200
%MAIN_BUTTONJOGRPLUS     = 205
%MAIN_BUTTONJOGRMINUS    = 210
%MAIN_CANVASJOGCONTROL   = 215
%MAIN_TRACKBARJOGRATE    = 220
%MAIN_TEXTJOGRATE        = 225
%MAIN_BUTTONJOGCONT      = 230
%MAIN_BUTTONJOGSTEP      = 235
%MAIN_BUTTONEXTRA        = 240     ' first extra button ID (18 buttons total)
%MAIN_MAINCANVAS         = 330
%MAIN_LABELSTATUS        = 335
%MAIN_LABELXPOS          = 340
%MAIN_LABELYPOS          = 345
%MAIN_LABELRPOS          = 350
%MAIN_LABELCOORSYS       = 355
%MAIN_LABEL1             = 360
%MAIN_LABEL2             = 365
%MAIN_LABEL3             = 370
%MAIN_LABELJOGRATE       = 375
%MAIN_FakeID             = 499

'
%SETUPFORM_XSTART             = 10000
%SETUPFORM_LABELXSTART        = 10005
%SETUPFORM_LABELXEND          = 10010
%SETUPFORM_LABELYSTART        = 10015
%SETUPFORM_LABELYEND          = 10020
%SETUPFORM_LABELXINDEX        = 10025
%SETUPFORM_LABELYINDEX        = 10030
%SETUPFORM_LABELXSPEED        = 10035
%SETUPFORM_LABELYSPEED        = 10040
%SETUPFORM_LABELXPOS          = 10045
%SETUPFORM_LABELYPOS          = 10050
%SETUPFORM_LABELXCTIN         = 10055
%SETUPFORM_LABELYCTIN         = 10060
%SETUPFORM_LABELXPLUSMIN      = 10065
%SETUPFORM_LABELYPLUSMIN      = 10070
%SETUPFORM_LABELIDXHL         = 10075
%SETUPFORM_LABELXONOFF        = 10080
%SETUPFORM_LABELYONOFF        = 10085
%SETUPFORM_LABELAUTOHD        = 10090
%SETUPFORM_LABELDUALRAS       = 10095
%SETUPFORM_LABELOVERLAP       = 20000
%SETUPFORM_LABELAPOS          = 20005
%SETUPFORM_LABELACTIN         = 20010
%SETUPFORM_XEND               = 20015
%SETUPFORM_YSTART             = 20020
%SETUPFORM_YEND               = 20025
%SETUPFORM_XINDEX             = 20030
%SETUPFORM_YINDEX             = 20035
%SETUPFORM_XSPEED             = 20040
%SETUPFORM_YSPEED             = 20045
%SETUPFORM_XPOS               = 20050
%SETUPFORM_YPOS               = 20055
%SETUPFORM_XCTIN              = 20060
%SETUPFORM_YCTIN              = 20065
%SETUPFORM_XPLUSMIN           = 20070
%SETUPFORM_YPLUSMIN           = 20075
%SETUPFORM_INDEX              = 20080
%SETUPFORM_IDXHL              = 20085
%SETUPFORM_XONOFF             = 20090
%SETUPFORM_YONOFF             = 20095
%SETUPFORM_AUTOHD             = 30000
%SETUPFORM_DUALRAS            = 30005
%SETUPFORM_OVERLAP            = 30000
%SETUPFORM_APOS               = 30015
%SETUPFORM_ACTIN              = 30020
%SETUPFORM_LABELINDEX         = 30025
%SETUPFORM_CALBTN             = 30030
%SETUPFORM_Thread1_ID            =40000
' --------------------
#INCLUDE ".\includes\ezwmain50.inc"                          ' EZGUI Include file for WinMain
' --------------------
GLOBAL File_Name AS STRING


SUB EZ_Main(VerNum&)     ' (PROTECTED)
     EZ_Reg 6071, 570416930   ' Bills Registration codes for now
     EZ_DefImageFolder "Graphics"
     EZ_AllowCommandEvents  0
     EZ_AllowMouseMoveEvents 1
     EZ_AllowCursorEvents 1
     EZ_AllowKeyEvents 2
     EZ_DefFont 6, "Arial Narrow", 10, "BV"
     EZ_DefFont 7, "Arial Narrow", 12, "BV"
     EZ_DefFont 8, "Arial Narrow", 10, "L+V"
     EZ_DefFont 9, "Arial Narrow", 20, "BV"
     EZ_DefFont 10, "Courier New", 12, "BF"
     EZ_DefFont 11, "Arial", 14, "BV"
     EZ_DefSystemColor 32, 4
     EZ_DefSystemColor 33, 5
     EZ_DefSystemColor 34, 15
     EZ_DefSystemColor 35, 24
     EZ_DefColorL 36, &H00FFE2C6
     EZ_DefColorL 37, &H00F0E1FF
     EZ_DefColorL 38, &H00E8D0D0
     EZ_DefColorL 39, &H00FFC488
     EZ_DefColorL 40, &H00BFBFFF
     EZ_DefColorL 41, &H00D9FFD9
     EZ_DefColorL 42, &H0000E800
     EZ_DefColorL 43, &H007D7DFF
     EZ_DefColorL 99, &H00111111
     LOCAL I&
     FOR I& = 0 TO 31    ' initialize colors
          EZ_Color I&,I&
     NEXT I&
     FOR I& = -57 TO -1    ' initialize patterns
          EZ_Color 0,I&
     NEXT I&
     IF Main_Initialize(VerNum&) THEN
          EZ_SPLASH_Display ""
     END IF
END SUB


' -------------------------------------------------------------------------------------

SUB EZ_DesignWindow(FormName$)     ' All calls must be forwarded for each form from here
     SELECT CASE FormName$
          CASE "MAIN"
               EZ_MAIN_Design
          CASE "GRAPHIC"
               EZ_GRAPHIC_Design
          CASE "SPLASH"
               EZ_SPLASH_Design
          CASE "INPUTBOX"
               EZ_INPUTBOX_Design
          CASE "SETUPFORM"
               EZ_SETUPFORM_Design
          CASE ELSE
     END SELECT
END SUB

' -------------------------------------------------------------------------------------

SUB EZ_Events(FormName$, CID&, CMsg&, CVal&, Cancel&)     ' All calls must be forwarded for each form from here
     LOCAL TempID&
     SELECT CASE CMsg&
          CASE %EZ_KeyDown TO %EZ_KeyPress
               IF FormName$ = "MAIN" THEN
                    SELECT CASE CID&
                         CASE %MAIN_FILE1 TO %MAIN_FILE1+App_MAIN_FILE_Count&-1
                              TempID& = 50+CID&-%MAIN_FILE1+1
                         CASE %MAIN_SETUP1 TO %MAIN_SETUP1+App_MAIN_SETUP_Count&-1
                              TempID& = 60+CID&-%MAIN_SETUP1+1
                         CASE %MAIN_WINDOW1 TO %MAIN_WINDOW1+App_MAIN_WINDOW_Count&-1
                              TempID& = 70+CID&-%MAIN_WINDOW1+1
                         CASE  %MAIN_BUTTONEXTRA TO %MAIN_BUTTONEXTRA+17
                              TempID& = CID&-%MAIN_BUTTONEXTRA+1       ' buttons 1 to 18
                         CASE ELSE
                              TempID& = CID&
                    END SELECT
                    SetUserInput TempID&, CMsg&, CVal&
               END IF
          CASE %EZ_SysKeyDown TO %EZ_SysKeyPress
               IF FormName$ = "MAIN" THEN
                    SELECT CASE CID&
                         CASE %MAIN_FILE1 TO %MAIN_FILE1+App_MAIN_FILE_Count&-1
                              TempID& = 50+CID&-%MAIN_FILE1+1
                         CASE %MAIN_SETUP1 TO %MAIN_SETUP1+App_MAIN_SETUP_Count&-1
                              TempID& = 60+CID&-%MAIN_SETUP1+1
                         CASE %MAIN_WINDOW1 TO %MAIN_WINDOW1+App_MAIN_WINDOW_Count&-1
                              TempID& = 70+CID&-%MAIN_WINDOW1+1
                         CASE  %MAIN_BUTTONEXTRA TO %MAIN_BUTTONEXTRA+17
                              TempID& = CID&-%MAIN_BUTTONEXTRA+1       ' buttons 1 to 18
                         CASE ELSE
                              TempID& = CID&
                    END SELECT
                    SetUserInput TempID&, CMsg&, CVal&
               END IF
          CASE ELSE
     END SELECT

     SELECT CASE FormName$
          CASE "MAIN"
               EZ_MAIN_ParseEvents CID&, CMsg&, CVal&, Cancel&

          CASE "GRAPHIC"
               EZ_GRAPHIC_ParseEvents CID&, CMsg&, CVal&, Cancel&
          CASE "SPLASH"
               EZ_SPLASH_ParseEvents CID&, CMsg&, CVal&, Cancel&
          CASE "INPUTBOX"
               EZ_INPUTBOX_ParseEvents CID&, CMsg&, CVal&, Cancel&
           CASE "SETUPFORM"
               EZ_SETUPFORM_ParseEvents CID&, CMsg&, CVal&, Cancel&
          CASE ELSE
     END SELECT
END SUB

GLOBAL App_AspectRatio!

%App_MaxWidth       = 1920
%App_MaxHeight      = 1080
GLOBAL App_Picture1$
GLOBAL App_PictureAddr&

' -------------------------------------------------------------------------------------

FUNCTION Main_Initialize(BYVAL VerNum&) AS LONG
     LOCAL RV&
     EZ_InitSpriteBuffers 100, EZ_CX(%App_MaxWidth), EZ_CY(%App_MaxHeight)
     App_Picture1$ = EZ_CreateDIBPicture(32, %App_MaxWidth, %App_MaxHeight, "", App_PictureAddr&)
     InitGraphicStack 100
     InitOtherGlobals
     RV&=1
     FUNCTION=RV&
END FUNCTION

SUB AppMsgBox(BYVAL T$)
     EZ_MsgBox "Main", T$, "",""
END SUB

SUB AppWarningBox(BYVAL T$)
     EZ_MsgBox "Main", T$+"{S}", "Warning!",""
END SUB

FUNCTION AppQuestionBox(BYVAL T$, BYVAL BProp$) AS LONG
     FUNCTION = EZ_MsgBox ("Main", T$+"{?}", "",BProp$)
END FUNCTION


$NumFieldFormat = "###.###"


FUNCTION GUIDoubleToStr(BYVAL V AS DOUBLE) AS STRING
     LOCAL RV$
     IF V<0# THEN
          RV$=FORMAT$(ABS(V), $NumFieldFormat)
          RV$="-"+RIGHT$("       "+RV$,7)
     ELSE
          RV$=FORMAT$(V, $NumFieldFormat)
          RV$=" "+RIGHT$("       "+RV$,7)
     END IF
     FUNCTION=RV$
END FUNCTION


' *************************************************************************************
'                           SPLASH Form code
' *************************************************************************************

SUB EZ_SPLASH_Display(BYVAL FParent$)
     LOCAL PN$
     PN$=EZ_LoadPicture("splash.bmp")
     EZ_ShapeFormToPicture PN$, -1
     EZ_Color -1, -1
     EZ_Form "SPLASH", FParent$, "", 0, 0, 63.75, 24.875, "CS"
     EZ_FreeImage PN$
END SUB

SUB EZ_SPLASH_Design()
     LOCAL CText$
     EZ_Color 15, 15
     EZ_UseFont 9
     EZ_Label %SPLASH_LABELAPPNAME, 12.25, 6.5, 40.5, 6, "Atco Scanner App 2015", "^CI"
     ' -----------------------------------------------
     EZ_Color 15, 15
     EZ_UseFont 7
     EZ_Label %SPLASH_LABELAPPINFO, 12.25, 13.125, 40.5, 6, "Copyright 2015", "^CI"
     ' -----------------------------------------------
END SUB

SUB EZ_SPLASH_ParseEvents(CID&, CMsg&, CVal&, Cancel&)     ' (PROTECTED)
     SELECT CASE CID&
          CASE %EZ_Window
               SPLASH_Events CID&, CMsg&, CVal&, Cancel&
               IF CMsg&=%EZ_LButtonDown THEN
                    EZ_DragForm "SPLASH"
               END IF
               IF CMsg&=%EZ_Started OR CMsg&=%EZ_Close THEN
                    SPLASH_TimerEvents "SPLASH", %SPLASH_Timer_ID, CMsg&, CVal&, Cancel&
               END IF
          CASE %SPLASH_Timer_ID
               SPLASH_TimerEvents "SPLASH", CID&, CMsg&, CVal&, Cancel&
          CASE ELSE
               SPLASH_Events CID&, CMsg&, CVal&, Cancel&
     END SELECT
END SUB

SUB SPLASH_Events(CID&, CMsg&, CVal&, Cancel&)
     SELECT CASE CID&
          CASE %EZ_Window
               SELECT CASE CMsg&
                    CASE %EZ_Loading
                    CASE %EZ_Loaded
                    CASE %EZ_Started
                    CASE %EZ_Close
                    CASE ELSE
               END SELECT
          CASE ELSE
     END SELECT
END SUB

SUB SPLASH_TimerEvents(BYVAL FormName$, BYVAL CID&, BYVAL CMsg&, CVal&, Cancel&)
     LOCAL TM!
     STATIC TFlag&
     SELECT CASE CMsg&
          CASE %EZ_Timer          ' Timer Event !
               EZ_StopTimer FormName$, CID&
               TFlag&=0
               EZ_MAIN_Display ""
               EZ_UnloadForm "Splash"
          CASE %EZ_Started        ' Start Timer !
               TM!=5.0            ' Timer delay in seconds
               EZ_StartTimer FormName$, CID&, TM!
               TFlag&=1
          CASE %EZ_Close          ' Terminate Timer when form closes !
               IF TFlag&=1 THEN
                    EZ_StopTimer FormName$, CID&
               END IF
          CASE ELSE
     END SELECT
END SUB

' *************************************************************************************
'                             INPUTBOX Form code
' *************************************************************************************
GLOBAL App_InputTitle$
GLOBAL App_InputDesc$
GLOBAL App_InputValue$
GLOBAL App_InputMask$
GLOBAL App_InputFont&
GLOBAL App_InputCaretPos&

FUNCTION ShowInputBox(BYVAL IDesc$, BYVAL IValue$) AS STRING
     App_InputTitle$=""
     App_InputDesc$=IDesc$
     App_InputValue$=IValue$
     EZ_INPUTBOX_Display "MAIN"
     FUNCTION=App_InputValue$
END FUNCTION

SUB EZ_INPUTBOX_Display(BYVAL FParent$)     ' (PROTECTED)
     EZ_Color -1, -1
     EZ_Form "INPUTBOX", FParent$, App_InputTitle$, 0, 0, 50, 10, "CRZM"
END SUB

SUB EZ_INPUTBOX_Design()     ' (PROTECTED)
     LOCAL CText$
     EZ_Color-1,-1
     EZ_UseFont 4
     EZ_UseAutoSize "VH"
     EZ_Label %INPUTBOX_LABELDESCRIPTION, .75, .625, 48.25, 1.25, App_InputDesc$, "C"
     ' -----------------------------------------------
     EZ_Color-1,-1
     EZ_UseFont App_InputFont&
     EZ_UseAutoSize "VH"
     EZ_SubClass 2
     EZ_Text %INPUTBOX_TEXTINPUTDATA, .5, 3, 49, 1.875, App_InputValue$, "CEST"
     EZ_SubClass 0
     ' -----------------------------------------------
     EZ_Color-1,-1
     EZ_UseFont 4
     EZ_UseAutoSize "VH"
     EZ_Button %INPUTBOX_BUTTONAPPLY, 30.25, 5.75, 18, 3.5, "Apply", "T"
     ' -----------------------------------------------
     EZ_Color-1,-1
     EZ_UseFont 4
     EZ_UseAutoSize "VH"
     EZ_Button %INPUTBOX_BUTTONCANCEL, 1.75, 7.375, 18, 1.875, "Cancel", "T"
     ' -----------------------------------------------
END SUB


SUB EZ_INPUTBOX_ParseEvents(CID&, CMsg&, CVal&, Cancel&)     ' (PROTECTED)
     STATIC IValue$
     SELECT CASE CID&
          CASE %EZ_Window
               SELECT CASE CMsg&
                    CASE %EZ_Loading
                    CASE %EZ_Loaded
                         IValue$=App_InputValue$
                    CASE %EZ_Started
                    CASE %EZ_Close
                    CASE %EZ_NoAutoSize
                         Cancel&=1 ' turns ON autosize for this form
                    CASE ELSE
               END SELECT
          CASE %INPUTBOX_TEXTINPUTDATA
               SELECT CASE CMsg&
                    CASE %EZ_Change
                         IValue$=EZ_GetText("INPUTBOX", CID&)
                    CASE %EZ_EditSetSel
                         LOCAL SMin&,SMax&
                         EZ_GetSelVal CVal&, SMin&, SMax&
                         SMin&=App_InputCaretPos&
                         SMax&=App_InputCaretPos&
                         EZ_SetSelVal CVal&, SMin&, SMax&
                    CASE ELSE
               END SELECT
          CASE %INPUTBOX_BUTTONAPPLY
               SELECT CASE CMsg&
                    CASE %EZ_Click
                         App_InputValue$=IValue$
                         IValue$=""
                         EZ_UnloadForm "INPUTBOX"
               END SELECT
          CASE %INPUTBOX_BUTTONCANCEL
               SELECT CASE CMsg&
                    CASE %EZ_Click
                         IValue$=""
                         EZ_UnloadForm "INPUTBOX"
               END SELECT
          CASE ELSE
     END SELECT
END SUB
' *************************************************************************************
'<<BEGINFORM>> "SETUPFORM"


' ======================================
' [PROTECTED CODE]         Do NOT Edit !
' ======================================

SUB EZ_SETUPFORM_Display(BYVAL FParent$)     ' (PROTECTED)
     EZ_Color -1, -1
     EZ_AllowLoadingEvent 2
     EZ_Form "SETUPFORM", FParent$, "MCU Settings", 0, 0, 106, 46, "CRZ"
END SUB

SUB EZ_SETUPFORM_Design()     ' (PROTECTED)
     LOCAL CText$
     EZ_Color-1,-1
     EZ_UseFont 4
     EZ_AllowLoadingEvent 2
     EZ_UseAutoSize "VH"
     EZ_SubClass 2
     EZ_Text %SETUPFORM_XSTART, 17, 2, 15, 1, "", "EST"
     EZ_SubClass 0
     ' -----------------------------------------------
     EZ_Color 0, 11
     EZ_UseFont 4
     EZ_UseAutoSize "VH"
     EZ_Label %SETUPFORM_LABELXSTART, 2, 2, 12, 1, "X Start", "C"
     ' -----------------------------------------------
     EZ_Color 0, 11
     EZ_UseFont 4
     EZ_UseAutoSize "VH"
     EZ_Label %SETUPFORM_LABELXEND, 2, 4, 12, 1, "X End", "C"
     ' -----------------------------------------------
     EZ_Color 0, 11
     EZ_UseFont 4
     EZ_UseAutoSize "VH"
     EZ_Label %SETUPFORM_LABELYSTART, 2, 6, 12, 1, "Y Start", "C"
     ' -----------------------------------------------
     EZ_Color 0, 11
     EZ_UseFont 4
     EZ_UseAutoSize "VH"
     EZ_Label %SETUPFORM_LABELYEND, 2, 8, 12, 1, "Y End", "C"
     ' -----------------------------------------------
     EZ_Color 0, 11
     EZ_UseFont 4
     EZ_UseAutoSize "VH"
     EZ_Label %SETUPFORM_LABELXINDEX, 2, 10, 12, 1, "X Index", "C"
     ' -----------------------------------------------
     EZ_Color 0, 11
     EZ_UseFont 4
     EZ_UseAutoSize "VH"
     EZ_Label %SETUPFORM_LABELYINDEX, 2, 12, 12, 1, "Y Index", "C"
     ' -----------------------------------------------
     EZ_Color 0, 11
     EZ_UseFont 4
     EZ_UseAutoSize "VH"
     EZ_Label %SETUPFORM_LABELXSPEED, 2, 14, 12, 1, "X Speed", "C"
     ' -----------------------------------------------
     EZ_Color 0, 11
     EZ_UseFont 4
     EZ_UseAutoSize "VH"
     EZ_Label %SETUPFORM_LABELYSPEED, 2, 16, 12, 1, "Y Speed", "C"
     ' -----------------------------------------------
     EZ_Color 0, 11
     EZ_UseFont 4
     EZ_UseAutoSize "VH"
     EZ_Label %SETUPFORM_LABELXPOS, 34.375, 1.9375, 12, 1, "X POS", "C"
     ' -----------------------------------------------
     EZ_Color 0, 11
     EZ_UseFont 4
     EZ_UseAutoSize "VH"
     EZ_Label %SETUPFORM_LABELYPOS, 34.375, 3.9375, 12, 1, "Y POS", "C"
     ' -----------------------------------------------
     EZ_Color 0, 11
     EZ_UseFont 4
     EZ_UseAutoSize "VH"
     EZ_Label %SETUPFORM_LABELXCTIN, 34.375, 5.9375, 12, 1, "X CT/IN", "C"
     ' -----------------------------------------------
     EZ_Color 0, 11
     EZ_UseFont 4
     EZ_UseAutoSize "VH"
     EZ_Label %SETUPFORM_LABELYCTIN, 34.375, 7.9375, 12, 1, "Y  CT/IN", "C"
     ' -----------------------------------------------
     EZ_Color 0, 11
     EZ_UseFont 4
     EZ_UseAutoSize "VH"
     EZ_Label %SETUPFORM_LABELXPLUSMIN, 34.375, 9.9375, 12, 1, "X +/-", "C"
     ' -----------------------------------------------
     EZ_Color 0, 11
     EZ_UseFont 4
     EZ_UseAutoSize "VH"
     EZ_Label %SETUPFORM_LABELYPLUSMIN, 34.375, 11.9375, 12, 1, "Y +/-", "C"
     ' -----------------------------------------------
     EZ_Color 0, 11
     EZ_UseFont 4
     EZ_UseAutoSize "VH"
     EZ_Label %SETUPFORM_LABELIDXHL, 34.375, 15.9375, 12, 1, "IDX H/L", "C"
     ' -----------------------------------------------
     EZ_Color 0, 11
     EZ_UseFont 4
     EZ_UseAutoSize "VH"
     EZ_Label %SETUPFORM_LABELXONOFF, 66.25, 2, 12, 1, "X ON/OFF", "C"
     ' -----------------------------------------------
     EZ_Color 0, 11
     EZ_UseFont 4
     EZ_UseAutoSize "VH"
     EZ_Label %SETUPFORM_LABELYONOFF, 66.25, 4, 12, 1, "Y ON/OFF", "C"
     ' -----------------------------------------------
     EZ_Color 0, 11
     EZ_UseFont 4
     EZ_UseAutoSize "VH"
     EZ_Label %SETUPFORM_LABELAUTOHD, 66.25, 6, 12, 1, "AUTO HD", "C"
     ' -----------------------------------------------
     EZ_Color 0, 11
     EZ_UseFont 4
     EZ_UseAutoSize "VH"
     EZ_Label %SETUPFORM_LABELDUALRAS, 66.25, 8, 12, 1, "DUALRAS", "C"
     ' -----------------------------------------------
     EZ_Color 0, 11
     EZ_UseFont 4
     EZ_UseAutoSize "VH"
     EZ_Label %SETUPFORM_LABELOVERLAP, 66.25, 10, 12, 1, "OVERLAP", "C"
     ' -----------------------------------------------
     EZ_Color 0, 11
     EZ_UseFont 4
     EZ_UseAutoSize "VH"
     EZ_Label %SETUPFORM_LABELAPOS, 66.25, 12, 12, 1, "A POS", "C"
     ' -----------------------------------------------
     EZ_Color 0, 11
     EZ_UseFont 4
     EZ_UseAutoSize "VH"
     EZ_Label %SETUPFORM_LABELACTIN, 66.25, 14, 12, 1, "A CT/IN", "C"
     ' -----------------------------------------------
     EZ_Color-1,-1
     EZ_UseFont 4
     EZ_AllowLoadingEvent 2
     EZ_UseAutoSize "VH"
     EZ_Text %SETUPFORM_XEND, 17, 4, 15, 1, "", "EST"
     ' -----------------------------------------------
     EZ_Color-1,-1
     EZ_UseFont 4
     EZ_AllowLoadingEvent 2
     EZ_UseAutoSize "VH"
     EZ_Text %SETUPFORM_YSTART, 17, 6, 15, 1, "", "EST"
     ' -----------------------------------------------
     EZ_Color-1,-1
     EZ_UseFont 4
     EZ_AllowLoadingEvent 2
     EZ_UseAutoSize "VH"
     EZ_Text %SETUPFORM_YEND, 17, 8, 15, 1, "", "EST"
     ' -----------------------------------------------
     EZ_Color-1,-1
     EZ_UseFont 4
     EZ_AllowLoadingEvent 2
     EZ_UseAutoSize "VH"
     EZ_Text %SETUPFORM_XINDEX, 17, 9.875, 15, 1, "", "EST"
     ' -----------------------------------------------
     EZ_Color-1,-1
     EZ_UseFont 4
     EZ_AllowLoadingEvent 2
     EZ_UseAutoSize "VH"
     EZ_Text %SETUPFORM_YINDEX, 17, 11.875, 15, 1, "", "EST"
     ' -----------------------------------------------
     EZ_Color-1,-1
     EZ_UseFont 4
     EZ_AllowLoadingEvent 2
     EZ_UseAutoSize "VH"
     EZ_Text %SETUPFORM_XSPEED, 17, 13.9375, 15, 1, "", "EST"
     ' -----------------------------------------------
     EZ_Color-1,-1
     EZ_UseFont 4
     EZ_AllowLoadingEvent 2
     EZ_UseAutoSize "VH"
     EZ_Text %SETUPFORM_YSPEED, 17, 15.9375, 15, 1, "", "EST"
     ' -----------------------------------------------
     EZ_Color-1,-1
     EZ_UseFont 4
     EZ_AllowLoadingEvent 2
     EZ_UseAutoSize "VH"
     EZ_Text %SETUPFORM_XPOS, 48.375, 1.9375, 15, 1, "", "EST"
     ' -----------------------------------------------
     EZ_Color-1,-1
     EZ_UseFont 4
     EZ_AllowLoadingEvent 2
     EZ_UseAutoSize "VH"
     EZ_Text %SETUPFORM_YPOS, 48.375, 3.9375, 15, 1, "", "EST"
     ' -----------------------------------------------
     EZ_Color-1,-1
     EZ_UseFont 4
     EZ_AllowLoadingEvent 2
     EZ_UseAutoSize "VH"
     EZ_Text %SETUPFORM_XCTIN, 48.375, 5.9375, 15, 1, "", "EST"
     ' -----------------------------------------------
     EZ_Color-1,-1
     EZ_UseFont 4
     EZ_AllowLoadingEvent 2
     EZ_UseAutoSize "VH"
     EZ_Text %SETUPFORM_YCTIN, 48.375, 7.9375, 15, 1, "", "EST"
     ' -----------------------------------------------
     EZ_Color-1,-1
     EZ_UseFont 4
     EZ_AllowLoadingEvent 2
     EZ_UseAutoSize "VH"
     EZ_Text %SETUPFORM_XPLUSMIN, 48.375, 9.9375, 15, 1, "", "EST"
     ' -----------------------------------------------
     EZ_Color-1,-1
     EZ_UseFont 4
     EZ_AllowLoadingEvent 2
     EZ_UseAutoSize "VH"
     EZ_Text %SETUPFORM_YPLUSMIN, 48.375, 11.9375, 15, 1, "", "EST"
     ' -----------------------------------------------
     EZ_Color-1,-1
     EZ_UseFont 4
     EZ_AllowLoadingEvent 2
     EZ_UseAutoSize "VH"
     EZ_Text %SETUPFORM_INDEX, 48.375, 14, 15, 1, "", "EST"
     ' -----------------------------------------------
     EZ_Color-1,-1
     EZ_UseFont 4
     EZ_AllowLoadingEvent 2
     EZ_UseAutoSize "VH"
     EZ_Text %SETUPFORM_IDXHL, 48.375, 15.9375, 15, 1, "", "EST"
     ' -----------------------------------------------
     EZ_Color-1,-1
     EZ_UseFont 4
     EZ_AllowLoadingEvent 2
     EZ_UseAutoSize "VH"
     EZ_Text %SETUPFORM_XONOFF, 80.25, 2, 15, 1, "", "EST"
     ' -----------------------------------------------
     EZ_Color-1,-1
     EZ_UseFont 4
     EZ_AllowLoadingEvent 2
     EZ_UseAutoSize "VH"
     EZ_Text %SETUPFORM_YONOFF, 80.25, 4, 15, 1, "", "EST"
     ' -----------------------------------------------
     EZ_Color-1,-1
     EZ_UseFont 4
     EZ_AllowLoadingEvent 2
     EZ_UseAutoSize "VH"
     EZ_Text %SETUPFORM_AUTOHD, 80.25, 6, 15, 1, "", "EST"
     ' -----------------------------------------------
     EZ_Color-1,-1
     EZ_UseFont 4
     EZ_AllowLoadingEvent 2
     EZ_UseAutoSize "VH"
     EZ_Text %SETUPFORM_DUALRAS, 80.25, 8, 15, 1, "", "EST"
     ' -----------------------------------------------
     EZ_Color-1,-1
     EZ_UseFont 4
     EZ_AllowLoadingEvent 2
     EZ_UseAutoSize "VH"
     EZ_Text %SETUPFORM_OVERLAP, 80.25, 10, 15, 1, "", "EST"
     ' -----------------------------------------------
     EZ_Color-1,-1
     EZ_UseFont 4
     EZ_AllowLoadingEvent 2
     EZ_UseAutoSize "VH"
     EZ_Text %SETUPFORM_APOS, 80.25, 12, 15, 1, "", "EST"
     ' -----------------------------------------------
     EZ_Color-1,-1
     EZ_UseFont 4
     EZ_AllowLoadingEvent 2
     EZ_UseAutoSize "VH"
     EZ_Text %SETUPFORM_ACTIN, 80.25, 14, 15, 1, "", "EST"
     ' -----------------------------------------------
     EZ_Color 0, 11
     EZ_UseFont 4
     EZ_UseAutoSize "VH"
     EZ_Label %SETUPFORM_LABELINDEX, 34.375, 13.9375, 12, 1, "INDEX", "C"
     ' -----------------------------------------------
     EZ_Color 12, 15
     EZ_UseFont 4
     EZ_ODButton %SETUPFORM_CALBTN, 2, 19, 25, 6, "Calibrate Encoders", "T"
     EZ_SetRegion "SetupForm", %SETUPFORM_CALBTN,-2,0
     ' -----------------------------------------------
END SUB


SUB EZ_SETUPFORM_ParseEvents(CID&, CMsg&, CVal&, Cancel&)     ' (PROTECTED)
     SELECT CASE CID&
          CASE %EZ_Window
               SETUPFORM_Events CID&, CMsg&, CVal&, Cancel&
               IF CMsg&=%EZ_Started OR CMsg&=%EZ_Close THEN
                    SETUPFORM_Thread1Events "SETUPFORM", %SETUPFORM_Thread1_ID, CMsg&, CVal&, Cancel&
               END IF
          CASE %SETUPFORM_Thread1_ID
               SETUPFORM_Thread1Events "SETUPFORM", CID&, CMsg&, CVal&, Cancel&
          CASE  %SETUPFORM_XSTART
               SETUPFORM_XSTART_Events CID&, CMsg&, CVal&, Cancel&
          CASE  %SETUPFORM_XEND
               SETUPFORM_XEND_Events CID&, CMsg&, CVal&, Cancel&
          CASE  %SETUPFORM_YSTART
               SETUPFORM_YSTART_Events CID&, CMsg&, CVal&, Cancel&
          CASE  %SETUPFORM_YEND
               SETUPFORM_YEND_Events CID&, CMsg&, CVal&, Cancel&
          CASE  %SETUPFORM_XINDEX
               SETUPFORM_XINDEX_Events CID&, CMsg&, CVal&, Cancel&
          CASE  %SETUPFORM_YINDEX
               SETUPFORM_YINDEX_Events CID&, CMsg&, CVal&, Cancel&
          CASE  %SETUPFORM_XSPEED
               SETUPFORM_XSPEED_Events CID&, CMsg&, CVal&, Cancel&
          CASE  %SETUPFORM_YSPEED
               SETUPFORM_YSPEED_Events CID&, CMsg&, CVal&, Cancel&
          CASE  %SETUPFORM_XPOS
               SETUPFORM_XPOS_Events CID&, CMsg&, CVal&, Cancel&
          CASE  %SETUPFORM_YPOS
               SETUPFORM_YPOS_Events CID&, CMsg&, CVal&, Cancel&
          CASE  %SETUPFORM_XCTIN
               SETUPFORM_XCTIN_Events CID&, CMsg&, CVal&, Cancel&
          CASE  %SETUPFORM_YCTIN
               SETUPFORM_YCTIN_Events CID&, CMsg&, CVal&, Cancel&
          CASE  %SETUPFORM_XPLUSMIN
               SETUPFORM_XPLUSMIN_Events CID&, CMsg&, CVal&, Cancel&
          CASE  %SETUPFORM_YPLUSMIN
               SETUPFORM_YPLUSMIN_Events CID&, CMsg&, CVal&, Cancel&
          CASE  %SETUPFORM_INDEX
               SETUPFORM_INDEX_Events CID&, CMsg&, CVal&, Cancel&
          CASE  %SETUPFORM_IDXHL
               SETUPFORM_IDXHL_Events CID&, CMsg&, CVal&, Cancel&
          CASE  %SETUPFORM_XONOFF
               SETUPFORM_XONOFF_Events CID&, CMsg&, CVal&, Cancel&
          CASE  %SETUPFORM_YONOFF
               SETUPFORM_YONOFF_Events CID&, CMsg&, CVal&, Cancel&
          CASE  %SETUPFORM_AUTOHD
               SETUPFORM_AUTOHD_Events CID&, CMsg&, CVal&, Cancel&
          CASE  %SETUPFORM_DUALRAS
               SETUPFORM_DUALRAS_Events CID&, CMsg&, CVal&, Cancel&
          CASE  %SETUPFORM_OVERLAP
               SETUPFORM_OVERLAP_Events CID&, CMsg&, CVal&, Cancel&
          CASE  %SETUPFORM_APOS
               SETUPFORM_APOS_Events CID&, CMsg&, CVal&, Cancel&
          CASE  %SETUPFORM_ACTIN
               SETUPFORM_ACTIN_Events CID&, CMsg&, CVal&, Cancel&
          CASE  %SETUPFORM_CALBTN
               SETUPFORM_CALBTN_Events CID&, CMsg&, CVal&, Cancel&
               IF CMsg&=%EZ_OwnerDraw THEN
                    EZ_Draw3DButtonRR "SetupForm", %SETUPFORM_CALBTN, CVal&, 15, 12,  4
               END IF
          CASE ELSE
               SETUPFORM_Events CID&, CMsg&, CVal&, Cancel&
     END SELECT
END SUB

' ======================================
' [USER ACCESSABLE CODE]  You may Edit !
' ======================================

SUB SETUPFORM_Events(CID&, CMsg&, CVal&, Cancel&)
     SELECT CASE CID&
          CASE %EZ_Window
               SELECT CASE CMsg&
                    CASE %EZ_Loading
                    CASE %EZ_Loaded
                    CASE %EZ_Started
                    CASE %EZ_Close
                    CASE ELSE
               END SELECT
          CASE ELSE
     END SELECT
END SUB
' *************************************************************************************
' *************************************************************************************
'                              MAIN Form code
' *************************************************************************************

SUB EZ_MAIN_Display(BYVAL FParent$)     ' (PROTECTED)
     LOCAL hMainMenu&
     ' Main Menu handle automatically stored by EZGUI
     hMainMenu&=EZ_DefMainMenu( %MAIN_FILEMENU, "&File", "")
     EZ_Color -1, -1
     EZ_Form "MAIN", FParent$, "Scan Control Pad 1.0", 0, 0, 119, 41, "^_CZ"
     EZ_SetFormMinMax "MAIN", 119,41, 999,999
END SUB

FUNCTION MakeButtonRedGreen(BYVAL T$, BYVAL BState&) AS STRING
     IF BState&=0 THEN
          FUNCTION=T$+"[[12]]"
     ELSE
          FUNCTION=T$+"[[10]]"
     END IF
END FUNCTION

FUNCTION MakeButtonBlackGray(BYVAL T$, BYVAL BState&) AS STRING
     IF BState&=0 THEN
          FUNCTION=T$+"[[7]]"
     ELSE
          FUNCTION=T$+"[[0]]"
     END IF
END FUNCTION

' ----------------------------
'   Key form design routine
' ----------------------------
SUB EZ_MAIN_Design()
     ' separate each menu item with the | character
     ' FILE menu Items
     DATA "File Open|File Save|File Item 3|File Item 4|File Item 5|File Item 6"
     ' SETUP menu items
     DATA "SETUP Calibration|SETUP Item 2|SETUP Item 3|SETUP Item 4|SETUP Item 5|SETUP Item 6"
     ' WINDOW menu items
     DATA "WINDOW Item 1|WINDOW Item 2|WINDOW Item 3|WINDOW Item 4|WINDOW Item 5|WINDOW Item 6"
     ' extra button in area to left
     ' -------------------------------------------------
     LOCAL CText$, T$, MText$, MCT&, J&, MenuID&, MI&
     LOCAL hMainMenu&, hDropMenu&, hSubMenu&
     hMainMenu&=EZ_GetMenu("MAIN", 0)
     EZ_AddMenuItem hMainMenu&, %MAIN_SETUPMENU, 0, "&Setup", ""
     EZ_AddMenuItem hMainMenu&, %MAIN_WINMENU, 0, "&Window", ""
     EZ_AddMenuItem hMainMenu&, %MAIN_ABOUTMENU, 0, "&About", ""
     ' -------------------------------------------------
     MI&=1
     MenuID&=%MAIN_FILE1
     GOSUB BuildDropMenu
     App_MAIN_FILE_Count&=MCT&
     EZ_AddMenuItem hDropMenu&,%MAIN_EXITAPP, 0, "E&xit Application", ""
     EZ_SaveMenu "MAIN", 1, hDropMenu&
     EZ_SetSubMenu hMainMenu& , %MAIN_FILEMENU, hDropMenu&
     ' -------------------------------------------------
     MI&=2
     MenuID&=%MAIN_SETUP1
     GOSUB BuildDropMenu
     App_MAIN_SETUP_Count&=MCT&
     EZ_SaveMenu "MAIN", 2, hDropMenu&
     EZ_SetSubMenu hMainMenu& , %MAIN_SETUPMENU, hDropMenu&
     ' -------------------------------------------------
     MI&=3
     MenuID&=%MAIN_WINDOW1
     GOSUB BuildDropMenu
     App_MAIN_WINDOW_Count&=MCT&
     EZ_SaveMenu "MAIN", 3, hDropMenu&
     EZ_SetSubMenu hMainMenu& , %MAIN_WINMENU, hDropMenu&
     ' -------------------------------------------------
     hDropMenu&=EZ_DefSubMenu( %MAIN_ABOUTBOX, "&About this app", "")
     EZ_SaveMenu "MAIN", 4, hDropMenu&
     EZ_SetSubMenu hMainMenu& , %MAIN_ABOUTMENU, hDropMenu&
     ' ------------------------------------------------
     EZ_Color 0, 36
     EZ_UseFont 10
     EZ_UseAutoSize "VH"
     EZ_Text %MAIN_TEXTXPOS, 5, .25, 12.5, 1.75, "", "CS"
     ' -----------------------------------------------
     EZ_Color 0, 36
     EZ_UseFont 6
     EZ_UseAutoSize "VH-2"
     EZ_ODButton %MAIN_BUTTONXPOS, 18.25, .25, 8.75, 1.75, "Set X Pos", "T"
     EZ_SetRegion "Main", %MAIN_BUTTONXPOS,-2,0
     ' -----------------------------------------------
     EZ_Color 0, 36
     EZ_UseFont 6
     EZ_UseAutoSize "VH-2"
     EZ_ODButton %MAIN_BUTTONXONOFF, 27.625, .25, 11.75, 1.75, MakeButtonRedGreen("  X Motor ON",0), "T"
     EZ_SetRegion "Main", %MAIN_BUTTONXONOFF,-2,0
     ' -----------------------------------------------
     EZ_Color 0, 37
     EZ_UseFont 10
     EZ_UseAutoSize "VH"
     EZ_Text %MAIN_TEXTYPOS, 5, 2.375, 12.5, 1.75, "", "CS"
     ' -----------------------------------------------
     EZ_Color 0, 37
     EZ_UseFont 6
     EZ_UseAutoSize "VH-2"
     EZ_ODButton %MAIN_BUTTONYPOS, 18.25, 2.375, 8.75, 1.75, "Set Y Pos", "T"
     EZ_SetRegion "Main", %MAIN_BUTTONYPOS,-2,0
     ' -----------------------------------------------
     EZ_Color 0, 37
     EZ_UseFont 6
     EZ_UseAutoSize "VH-2"
     EZ_ODButton %MAIN_BUTTONYONOFF, 27.625, 2.375, 11.75, 1.75, MakeButtonRedGreen("  Y Motor ON",0), "T"
     EZ_SetRegion "Main", %MAIN_BUTTONYONOFF,-2,0
     ' -----------------------------------------------
     EZ_Color 0, 38
     EZ_UseFont 10
     EZ_UseAutoSize "VH"
     EZ_Text %MAIN_TEXTRPOS, 5, 4.5, 12.5, 1.75, "", "CS"
     ' -----------------------------------------------
     EZ_Color 0, 38
     EZ_UseFont 6
     EZ_UseAutoSize "VH-2"
     EZ_ODButton %MAIN_BUTTONRPOS, 18.25, 4.5, 8.75, 1.75, "Set R Pos", "T"
     EZ_SetRegion "Main", %MAIN_BUTTONRPOS,-2,0
     ' -----------------------------------------------
     EZ_Color 0, 38
     EZ_UseFont 6
     EZ_UseAutoSize "VH-2"
     EZ_ODButton %MAIN_BUTTONRONOFF, 27.625, 4.5, 11.75, 1.75, MakeButtonRedGreen("  R Motor ON",0), "T"
     EZ_SetRegion "Main", %MAIN_BUTTONRONOFF,-2,0
     ' -----------------------------------------------
     EZ_Color 0, 31
     EZ_UseFont 6
     EZ_UseAutoSize "VH-2"
     EZ_ODButton %MAIN_BUTTONPOLAR, .5, 7.375, 6.875, 1.625, MakeButtonBlackGray("    Polar",0), "T"
     EZ_SetRegion "Main", %MAIN_BUTTONPOLAR,-2,0
     ' -----------------------------------------------
     EZ_Color 0, 31
     EZ_UseFont 6
     EZ_UseAutoSize "VH-2"
     EZ_ODButton %MAIN_BUTTONCARTESIAN, 8, 7.375, 9.5, 1.625, MakeButtonBlackGray("    Cartesian",0), "T"
     EZ_SetRegion "Main", %MAIN_BUTTONCARTESIAN,-2,0
     ' -----------------------------------------------
     EZ_Color 0, 31
     EZ_UseFont 6
     EZ_UseAutoSize "VH-2"
     EZ_ODButton %MAIN_BUTTONALLPOS, 18.25, 7.25, 8.75, 1.75, "Set All Pos", "T"
     EZ_SetRegion "Main", %MAIN_BUTTONALLPOS,-2,0
     ' -----------------------------------------------
     EZ_Color 0, 40
     EZ_UseFont 6
     EZ_UseAutoSize "VH-2"
     EZ_ODButton %MAIN_BUTTONALLOFF, 27.625, 7.25, 5.5, 1.75, "All Off", "T"
     EZ_SetRegion "Main", %MAIN_BUTTONALLOFF,-2,0
     ' -----------------------------------------------
     EZ_Color 0, 41
     EZ_UseFont 6
     EZ_UseAutoSize "VH-2"
     EZ_ODButton %MAIN_BUTTONALLON, 33.875, 7.25, 5.5, 1.75, "All On", "T"
     EZ_SetRegion "Main", %MAIN_BUTTONALLON,-2,0
     ' -----------------------------------------------
     EZ_Color 0, 42
     EZ_UseFont 7
     EZ_UseAutoSize "VH-2"
     EZ_ODButton %MAIN_BUTTONGOSCAN, .5, 9.5, 12.5, 2.125, "GO Auto Scan", "T"
     EZ_SetRegion "Main", %MAIN_BUTTONGOSCAN,-2,0
     ' -----------------------------------------------
     EZ_Color 0, 31
     EZ_UseFont 6
     EZ_UseAutoSize "VH-2"
     EZ_ODButton %MAIN_BUTTONEXTRASCAN, 13.75, 9.5, 12.5, 2.125, "", "TH"
     EZ_SetRegion "Main", %MAIN_BUTTONEXTRASCAN,-2,0
     ' -----------------------------------------------
     EZ_Color 0, 43
     EZ_UseFont 7
     EZ_UseAutoSize "VH-2"
     EZ_ODButton %MAIN_BUTTONSTOPSCAN, 27, 9.5, 12.5, 2.125, "STOP Scan", "T"
     EZ_SetRegion "Main", %MAIN_BUTTONSTOPSCAN,-2,0
     ' -----------------------------------------------
     EZ_Color 0, 37
     EZ_UseFont 9
     EZ_UseAutoSize "VH-2"
     EZ_ODButton %MAIN_BUTTONJOGYPLUS, 45, 1, 4, 1.875, "Y+", "T"
     EZ_SetRegion "Main", %MAIN_BUTTONJOGYPLUS,-2,0
     ' -----------------------------------------------
     EZ_Color 0, 36
     EZ_UseFont 9
     EZ_UseAutoSize "VH-2"
     EZ_ODButton %MAIN_BUTTONJOGXMINUS, 42, 3.25, 4, 2, "X-", "T"
     EZ_SetRegion "Main", %MAIN_BUTTONJOGXMINUS,-2,0
     ' -----------------------------------------------
     EZ_Color 0, 36
     EZ_UseFont 9
     EZ_UseAutoSize "VH-2"
     EZ_ODButton %MAIN_BUTTONJOGXPLUS, 48, 3.25, 4, 2, "X+", "T"
     EZ_SetRegion "Main", %MAIN_BUTTONJOGXPLUS,-2,0
     ' -----------------------------------------------
     EZ_Color 0, 37
     EZ_UseFont 9
     EZ_UseAutoSize "VH-2"
     EZ_ODButton %MAIN_BUTTONJOGYMINUS, 45, 5.625, 4, 2, "Y-", "T"
     EZ_SetRegion "Main", %MAIN_BUTTONJOGYMINUS,-2,0
     ' -----------------------------------------------
     EZ_Color 0, 38
     EZ_UseFont 9
     EZ_UseAutoSize "VH-2"
     EZ_ODButton %MAIN_BUTTONJOGRPLUS, 74.25, 1, 4, 2, "R+", "T"
     EZ_SetRegion "Main", %MAIN_BUTTONJOGRPLUS,-2,0
     ' -----------------------------------------------
     EZ_Color 0, 38
     EZ_UseFont 9
     EZ_UseAutoSize "VH-2"
     EZ_ODButton %MAIN_BUTTONJOGRMINUS, 74.25, 5.625, 4, 2, "R-", "T"
     EZ_SetRegion "Main", %MAIN_BUTTONJOGRMINUS,-2,0
     ' -----------------------------------------------
     EZ_Color 0, 33
     EZ_UseFont 4
     EZ_UseAutoSize "VHE1"
     EZ_SubClass 2
     EZ_Canvas %MAIN_CANVASJOGCONTROL, 54.25, 0, 18, 9, ""
     EZ_SetRegion "Main", %MAIN_CANVASJOGCONTROL, 1,0
     EZ_SubClass 0
     MAIN_CANVASJOGCONTROL_Draw -1
     ' -----------------------------------------------
     EZ_Color-1,-1
     EZ_UseFont 4
     EZ_UseAutoSize "VH"
     EZ_HTrackBar %MAIN_TRACKBARJOGRATE, 41.75, 8.625, 28.5, 1.375, "!=4T"
     ' -----------------------------------------------
     EZ_Color 0, 15
     EZ_UseFont 6
     EZ_UseAutoSize "VH"
     EZ_Text %MAIN_TEXTJOGRATE, 69.5, 8.875, 8.75, 1.375, "", "CST"
     ' -----------------------------------------------
     EZ_Color 0, 31
     EZ_UseFont 6
     EZ_UseAutoSize "VH-2"
     EZ_ODButton %MAIN_BUTTONJOGCONT, 45.25, 10.5, 12.25, 1.375, MakeButtonBlackGray("    Continuous",0), "T"
     EZ_SetRegion "Main", %MAIN_BUTTONJOGCONT,-2,0
     ' -----------------------------------------------
     EZ_Color 0, 31
     EZ_UseFont 6
     EZ_UseAutoSize "VH-2"
     EZ_ODButton %MAIN_BUTTONJOGSTEP, 58.25, 10.5, 8, 1.375, MakeButtonBlackGray("    Step",0), "T"
     EZ_SetRegion "Main", %MAIN_BUTTONJOGSTEP,-2,0
     ' -----------------------------------------------
     ' 18 extra buttons
     LOCAL N&, I&, C!, R!, ID&
     R!=.125
     ID&=0
     FOR N&=1 TO 6
          C!=80.375
          FOR I&=1 TO 3
               EZ_Color 0, 31
               EZ_UseFont 6
               EZ_UseAutoSize "VH-2"
               T$=READ$(ID&+5)
               EZ_ODButton %MAIN_BUTTONEXTRA+ID&, C!, R!, 12.25, 1.75, T$, "TH"
               EZ_SetRegion "Main", %MAIN_BUTTONEXTRA+ID&,-2,0
               ID&=ID+1
               C!=C!+13
          NEXT I&
          R!=R!+2
     NEXT N&
     ' -----------------------------------------------
     EZ_Color 0, 0
     EZ_UseFont 4
     EZ_UseAutoSize "FL,FR,VE"
     EZ_SubClass 2
     EZ_Canvas %MAIN_MAINCANVAS, 0, 12.5, 119, 26.25, "+T{DIB}"
     EZ_SubClass 0
     MAIN_MAINCANVAS_Draw -1
     ' -----------------------------------------------
     EZ_Color 0, 15
     EZ_UseFont 11
     EZ_UseAutoSize "VH"
     EZ_Label %MAIN_LABELSTATUS, 0, 38.75, 119, 2.25, "", "^CST"
     ' -----------------------------------------------
     EZ_Color 0, 36
     EZ_UseFont 9
     EZ_UseAutoSize "VH2"
     EZ_Label %MAIN_LABELXPOS, .5, .25, 4, 1.75, "X", "^C"
     EZ_SetRegion "Main", %MAIN_LABELXPOS, 2,0
     ' -----------------------------------------------
     EZ_Color 0, 37
     EZ_UseFont 9
     EZ_UseAutoSize "VH2"
     EZ_Label %MAIN_LABELYPOS, .5, 2.375, 4, 1.75, "Y", "^C"
     EZ_SetRegion "Main", %MAIN_LABELYPOS, 2,0
     ' -----------------------------------------------
     EZ_Color 0, 38
     EZ_UseFont 9
     EZ_UseAutoSize "VH2"
     EZ_Label %MAIN_LABELRPOS, .5, 4.5, 4, 1.75, "R", "^C"
     EZ_SetRegion "Main", %MAIN_LABELRPOS, 2,0
     ' -----------------------------------------------
     EZ_Color-1,-1
     EZ_UseFont 8
     EZ_UseAutoSize "VH"
     EZ_Label %MAIN_LABELCOORSYS, 1.25, 6.25, 15.25, 1.125, "Coordinate System", "C"
     ' -----------------------------------------------
     EZ_Color-1,-1
     EZ_UseFont 4
     EZ_UseAutoSize "VH"
     EZ_Label %MAIN_LABEL1, 40.25, .125, 1, 12, "[[25,17,5]]", "CO"
     ' -----------------------------------------------
     EZ_Color-1,-1
     EZ_UseFont 4
     EZ_UseAutoSize "VH"
     EZ_Label %MAIN_LABEL2, 79, .125, 1, 12, "[[25,17,5]]", "CO"
     ' -----------------------------------------------
     EZ_Color-1,-1
     EZ_UseFont 4
     EZ_UseAutoSize "VH"
     EZ_Label %MAIN_LABEL3, 0, 12, 119, .5, "[[25,17,7]]", "CO"
     ' -----------------------------------------------
     EZ_Color-1,-1
     EZ_UseFont 8
     EZ_UseAutoSize "VH"
     EZ_Label %MAIN_LABELJOGRATE, 70.75, 10.5, 7, 1.125, "Jog Rate", "C"
     ' -----------------------------------------------
     EXIT SUB

BuildDropMenu:
     MText$=READ$(MI&)
     MCT&=PARSECOUNT(MText$,"|")
     FOR J&=1 TO MCT&
          IF J&=1 THEN
               hDropMenu&=EZ_DefSubMenu( MenuID&, PARSE$(MText$,"|", J&), "")
          ELSE
               EZ_AddMenuItem hDropMenu&, MenuID&, 0, PARSE$(MText$,"|", J&), ""
          END IF
          MenuID&=MenuID&+1
     NEXT J&
RETURN

END SUB

SUB SetRedGreenState(BYVAL FormName$, BYVAL CID&, BYVAL BState&)
     LOCAL T$
     T$=EZ_GetText(FormName$, CID&)
     T$=PARSE$(T$,"[",1)
     T$=MakeButtonRedGreen(T$, BState&)
     EZ_SetText FormName$, CID&, T$
END SUB

SUB SetBlackGrayState(BYVAL FormName$, BYVAL CID&, BYVAL BState&)
     LOCAL T$
     T$=EZ_GetText(FormName$, CID&)
     T$=PARSE$(T$,"[",1)
     T$=MakeButtonBlackGray(T$, BState&)
     EZ_SetText FormName$, CID&, T$
END SUB

GLOBAL App_Stack() AS LONG
GLOBAL App_StackTop&
GLOBAL App_StackMax&
GLOBAL App_StackBottom&

SUB InitStack()
     App_StackBottom&=1
     App_StackMax&=1000
     App_StackTop&=0     ' nothing in stack
     REDIM App_Stack(1 TO App_StackMax&, 1 TO 3) AS GLOBAL LONG
END SUB

SUB PrintStatus(BYVAL SText$)
     EZ_SetText "MAIN", %MAIN_LABELSTATUS, SText$
     EZ_RedrawControl "MAIN", %MAIN_LABELSTATUS
END SUB

SUB SetUserInput(BYVAL CID&, BYVAL CMsg&, BYVAL CVal&)
     EZ_StartCSect 1
RestartInput:
     IF App_StackTop& < App_StackMax& THEN
          App_StackTop& = App_StackTop&+1
          App_Stack(App_StackTop&,1) = CID&
          App_Stack(App_StackTop&,2) = CMsg&
          App_Stack(App_StackTop&,3) = CVal&
     ELSE ' stack needs to be reshuffled
          LOCAL I&, J1&, J2&, J3&
          IF App_StackBottom&>1 THEN    ' if fails stack is full
               J1&=App_StackBottom&
               J2&=App_StackTop&
               J3&=1
               FOR I&=J1& TO J2&
                    App_Stack(J3&,1) = App_Stack(I&,1)
                    App_Stack(J3&,2) = App_Stack(I&,2)
                    App_Stack(J3&,3) = App_Stack(I&,3)
                    App_StackTop& = J3&
                    J3&=J3&+1
               NEXT I&
               App_StackBottom& = 1
               GOTO RestartInput
          ELSE
               printStatus STR$(App_StackBottom&)+"  "+STR$(App_StackTop&)
          END IF
     END IF
     EZ_EndCSect 1
END SUB

%GUINoInput    =     -999&

SUB GUIGetUserInput(CID&, CMsg&, CVal&)
     EZ_StartCSect 1
     IF App_StackBottom& <= App_StackTop& THEN
          CID& = App_Stack(App_StackBottom&,1)
          CMsg& = App_Stack(App_StackBottom&,2)
          CVal& = App_Stack(App_StackBottom&,3)
          App_Stack(App_StackBottom&,1) = 0
          App_Stack(App_StackBottom&,2) = 0
          App_Stack(App_StackBottom&,3) = 0
          App_StackBottom&=App_StackBottom&+1
          IF App_StackBottom& > App_StackTop& THEN     ' stack is empty
               App_StackBottom&=1
               App_StackTop&=0
          END IF
     ELSE
          CID&=%GUINoInput
          CMsg&=%GUINoInput
          CVal&=0
     END IF
     EZ_EndCSect 1
END SUB

FUNCTION GUICheckKey(BYVAL CMsg&, BYVAL CVal&) AS LONG
     LOCAL RV&
     RV& = 0
     SELECT CASE CMsg&
          CASE %EZ_KeyDown TO %EZ_KeyPress
               RV& = CVal&
          CASE %EZ_SysKeyDown TO %EZ_SysKeyPress
               RV& = CVal&
     END SELECT
     FUNCTION = RV&
END FUNCTION

FUNCTION GUIEventName(BYVAL CMsg&) AS STRING
     LOCAL RV$
     RV$=""
     SELECT CASE CMsg&
          CASE %EZ_KeyDown
               RV$ = "%EZ_KeyDown"
          CASE %EZ_KeyUp
               RV$ = "%EZ_KeyUp"
          CASE %EZ_KeyPress
               RV$ = "%EZ_KeyPress"
          CASE %EZ_SysKeyDown
               RV$ = "%EZ_SysKeyDown"
          CASE %EZ_SysKeyUp
               RV$ = "%EZ_SysKeyUp"
          CASE %EZ_SysKeyPress
               RV$ = "%EZ_SysKeyPress"
          CASE ELSE
     END SELECT
     FUNCTION=RV$
END FUNCTION


GLOBAL App_MainHandle&
GLOBAL App_StatusText$
GLOBAL App_Text1$
GLOBAL App_Text2$
GLOBAL App_Text3$
GLOBAL App_ControlID() AS LONG
GLOBAL App_RV&

SUB InitOtherGlobals()
     REDIM App_ControlID(-1 TO 100) AS GLOBAL LONG

END SUB

SUB EnableControls()
     LOCAL EFlag&, CT&, I&
     EFlag& = App_ControlID(-1)
     CT& = App_ControlID(0)
     FOR I& = 1 TO CT&
          IF EFlag& = 0 THEN
               EZ_DisableC "MAIN", App_ControlID(I&)
          ELSE
               EZ_EnableC "MAIN", App_ControlID(I&)
          END IF
     NEXT I&
END SUB

SUB GUI_XPOS(BYVAL EnableFlag&)
     App_ControlID(-1) = EnableFlag&
     App_ControlID(0)  = 1
     App_ControlID(1)  = %MAIN_BUTTONXPOS
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 22
END SUB

SUB GUI_XONOFF(BYVAL EnableFlag&)
     App_ControlID(-1) = EnableFlag&
     App_ControlID(0)  = 1
     App_ControlID(1)  = %MAIN_BUTTONXONOFF
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 22
END SUB

SUB GUI_YPOS(BYVAL EnableFlag&)
     App_ControlID(-1) = EnableFlag&
     App_ControlID(0)  = 1
     App_ControlID(1)  = %MAIN_BUTTONYPOS
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 22
END SUB

SUB GUI_YONOFF (BYVAL EnableFlag&)
     App_ControlID(-1) = EnableFlag&
     App_ControlID(0)  = 1
     App_ControlID(1)  = %MAIN_BUTTONYONOFF
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 22
END SUB

SUB GUI_RPOS (BYVAL EnableFlag&)
     App_ControlID(-1) = EnableFlag&
     App_ControlID(0)  = 1
     App_ControlID(1)  = %MAIN_BUTTONRPOS
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 22
END SUB

SUB GUI_RONOFF (BYVAL EnableFlag&)
     App_ControlID(-1) = EnableFlag&
     App_ControlID(0)  = 1
     App_ControlID(1)  = %MAIN_BUTTONRONOFF
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 22
END SUB

SUB GUI_POLAR (BYVAL EnableFlag&)
     App_ControlID(-1) = EnableFlag&
     App_ControlID(0)  = 1
     App_ControlID(1)  = %MAIN_BUTTONPOLAR
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 22
END SUB

SUB GUI_CARTESIAN (BYVAL EnableFlag&)
     App_ControlID(-1) = EnableFlag&
     App_ControlID(0)  = 1
     App_ControlID(1)  = %MAIN_BUTTONCARTESIAN
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 22
END SUB

SUB GUI_ALLPOS (BYVAL EnableFlag&)
     App_ControlID(-1) = EnableFlag&
     App_ControlID(0)  = 1
     App_ControlID(1)  = %MAIN_BUTTONALLPOS
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 22
END SUB

SUB GUI_ALLOFF (BYVAL EnableFlag&)
     App_ControlID(-1) = EnableFlag&
     App_ControlID(0)  = 1
     App_ControlID(1)  = %MAIN_BUTTONALLOFF
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 22
END SUB

SUB GUI_ALLON (BYVAL EnableFlag&)
     App_ControlID(-1) = EnableFlag&
     App_ControlID(0)  = 1
     App_ControlID(1)  = %MAIN_BUTTONALLON
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 22
END SUB

SUB GUI_GOSCAN (BYVAL EnableFlag&)
     App_ControlID(-1) = EnableFlag&
     App_ControlID(0)  = 1
     App_ControlID(1)  = %MAIN_BUTTONGOSCAN
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 22
END SUB

SUB GUI_EXTRASCAN (BYVAL EnableFlag&)
     App_ControlID(-1) = EnableFlag&
     App_ControlID(0)  = 1
     App_ControlID(1)  = %MAIN_BUTTONEXTRASCAN
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 22
END SUB

SUB GUI_STOPSCAN (BYVAL EnableFlag&)
     App_ControlID(-1) = EnableFlag&
     App_ControlID(0)  = 1
     App_ControlID(1)  = %MAIN_BUTTONSTOPSCAN
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 22
END SUB

SUB GUI_JOGYPLUS (BYVAL EnableFlag&)
     App_ControlID(-1) = EnableFlag&
     App_ControlID(0)  = 1
     App_ControlID(1)  = %MAIN_BUTTONJOGYPLUS
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 22
END SUB

SUB GUI_JOGXMINUS (BYVAL EnableFlag&)
     App_ControlID(-1) = EnableFlag&
     App_ControlID(0)  = 1
     App_ControlID(1)  = %MAIN_BUTTONJOGXMINUS
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 22
END SUB

SUB GUI_JOGXPLUS (BYVAL EnableFlag&)
     App_ControlID(-1) = EnableFlag&
     App_ControlID(0)  = 1
     App_ControlID(1)  = %MAIN_BUTTONJOGXPLUS
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 22
END SUB

SUB GUI_JOGYMINUS (BYVAL EnableFlag&)
     App_ControlID(-1) = EnableFlag&
     App_ControlID(0)  = 1
     App_ControlID(1)  = %MAIN_BUTTONJOGYMINUS
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 22
END SUB

SUB GUI_JOGRPLUS (BYVAL EnableFlag&)
     App_ControlID(-1) = EnableFlag&
     App_ControlID(0)  = 1
     App_ControlID(1)  = %MAIN_BUTTONJOGRPLUS
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 22
END SUB

SUB GUI_JOGRMINUS (BYVAL EnableFlag&)
     App_ControlID(-1) = EnableFlag&
     App_ControlID(0)  = 1
     App_ControlID(1)  = %MAIN_BUTTONJOGRMINUS
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 22
END SUB

SUB GUI_TRACKBAR (BYVAL EnableFlag&)
     App_ControlID(-1) = EnableFlag&
     App_ControlID(0)  = 1
     App_ControlID(1)  = %MAIN_TRACKBARJOGRATE
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 22
END SUB

SUB GUI_JOGCONT (BYVAL EnableFlag&)
     App_ControlID(-1) = EnableFlag&
     App_ControlID(0)  = 1
     App_ControlID(1)  = %MAIN_BUTTONJOGCONT
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 22
END SUB

SUB GUI_JOGSTEP (BYVAL EnableFlag&)
     App_ControlID(-1) = EnableFlag&
     App_ControlID(0)  = 1
     App_ControlID(1)  = %MAIN_BUTTONJOGSTEP
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 22
END SUB

SUB GUI_EXTRA (BYVAL BN&, BYVAL EnableFlag&)
     App_ControlID(-1) = EnableFlag&
     App_ControlID(0)  = 1
     App_ControlID(1)  = %MAIN_BUTTONEXTRA + BN& -1
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 22
END SUB

FUNCTION GUIShowInputBox(BYVAL Prompt$) AS STRING
     App_Text1$=Prompt$
     App_Text2$=""
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 15
     FUNCTION = App_Text2$
END FUNCTION

SUB GUIPrintStatus(BYVAL SText$)
     App_StatusText$=SText$
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 1
END SUB

SUB GUISetXMotor(BYVAL State&)
     IF State&=0 THEN
          EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 2
     ELSE
          EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 3
     END IF
END SUB

SUB GUISetYMotor(BYVAL State&)
     IF State&=0 THEN
          EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 4
     ELSE
          EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 5
     END IF
END SUB

SUB GUISetRMotor(BYVAL State&)
     IF State&=0 THEN
          EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 6
     ELSE
          EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 7
     END IF
END SUB

SUB GUISetPolarCartesian(BYVAL PState&)
     IF PState&=0 THEN
          EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 11
     ELSE
          EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 12
     END IF
END SUB

SUB GUISetContinuousStep(BYVAL PState&)
     IF PState&=0 THEN
          EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 13
     ELSE
          EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 14
     END IF
END SUB


GLOBAL App_ButtonID&

SUB GUISetButton(BYVAL N&, BYVAL T$)
     App_Text1$=T$
     IF N&>=0 AND N&<=18 THEN
          SELECT CASE N&
               CASE 0
                    App_ButtonID& = %MAIN_BUTTONEXTRASCAN
               CASE ELSE
                    N&=N&-1
                    App_ButtonID& = %MAIN_BUTTONEXTRA + N&
          END SELECT
          EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 16
     END IF
END SUB

GLOBAL App_TBar1&
GLOBAL App_TBar2&
GLOBAL App_TBar3&

SUB GUISetTrackBar(BYVAL MinPos&, BYVAL MaxPos&, BYVAL CurrentPos&)
     App_TBar1& = MinPos&
     App_TBar2& = MaxPos&
     App_TBar3& = CurrentPos&
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 20
END SUB

SUB GUISetJogText(BYVAL T$)
     App_Text1$=T$
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 21
END SUB

SUB GUISetXText(BYVAL T$)
     App_Text1$=T$
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 17
END SUB

SUB GUISetYText(BYVAL T$)
     App_Text1$=T$
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 18
END SUB

SUB GUISetRText(BYVAL T$)
     App_Text1$=T$
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 19
END SUB

SUB GUISetXPos(BYVAL XPos AS DOUBLE)
     GUISetXText GUIDoubleToStr(XPos)
END SUB

SUB GUISetYPos(BYVAL YPos AS DOUBLE)
     GUISetYText GUIDoubleToStr(YPos)
END SUB

SUB GUISetRPos(BYVAL RPos AS DOUBLE)
     GUISetRText GUIDoubleToStr(RPos)
END SUB

SUB GUIMsgBox(BYVAL T$)
     App_Text1$=T$
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 8
END SUB

SUB GUIWarningBox(BYVAL T$)
     App_Text1$=T$
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 9
END SUB

FUNCTION GUIQuestionBox(BYVAL T$, BYVAL BProp$) AS LONG
     App_Text1$=T$
     App_Text2$=BProp$
     App_RV&=0
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 10
     FUNCTION=App_RV&
END FUNCTION



%MAIN_Thread1  =    10

GLOBAL App_AllowCloseFlag&
GLOBAL App_MainIsClosing&

SUB GUISetClose
     EZ_StartCSect 2
     App_AllowCloseFlag& = 1
     EZ_EndCSect 2
END SUB

FUNCTION AllowClose() AS LONG
     LOCAL RV&
     RV&=0
     EZ_StartCSect 2
     RV& = App_AllowCloseFlag&
     EZ_EndCSect 2
     FUNCTION=RV&
END FUNCTION


SUB EZ_MAIN_ParseEvents(CID&, CMsg&, CVal&, Cancel&)
     LOCAL MenuN&, EText$, RV$
     SELECT CASE CID&
          CASE %MAIN_Thread1
               IF CMsg&=%EZ_Thread THEN
                    SELECT CASE CVal&

                    END SELECT
               END IF
          CASE %MAIN_FakeID
               IF CMsg&=%EZ_Thread THEN
                    SELECT CASE CVal&
                         CASE 1    ' set status text
                              EZ_SetText "MAIN", %MAIN_LABELSTATUS, App_StatusText$
                         CASE 2    ' set X Motor Off
                              SetRedGreenState "MAIN", %MAIN_BUTTONXONOFF, 0
                         CASE 3    ' set X Motor ON
                              SetRedGreenState "MAIN", %MAIN_BUTTONXONOFF, 1
                         CASE 4    ' set Y Motor Off
                              SetRedGreenState "MAIN", %MAIN_BUTTONYONOFF, 0
                         CASE 5    ' set Y Motor ON
                              SetRedGreenState "MAIN", %MAIN_BUTTONYONOFF, 1
                         CASE 6    ' set R Motor Off
                              SetRedGreenState "MAIN", %MAIN_BUTTONRONOFF, 0
                         CASE 7    ' set R Motor ON
                              SetRedGreenState "MAIN", %MAIN_BUTTONRONOFF, 1
                         CASE 8
                              AppMsgBox App_Text1$
                         CASE 9
                              AppWarningBox App_Text1$
                         CASE 10
                              App_RV&=AppQuestionBox(App_Text1$,App_Text2$)
                         CASE 11
                              SetBlackGrayState "MAIN",%MAIN_BUTTONPOLAR, 0
                              SetBlackGrayState "MAIN",%MAIN_BUTTONCARTESIAN, 1
                         CASE 12
                              SetBlackGrayState "MAIN",%MAIN_BUTTONPOLAR, 1
                              SetBlackGrayState "MAIN",%MAIN_BUTTONCARTESIAN, 0
                         CASE 13
                              SetBlackGrayState "MAIN",%MAIN_BUTTONJOGCONT, 0
                              SetBlackGrayState "MAIN",%MAIN_BUTTONJOGSTEP, 1
                         CASE 14
                              SetBlackGrayState "MAIN",%MAIN_BUTTONJOGCONT, 1
                              SetBlackGrayState "MAIN",%MAIN_BUTTONJOGSTEP, 0
                         CASE 15
                              App_Text2$ = ShowInputBox(App_Text1$, "")
                         CASE 16
                              EZ_SetText "MAIN", App_ButtonID&, App_Text1$
                              EZ_ShowC "MAIN", App_ButtonID&, App_ButtonID&
                         CASE 17
                              EZ_SetText "MAIN", %MAIN_TEXTXPOS, App_Text1$
                         CASE 18
                              EZ_SetText "MAIN", %MAIN_TEXTYPOS, App_Text1$
                         CASE 19
                              EZ_SetText "MAIN", %MAIN_TEXTRPOS, App_Text1$
                         CASE 20
                              EZ_SetTBar "MAIN", %MAIN_TRACKBARJOGRATE, App_TBar1&, App_TBar2&, App_TBar3&
                         CASE 21
                              EZ_SetText "MAIN", %MAIN_TEXTJOGRATE, App_Text1$
                         CASE 22
                              EnableControls


                         ' above 100 is for Graphic command set
                         CASE 100   ' Draw Graphic on GRAPHIC Form
                              GRAPHIC_BACKCANVAS_Draw 1
                         CASE 101   ' Show Graphic Window
                              EZ_ShowForm "GRAPHIC"
                         CASE 102  ' get aspect ratio
                              App_AspectRatio! = 1!
                              LOCAL TempC!, TempR!, TempW!, TempH!
                              EZ_GetSizeC "GRAPHIC", %GRAPHIC_BACKCANVAS, TempC!, TempR!, TempW!, TempH!
                              TempW!=EZ_X(TempW!)
                              TempH!=EZ_Y(TempH!)
                              App_AspectRatio! = TempH! / TempW!
                         CASE 103
                              SetBitmapSize 1
                         CASE 104
                              CopyCanvas
                         CASE ELSE
                    END SELECT
               END IF
          ' -------------
          ' Form events
          ' -------------
          CASE %EZ_Window
               SELECT CASE CMsg&
                    CASE %EZ_Loading
                    CASE %EZ_Loaded
                         App_MainIsClosing& = 0
                         EZ_GRAPHIC_Display "MAIN"
                         App_MainHandle& = EZ_Handle("MAIN",0)
                         App_AllowCloseFlag& = 0
                         InitStack
                         EZ_StartThreadEx "MAIN", %MAIN_Thread1, 0, CODEPTR(BackEndThreadFunc)
                    CASE %EZ_Started
                         SetUserInput CID&, CMsg&, CVal&
                    CASE %EZ_Close
                         LOCAL NI&
                         PrintStatus "Request to Close Application Pending!"
                         SetUserInput CID&, CMsg&, CVal&
                         FOR NI&=1 TO 10
                              IF AllowClose = 0 THEN
                                  EZ_Sleep 0.25
                              ELSE
                                   EXIT FOR
                              END IF
                         NEXT NI&
                         IF AllowClose THEN
                              PrintStatus "Application Closing down now!"
                              EZ_CloseThread "MAIN", %MAIN_Thread1
                              App_MainIsClosing& = 1
                              EZ_Sleep 0.5
                         ELSE
                              PrintStatus "Request to Close Application Failed!"
                              Cancel&=1 ' don't allow app to close
                        END IF
                    CASE %EZ_NoAutoSize
                         Cancel&=1 ' turns ON autosize for this form
                    CASE ELSE
               END SELECT
          ' -------------
          ' Menu events
          ' -------------
          CASE %MAIN_FILE1 TO %MAIN_FILE1+App_MAIN_FILE_Count&-1
               MenuN&=50+CID&-%MAIN_FILE1+1
               SELECT CASE CMsg&
                    CASE %EZ_Click
                        LOCAL Filter$
                        Filter$ = "Setup Files|*.dat|Data Files|*.dat;*.dta|"

                        SetUserInput MenuN&, CMsg&, CVal&
                        File_Name = EZ_OpenFile("MAIN", "ATCO Open File", "", Filter$, "SPI")
               END SELECT
          CASE %MAIN_EXITAPP
               SELECT CASE CMsg&
                    CASE %EZ_Click
                         EZ_UnloadForm "Main"
                    CASE ELSE
               END SELECT
          CASE %MAIN_SETUP1 TO %MAIN_SETUP1+App_MAIN_SETUP_Count&-1
               MenuN&=60+CID&-%MAIN_SETUP1+1
               SELECT CASE CMsg&
                    CASE %EZ_Click
                         EZ_SETUPFORM_Display "MAIN"
                         SetUserInput MenuN&, CMsg&, CVal&
               END SELECT
          CASE %MAIN_WINDOW1 TO %MAIN_WINDOW1+App_MAIN_WINDOW_Count&-1
               MenuN&=70+CID&-%MAIN_WINDOW1+1
               SELECT CASE CMsg&
                    CASE %EZ_Click
                         SetUserInput MenuN&, CMsg&, CVal&
               END SELECT
          CASE %MAIN_ABOUTBOX
               SELECT CASE CMsg&
                    CASE %EZ_Click
                         AppMsgBox "Atco Scanner App 2015"
               END SELECT
          ' -------------
          ' Control events
          ' -------------
          CASE %MAIN_TRACKBARJOGRATE
               SELECT CASE CMsg&
                    CASE %EZ_Change
                         SetUserInput CID&, %EZ_Change, CVal&
                    CASE ELSE
               END SELECT
          CASE  %MAIN_BUTTONXPOS
               SELECT CASE CMsg&
                    CASE %EZ_Click, %EZ_DClick
                         SetUserInput CID&, %EZ_Click, CVal&
                    CASE %EZ_OwnerDraw
                         EZ_Draw3DButtonRR "Main", %MAIN_BUTTONXPOS, CVal&, 36, 0,  6
               END SELECT
          CASE  %MAIN_BUTTONXONOFF
               SELECT CASE CMsg&
                    CASE %EZ_Click, %EZ_DClick
                         SetUserInput CID&, %EZ_Click, CVal&
                    CASE %EZ_OwnerDraw
                         EZ_Draw3DButtonRR "Main", %MAIN_BUTTONXONOFF, CVal&, 36, 0,  6
               END SELECT
          CASE  %MAIN_BUTTONYPOS
               SELECT CASE CMsg&
                    CASE %EZ_Click, %EZ_DClick
                         SetUserInput CID&, %EZ_Click, CVal&
                    CASE %EZ_OwnerDraw
                         EZ_Draw3DButtonRR "Main", %MAIN_BUTTONYPOS, CVal&, 37, 0,  6
               END SELECT
          CASE  %MAIN_BUTTONYONOFF
               SELECT CASE CMsg&
                    CASE %EZ_Click, %EZ_DClick
                         SetUserInput CID&, %EZ_Click, CVal&
                    CASE %EZ_OwnerDraw
                         EZ_Draw3DButtonRR "Main", %MAIN_BUTTONYONOFF, CVal&, 37, 0,  6
               END SELECT
          CASE  %MAIN_BUTTONRPOS
               SELECT CASE CMsg&
                    CASE %EZ_Click, %EZ_DClick
                         SetUserInput CID&, %EZ_Click, CVal&
'                         EText$=EZ_GetText("MAIN", %MAIN_TEXTRPOS)
                    CASE %EZ_OwnerDraw
                         EZ_Draw3DButtonRR "Main", %MAIN_BUTTONRPOS, CVal&, 38, 0,  6
               END SELECT
          CASE  %MAIN_BUTTONRONOFF
               SELECT CASE CMsg&
                    CASE %EZ_Click, %EZ_DClick
                         SetUserInput CID&, %EZ_Click, CVal&
                    CASE %EZ_OwnerDraw
                         EZ_Draw3DButtonRR "Main", %MAIN_BUTTONRONOFF, CVal&, 38, 0,  6
               END SELECT
          CASE  %MAIN_BUTTONPOLAR
               SELECT CASE CMsg&
                    CASE %EZ_Click, %EZ_DClick
                         SetUserInput CID&, %EZ_Click, CVal&
                    CASE %EZ_OwnerDraw
                         EZ_Draw3DButtonRR "Main", %MAIN_BUTTONPOLAR, CVal&, 31, 0,  6
               END SELECT
          CASE  %MAIN_BUTTONCARTESIAN
               SELECT CASE CMsg&
                    CASE %EZ_Click, %EZ_DClick
                         SetUserInput CID&, %EZ_Click, CVal&
                    CASE %EZ_OwnerDraw
                         EZ_Draw3DButtonRR "Main", %MAIN_BUTTONCARTESIAN, CVal&, 31, 0,  6
               END SELECT
          CASE  %MAIN_BUTTONALLPOS
               SELECT CASE CMsg&
                    CASE %EZ_Click, %EZ_DClick
                         SetUserInput CID&, %EZ_Click, CVal&
                    CASE %EZ_OwnerDraw
                         EZ_Draw3DButtonRR "Main", %MAIN_BUTTONALLPOS, CVal&, 31, 0,  6
               END SELECT
          CASE  %MAIN_BUTTONALLOFF
               SELECT CASE CMsg&
                    CASE %EZ_Click, %EZ_DClick
                         SetUserInput CID&, %EZ_Click, CVal&
                    CASE %EZ_OwnerDraw
                         EZ_Draw3DButtonRR "Main", %MAIN_BUTTONALLOFF, CVal&, 40, 0,  6
               END SELECT
          CASE  %MAIN_BUTTONALLON
               SELECT CASE CMsg&
                    CASE %EZ_Click, %EZ_DClick
                         SetUserInput CID&, %EZ_Click, CVal&
                    CASE %EZ_OwnerDraw
                         EZ_Draw3DButtonRR "Main", %MAIN_BUTTONALLON, CVal&, 41, 0,  6
               END SELECT
          CASE  %MAIN_BUTTONGOSCAN
               SELECT CASE CMsg&
                    CASE %EZ_Click, %EZ_DClick
                         SetUserInput CID&, %EZ_Click, CVal&
                    CASE %EZ_OwnerDraw
                         EZ_Draw3DButtonRR "Main", %MAIN_BUTTONGOSCAN, CVal&, 42, 0,  7
               END SELECT
          CASE  %MAIN_BUTTONEXTRASCAN
               SELECT CASE CMsg&
                    CASE %EZ_Click, %EZ_DClick
                         SetUserInput CID&, %EZ_Click, CVal&
                    CASE %EZ_OwnerDraw
                         EZ_Draw3DButtonRR "Main", %MAIN_BUTTONEXTRASCAN, CVal&, 31, 0,  6
               END SELECT
          CASE  %MAIN_BUTTONSTOPSCAN
               SELECT CASE CMsg&
                    CASE %EZ_Click, %EZ_DClick
                         SetUserInput CID&, %EZ_Click, CVal&
                    CASE %EZ_OwnerDraw
                         EZ_Draw3DButtonRR "Main", %MAIN_BUTTONSTOPSCAN, CVal&, 43, 0,  7
               END SELECT
          CASE  %MAIN_BUTTONJOGYPLUS
               SELECT CASE CMsg&
                    CASE %EZ_Click, %EZ_DClick
                         SetUserInput CID&, %EZ_Click, CVal&
                    CASE %EZ_OwnerDraw
                         EZ_Draw3DButtonRR "Main", %MAIN_BUTTONJOGYPLUS, CVal&, 37, 0,  9
               END SELECT
          CASE  %MAIN_BUTTONJOGXMINUS
               SELECT CASE CMsg&
                    CASE %EZ_Click, %EZ_DClick
                         SetUserInput CID&, %EZ_Click, CVal&
                    CASE %EZ_OwnerDraw
                         EZ_Draw3DButtonRR "Main", %MAIN_BUTTONJOGXMINUS, CVal&, 36, 0,  9
               END SELECT
          CASE  %MAIN_BUTTONJOGXPLUS
               SELECT CASE CMsg&
                    CASE %EZ_Click, %EZ_DClick
                         SetUserInput CID&, %EZ_Click, CVal&
                    CASE %EZ_OwnerDraw
                         EZ_Draw3DButtonRR "Main", %MAIN_BUTTONJOGXPLUS, CVal&, 36, 0,  9
               END SELECT
          CASE  %MAIN_BUTTONJOGYMINUS
               SELECT CASE CMsg&
                    CASE %EZ_Click, %EZ_DClick
                         SetUserInput CID&, %EZ_Click, CVal&
                    CASE %EZ_OwnerDraw
                         EZ_Draw3DButtonRR "Main", %MAIN_BUTTONJOGYMINUS, CVal&, 37, 0,  9
               END SELECT
          CASE  %MAIN_BUTTONJOGRPLUS
               SELECT CASE CMsg&
                    CASE %EZ_Click, %EZ_DClick
                         SetUserInput CID&, %EZ_Click, CVal&
                    CASE %EZ_OwnerDraw
                         EZ_Draw3DButtonRR "Main", %MAIN_BUTTONJOGRPLUS, CVal&, 38, 0,  9
               END SELECT
          CASE  %MAIN_BUTTONJOGRMINUS
               SELECT CASE CMsg&
                    CASE %EZ_Click, %EZ_DClick
                         SetUserInput CID&, %EZ_Click, CVal&
                    CASE %EZ_OwnerDraw
                         EZ_Draw3DButtonRR "Main", %MAIN_BUTTONJOGRMINUS, CVal&, 38, 0,  9
               END SELECT
          CASE %MAIN_CANVASJOGCONTROL
               SELECT CASE CMsg&
                    CASE %EZ_ScaleMe
                         LOCAL OX&,OY&,OW&,OH&,NX&,NY&,NW&, NH&
                         EZ_GetScaleMe CVal&, OX&,OY&,OW&,OH&,NX&,NY&,NW&, NH&
                         IF NW&>NH& THEN
                              NW&=NH&
                         ELSE
                              IF NH&>NW& THEN NH&=NW&
                         END IF
                         EZ_SetScaleMe CVal&, NX&, NY&, NW&, NH&
               END SELECT
          CASE  %MAIN_BUTTONJOGCONT
               SELECT CASE CMsg&
                    CASE %EZ_Click, %EZ_DClick
                         SetUserInput CID&, %EZ_Click, CVal&
                    CASE %EZ_OwnerDraw
                         EZ_Draw3DButtonRR "Main", %MAIN_BUTTONJOGCONT, CVal&, 31, 0,  6
               END SELECT
          CASE  %MAIN_BUTTONJOGSTEP
               SELECT CASE CMsg&
                    CASE %EZ_Click, %EZ_DClick
                         SetUserInput CID&, %EZ_Click, CVal&
                    CASE %EZ_OwnerDraw
                         EZ_Draw3DButtonRR "Main", %MAIN_BUTTONJOGSTEP, CVal&, 31, 0,  6
               END SELECT
          CASE  %MAIN_BUTTONEXTRA TO %MAIN_BUTTONEXTRA+17
               LOCAL BN&
               BN&=CID&-%MAIN_BUTTONEXTRA+1       ' buttons 1 to 18
               SELECT CASE CMsg&
                    CASE %EZ_Click, %EZ_DClick
                         ' Buttons will be numbered 1 to 18
                         SetUserInput BN&, %EZ_Click, CVal&
                    CASE %EZ_OwnerDraw
                         EZ_Draw3DButtonRR "Main", CID&, CVal&, 31, 0,  6
               END SELECT
          CASE  %MAIN_MAINCANVAS
               MAIN_MAINCANVAS_Events CID&, CMsg&, CVal&, Cancel&
          CASE  %MAIN_LABEL1
               IF CMsg&=%EZ_OwnerDraw THEN EZ_DrawLabel CVal&,-1, -1,  "[[25,17,5]]"
          CASE  %MAIN_LABEL2
               IF CMsg&=%EZ_OwnerDraw THEN EZ_DrawLabel CVal&,-1, -1,  "[[25,17,5]]"
          CASE  %MAIN_LABEL3
               IF CMsg&=%EZ_OwnerDraw THEN EZ_DrawLabel CVal&,-1, -1,  "[[25,17,7]]"
          CASE ELSE
     END SELECT
END SUB


SUB MAIN_CANVASJOGCONTROL_Draw(BYVAL FMode&)
     LOCAL AFG&, ABG&, AFnt&, CW&, CH&
     AFG&=EZ_FG
     ABG&=EZ_BG
     AFnt&=EZ_Font
     IF FMode&=-1 THEN     ' Initial Data
          CW&=800     ' emulate 8 inches by .01 inch units
          CH&=1050    ' emulate 10.5 inches by .01 inch units
          EZ_StartDraw "Main", %MAIN_CANVASJOGCONTROL, CW&, CH&, ""
          EZ_EndDraw
     END IF
     EZ_Color AFG&, ABG&
     EZ_UseFont AFnt&
END SUB

' ---------------------------------------------------------------------------------------------
'                           Graphic Command Set for Backend
' ---------------------------------------------------------------------------------------------
UNION GParam
     L AS LONG
     D AS SINGLE   ' floating point decimal
     S AS STRING*4 ' text
END UNION

TYPE GTask
     TaskID AS LONG
     Param1 AS GParam
     Param2 AS GParam
     Param3 AS GParam
     Param4 AS GParam
     Param5 AS GParam
     Param6 AS GParam
     Param7 AS GParam
     Param8 AS ASCIIZ*256
END TYPE

GLOBAL App_DrawCycleFlag&
GLOBAL App_GraphicTask() AS GTask
GLOBAL App_GI&
GLOBAL App_GMax&

GLOBAL App_GP1 AS GParam
GLOBAL App_GP2 AS GParam
GLOBAL App_GP3 AS GParam
GLOBAL App_GP4 AS GParam

%App_Start     =    0
%APP_GColor    =    1
%App_GLine     =    2
%APP_GLine2    =    3
%App_GColorEZ  =    4
%APP_GClear    =    5
%APP_GPaint    =    6
%APP_GBox      =    7
%APP_GEllipse  =    8
%App_GBuffer   =    9
%App_GCopyBuffer =  10
%App_GPrint      =  11


SUB InitGraphicStack(BYVAL MaxTasks&)
     ' negative indexes will be used for storing attributes of drawing cycle
     REDIM App_GraphicTask(-100 TO MaxTasks&)
     App_GMax& = MaxTasks&

END SUB

SUB Graphic_Bitmap(BYVAL BWidth&, BYVAL BHeight&)
     EZ_StartCSect 3
     App_GP1.L = BWidth&
     App_GP2.L = BHeight&
     EZ_EndCSect 3
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 103
END SUB

SUB SetBitmapSize(BYVAL N&)
     SELECT CASE N&
          CASE 1
               LOCAL BWidth&, BHeight&, X&, Y&, W!, H!
               EZ_StartCSect 3
               BWidth& = App_GP1.L
               BHeight& = App_GP2.L
               EZ_EndCSect 3
               EZ_GetSize "GRAPHIC", W!, H!, 2
               IF BWidth& > W! OR BHeight&> H! THEN
                    EZ_HideC "GRAPHIC", %GRAPHIC_BACKCANVAS, %GRAPHIC_BACKCANVAS
                    EZ_ShowC "GRAPHIC", %GRAPHIC_FRONTCANVAS, %GRAPHIC_FRONTCANVAS
                    EZ_ResizeC "GRAPHIC", %GRAPHIC_BACKCANVAS, 0,0, EZ_CX(BWidth&), EZ_CY(BHeight&)
               ELSE
                    ' Canvas fits inside Form
                    X& = (W! - BWidth&)/2
                    Y& = (H! - BHeight&)/2
                    EZ_ResizeC "GRAPHIC", %GRAPHIC_BACKCANVAS, EZ_CX(X&),EZ_CY(Y&), EZ_CX(BWidth&), EZ_CY(BHeight&)
                    EZ_ShowC "GRAPHIC", %GRAPHIC_BACKCANVAS, %GRAPHIC_BACKCANVAS
                    EZ_HideC "GRAPHIC", %GRAPHIC_FRONTCANVAS, %GRAPHIC_FRONTCANVAS
               END IF
          CASE ELSE
     END SELECT
END SUB

SUB Graphic_Scale(BYVAL X1!, BYVAL Y1!, BYVAL X2!, BYVAL Y2!, BYVAL MaxDrawStack&)
     IF X2! < X1! THEN X2! = X1! + ABS(X2!)
     IF Y2! < Y1! THEN Y2! = Y1! + ABS(Y2!)
     EZ_StartCSect 3
     App_DrawCycleFlag& = 1
     InitGraphicStack MaxDrawStack&
     App_GraphicTask(-100).TaskID = %App_Start   ' define coordinate system
     App_GraphicTask(-100).Param1.D = X2! - X1!     ' width
     App_GraphicTask(-100).Param2.D = Y2! - Y1!     ' height
     App_GraphicTask(-100).Param3.D = X1!
     App_GraphicTask(-100).Param4.D = Y1!
     App_GraphicTask(-100).Param5.D = X2!
     App_GraphicTask(-100).Param6.D = Y2!
     App_GI& = 0
     EZ_EndCSect 3
END SUB

SUB Graphic_ColorRGB(BYVAL FGColor&, BYVAL BGColor&)
     IF App_GI& < App_GMax& THEN
          App_GI& = App_GI& +1
          App_GraphicTask(App_GI&).TaskID = %APP_GColor
          App_GraphicTask(App_GI&).Param1.L = FGColor&
          App_GraphicTask(App_GI&).Param2.L = BGColor&
     END IF
END SUB

SUB Graphic_Color(BYVAL FGColor&, BYVAL BGColor&)
     IF App_GI& < App_GMax& THEN
          App_GI& = App_GI& +1
          App_GraphicTask(App_GI&).TaskID = %App_GColorEZ
          App_GraphicTask(App_GI&).Param1.L = FGColor&
          App_GraphicTask(App_GI&).Param2.L = BGColor&
     END IF
END SUB

SUB Graphic_Print(BYVAL X!, BYVAL Y!, BYVAL TextStr$)
     IF App_GI& < App_GMax& THEN
          App_GI& = App_GI& +1
          App_GraphicTask(App_GI&).TaskID = %App_GPrint
          App_GraphicTask(App_GI&).Param1.D = X!
          App_GraphicTask(App_GI&).Param2.D = Y!
          App_GraphicTask(App_GI&).Param8 = TextStr$
     END IF
END SUB

SUB Graphic_CopyBuffer(BYVAL SrcBuffer&, BYVAL DestBuffer&)
     IF App_GI& < App_GMax& THEN
          IF SrcBuffer& = 1 OR SrcBuffer& = 2 THEN
               IF SrcBuffer& <> DestBuffer& THEN
                    IF DestBuffer& = 1 OR DestBuffer& = 2 THEN
                         App_GI& = App_GI& +1
                         App_GraphicTask(App_GI&).TaskID = %App_GCopyBuffer
                         App_GraphicTask(App_GI&).Param1.L = SrcBuffer&
                         App_GraphicTask(App_GI&).Param2.L = DestBuffer&
                    END IF
               END IF
          END IF
     END IF
END SUB

%EZCV_GETBITMAP                 =   %EZ_USER+109

SUB CopyCanvas()
     LOCAL DestNumber&, DestForm$, DestID&
     LOCAL W&, H&, X&, Y&, W2&, H2&, NW&, NH&, hBmp&, hDC&
     DestNumber& = 0
     EZ_StartCSect 3
     DestNumber& = App_GP1.L
     EZ_EndCSect 3
     EZ_SetText "MAIN", 0, "Copy ID "+STR$(DestNumber&)
     SELECT CASE DestNumber&
          CASE 1
               DestForm$ = "MAIN"
               DestID& = %MAIN_MAINCANVAS
               GOSUB DrawBuffer
          CASE 2
               IF EZ_IsControl("GRAPHIC",%GRAPHIC_FRONTCANVAS, "V") THEN
                    DestForm$ = "GRAPHIC"
                    DestID& = %GRAPHIC_FRONTCANVAS
                    GOSUB DrawBuffer
               END IF
          CASE ELSE
     END SELECT
     EXIT SUB

DrawBuffer:
IF App_DrawCycleFlag& = 0 THEN
     hBmp& = EZ_SendMessageR("GRAPHIC", %GRAPHIC_BACKCANVAS,%EZCV_GETBITMAP,1,0)
     EZ_GetCanvasSize "GRAPHIC", %GRAPHIC_BACKCANVAS, W&, H&
     EZ_GetCanvasSize DestForm$, DestID&, W2&, H2&
     IF W2& > H2& THEN
          NH& = H2&
          NW& = ((W&*100!)/(H&*100!))*H2&
          Y& = 0
          X& = (W2&-NW&)/2
     ELSE
          NW& = W2&
          NH& = ((H&*100!)/(W&*100!))*W2&
          X& = 0
          Y& = (H2&-NH&)/2
     END IF
     EZ_StartDraw DestForm$, DestID&, W2&, H2&, ""
     EZ_SetDrawMode 1, 4
     hDC& = EZ_ActiveCanvasDC
     EZ_DCDrawPicture hDC&, X&, Y&, NW&, NH&, hBmp&
     EZ_EndDraw
     EZ_RedrawControl DestForm$, DestID&
END IF
RETURN

END SUB

SUB Graphic_Copy(BYVAL DestNumber&)
     EZ_StartCSect 3
     App_GP1.L = DestNumber&
     EZ_EndCSect 3
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 104
END SUB

SUB Graphic_SelectBuffer(BYVAL BufferNumber&)
     IF App_GI& < App_GMax& THEN
          IF BufferNumber& = 1 OR BufferNumber& = 2 THEN
               App_GI& = App_GI& +1
               App_GraphicTask(App_GI&).TaskID = %App_GBuffer
               App_GraphicTask(App_GI&).Param1.L = BufferNumber&
          END IF
     END IF
END SUB

SUB Graphic_Line(BYVAL X1!, BYVAL Y1!, BYVAL X2!, BYVAL Y2!)
     IF App_GI& < App_GMax& THEN
          App_GI& = App_GI& +1
          App_GraphicTask(App_GI&).TaskID = %APP_GLine
          App_GraphicTask(App_GI&).Param1.D = X1!
          App_GraphicTask(App_GI&).Param2.D = Y1!
          App_GraphicTask(App_GI&).Param3.D = X2!
          App_GraphicTask(App_GI&).Param4.D = Y2!
     END IF
END SUB

SUB Graphic_Box(BYVAL X1!, BYVAL Y1!, BYVAL X2!, BYVAL Y2!, BYVAL FillFlag&)
     IF App_GI& < App_GMax& THEN
          App_GI& = App_GI& +1
          App_GraphicTask(App_GI&).TaskID = %APP_GBox
          App_GraphicTask(App_GI&).Param1.D = X1!
          App_GraphicTask(App_GI&).Param2.D = Y1!
          App_GraphicTask(App_GI&).Param3.D = X2!
          App_GraphicTask(App_GI&).Param4.D = Y2!
          App_GraphicTask(App_GI&).Param5.L = FillFlag&
     END IF
END SUB

SUB Graphic_Ellipse(BYVAL X1!, BYVAL Y1!, BYVAL X2!, BYVAL Y2!, BYVAL FillFlag&)
     IF App_GI& < App_GMax& THEN
          App_GI& = App_GI& +1
          App_GraphicTask(App_GI&).TaskID = %APP_GEllipse
          App_GraphicTask(App_GI&).Param1.D = X1!
          App_GraphicTask(App_GI&).Param2.D = Y1!
          App_GraphicTask(App_GI&).Param3.D = X2!
          App_GraphicTask(App_GI&).Param4.D = Y2!
          App_GraphicTask(App_GI&).Param5.L = FillFlag&
     END IF
END SUB

SUB Graphic_Paint(BYVAL X1!, BYVAL Y1!)
     IF App_GI& < App_GMax& THEN
          App_GI& = App_GI& +1
          App_GraphicTask(App_GI&).TaskID = %APP_GPaint
          App_GraphicTask(App_GI&).Param1.D = X1!
          App_GraphicTask(App_GI&).Param2.D = Y1!
     END IF
END SUB


SUB Graphic_LineTo(BYVAL X2!, BYVAL Y2!)
     IF App_GI& < App_GMax& THEN
          App_GI& = App_GI& +1
          App_GraphicTask(App_GI&).TaskID = %APP_GLine2
          App_GraphicTask(App_GI&).Param1.D = 0!
          App_GraphicTask(App_GI&).Param2.D = 0!
          App_GraphicTask(App_GI&).Param3.D = X2!
          App_GraphicTask(App_GI&).Param4.D = Y2!
     END IF
END SUB

SUB Graphic_CalcPoint(BYVAL X1!, BYVAL Y1!, BYVAL Length!, BYVAL Degrees&, RX!, RY!)
     LOCAL GScale!, DifX!, DifY!
     LOCAL AW!, AH!, AX1!, AY1!, AX2!, AY2!
     LOCAL PX1&, PY1&, L&, DG&, PRX&, PRY&
     GScale =  1000!
     EZ_StartCSect 3
     IF App_GraphicTask(-100).TaskID = %App_Start THEN
          AX1! = App_GraphicTask(-100).Param3.D
          AY1! = App_GraphicTask(-100).Param4.D
          AX2! = App_GraphicTask(-100).Param5.D
          AY2! = App_GraphicTask(-100).Param6.D
          DifX! = (AX2! - AX1!) / 2!
          DifY! = (AY2! - AY1!) / 2!
          PX1& = (X1! + DifX!) * GScale!
          PY1& = (Y1! + DifY!) * GScale!
          L& = Length! * GScale!
          EZ_CalcPoint PX1&, PY1&, L&, Degrees&, PRX&, PRY&
          RX! = (PRX& / GScale!) - DifX!
          RY! = (PRY& / GScale!) - DifY!
     ELSE
          RX!=0
          RY!=0
     END IF
     EZ_EndCSect 3
END SUB


SUB Graphic_Clear()
     IF App_GI& < App_GMax& THEN
          App_GI& = App_GI& +1
          App_GraphicTask(App_GI&).TaskID = %APP_GClear
     END IF
END SUB

SUB Graphic_Render()
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 100
     EZ_StartCSect 3
     App_GraphicTask(-100).TaskID = 0   ' clear flag so commands know draw cycle ends
     App_DrawCycleFlag& = 0
     EZ_EndCSect 3
END SUB

FUNCTION Graphic_GetAspectRatio() AS SINGLE
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 102
     FUNCTION = App_AspectRatio!
END FUNCTION

SUB Graphic_Show()
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 101
END SUB


SUB GRAPHIC_BACKCANVAS_Draw(BYVAL FMode&)
     LOCAL AFG&, ABG&, AFnt&, CW&, CH&, GScale!
     LOCAL DifX!, DifY!, X1&, Y1&, X2&, Y2&
     GScale! = 1000!
     AFG&=EZ_FG
     ABG&=EZ_BG
     AFnt&=EZ_Font
     SELECT CASE FMode&
          CASE 1    ' draw new Picture
               IF App_GraphicTask(-100).TaskID = %App_Start THEN
                    LOCAL AW!, AH!, AX1!, AY1!, AX2!, AY2!, I&, CT&, LastX2&, LastY2&, PW&
                    AW!  = App_GraphicTask(-100).Param1.D
                    AH!  = App_GraphicTask(-100).Param2.D
                    AX1! = App_GraphicTask(-100).Param3.D
                    AY1! = App_GraphicTask(-100).Param4.D
                    AX2! = App_GraphicTask(-100).Param5.D
                    AY2! = App_GraphicTask(-100).Param6.D
                    DifX! = (AX2! - AX1!) / 2!
                    DifY! = (AY2! - AY1!) / 2!
                    CW& = ABS(AW! * GScale!)
                    CH& = ABS(AH! * GScale!)
                    PW& = 1
                    EZ_StartDraw "GRAPHIC", %GRAPHIC_BACKCANVAS, CW&, CH&, ""
                    EZ_DefFont 99, "Arial", 768, "BVC"
                    FOR I&=1 TO App_GI&

                         SELECT CASE  AS CONST App_GraphicTask(I&).TaskID
                              CASE %App_GLine
                                   GOSUB CalcPoints
                                   EZ_CDraw %EZ_LINE, X1&, Y1&, X2&, Y2&, PW&, 0
                                   LastX2& = X2&
                                   LastY2& = Y2&
                              CASE %APP_GLine2
                                   GOSUB CalcPoints
                                   EZ_CDraw %EZ_LINE, LastX2&, LastY2&, X2&, Y2&, PW&, 0
                                   LastX2& = X2&
                                   LastY2& = Y2&
                              CASE %APP_GColor
                                   EZ_ColorRGB App_GraphicTask(I&).Param1.L, App_GraphicTask(I&).Param2.L
                              CASE %App_GColorEZ
                                   EZ_Color App_GraphicTask(I&).Param1.L, App_GraphicTask(I&).Param2.L
                              CASE %APP_GClear
                                   GOSUB CalcPointsXY
                                   EZ_CDraw %EZ_FLOODFILL, X1&, Y1&,0,0,1,1
                              CASE %APP_GPaint
                                   EZ_CDraw %EZ_FILL, 0,0, CW&, CH&,1,1
                              CASE %APP_GBox
                                   GOSUB CalcPoints
                                   EZ_CDraw %EZ_RECT, X1&, Y1&, X2&, Y2&, PW&, App_GraphicTask(I&).Param5.L
                              CASE %APP_GEllipse
                                   GOSUB CalcPoints
                                   EZ_CDraw %EZ_ELLIPSE, X1&, Y1&, X2&, Y2&, PW&, App_GraphicTask(I&).Param5.L
                              CASE %App_GBuffer
                                   EZ_CSelectBuffer App_GraphicTask(I&).Param1.L
                              CASE %App_GCopyBuffer
                                   EZ_CCopyBuffer App_GraphicTask(I&).Param1.L, App_GraphicTask(I&).Param2.L, 0
                              CASE %App_GPrint
                                   GOSUB CalcPointsXY
                                   EZ_UseFont 99
                                   EZ_CPrint X1&, Y1&, App_GraphicTask(I&).Param8
                              CASE ELSE
                         END SELECT
                    NEXT I&
                    EZ_EndDraw
                    EZ_FreeFont 99
                    IF EZ_IsControl("GRAPHIC", %GRAPHIC_BACKCANVAS, "VS") THEN
                         EZ_RedrawControl "GRAPHIC", %GRAPHIC_BACKCANVAS
                    END IF
               END IF

          CASE -1   ' draw initial Picture
               EZ_GetCanvasSize "GRAPHIC", %GRAPHIC_BACKCANVAS, CW&, CH&
               EZ_StartDraw "GRAPHIC", %GRAPHIC_BACKCANVAS, CW&, CH&, ""
               EZ_EndDraw
          CASE ELSE
     END SELECT
     EZ_Color AFG&, ABG&
     EZ_UseFont AFnt&
     EXIT SUB

CalcPoints:
X1& = INT((App_GraphicTask(I&).Param1.D + DifX!) * GScale!)
Y1& = INT((App_GraphicTask(I&).Param2.D + DifY!) * GScale!)
X2& = INT((App_GraphicTask(I&).Param3.D + DifX!) * GScale!)
Y2& = INT((App_GraphicTask(I&).Param4.D + DifY!) * GScale!)
RETURN

CalcPointsXY:
X1& = INT((App_GraphicTask(I&).Param1.D + DifX!) * GScale!)
Y1& = INT((App_GraphicTask(I&).Param2.D + DifY!) * GScale!)
RETURN

END SUB

SUB MAIN_MAINCANVAS_Draw(BYVAL FMode&)
     LOCAL AFG&, ABG&, AFnt&, CW&, CH&
     AFG&=EZ_FG
     ABG&=EZ_BG
     AFnt&=EZ_Font
     IF FMode&=-1 THEN     ' Initial Data
          CW&=800     ' emulate 8 inches by .01 inch units
          CH&=1050    ' emulate 10.5 inches by .01 inch units
          EZ_StartDraw "Main", %MAIN_MAINCANVAS, CW&, CH&, ""
          EZ_EndDraw
     END IF
     EZ_Color AFG&, ABG&
     EZ_UseFont AFnt&
END SUB

' ---------------------------------------------------------------------------------------------
'                           End of Graphic Command Set for Backend
' ---------------------------------------------------------------------------------------------

SUB MAIN_MAINCANVAS_Events( MyID&, CMsg&, CVal&, Cancel&)
     SELECT CASE CMsg&
          CASE %EZ_SelectCursor
               EZ_SetCursor "",7
               Cancel& = 1
          CASE %EZ_MouseMove
               LOCAL MyX&, MyY&
               ' use EZ_ConvertMousePos to convert to parent Forms coordinates
               MyX&=LOWRD(CVal&)
               MyY&=HIWRD(CVal&)
          CASE %EZ_MouseEnter
          CASE %EZ_MouseLeave
          CASE %EZ_RButtonUp
          CASE %EZ_Size
          CASE %EZ_FreeNow
          CASE %EZ_LButtonDC
          CASE %EZ_LButtonDown
          CASE %EZ_LButtonUp
          CASE %EZ_Sizing
          CASE %EZ_Redraw
          CASE %EZ_Loaded
          CASE %EZ_Click
          CASE ELSE
     END SELECT
END SUB

SUB EZ_GRAPHIC_Display(BYVAL FParent$)     ' (PROTECTED)
     App_AspectRatio! = 1!
     EZ_Color 0,99
     EZ_Form "GRAPHIC", FParent$, "Graphic Display", 0, 0, 104, 34, "_^CH"
     EZ_MaxByScreen "GRAPHIC", 8, 8
END SUB

SUB EZ_GRAPHIC_Design()     ' (PROTECTED)
     ' -----------------------------------------------
     EZ_Color 15, 0
     EZ_UseFont 4
     EZ_Canvas %GRAPHIC_BACKCANVAS, 0, 0, 104, 34, "+TH{DBUF}"
     GRAPHIC_BACKCANVAS_Draw -1
     ' -----------------------------------------------
     EZ_Color 15, 1
     EZ_UseFont 4
     EZ_AllowLoadingEvent 2
     EZ_UseAutoSize "VH"
     EZ_SubClass 2
     EZ_Canvas %GRAPHIC_FRONTCANVAS, 0, 0, 104, 34, "+T"
     EZ_SubClass 0
     ' -----------------------------------------------
END SUB


SUB EZ_GRAPHIC_ParseEvents(CID&, CMsg&, CVal&, Cancel&)     ' (PROTECTED)
     SELECT CASE CID&
          CASE %EZ_Window
               GRAPHIC_Events CID&, CMsg&, CVal&, Cancel&
          CASE  %GRAPHIC_FRONTCANVAS
               GRAPHIC_FRONTCANVAS_Events CID&, CMsg&, CVal&, Cancel&
          CASE ELSE
               GRAPHIC_Events CID&, CMsg&, CVal&, Cancel&
     END SELECT
END SUB

SUB GRAPHIC_Events(CID&, CMsg&, CVal&, Cancel&)
     SELECT CASE CID&
          CASE %EZ_Window
               SELECT CASE CMsg&
                    CASE %EZ_NoAutoSize
                         Cancel&=1
                    CASE %EZ_DragForm
                         Cancel&=1
                    CASE %EZ_Loading
                    CASE %EZ_Loaded
                    CASE %EZ_Started
                    CASE %EZ_Close
                         IF App_MainIsClosing& = 0 THEN
                              EZ_HideForm "{ME}"
                              Cancel& = 1
                         END IF
                    CASE ELSE
               END SELECT
          CASE ELSE
     END SELECT
END SUB

SUB GRAPHIC_FRONTCANVAS_Events( MyID&, CMsg&, CVal&, Cancel&)
     SELECT CASE CMsg&
          CASE %EZ_KeyUp
               IF CVal&=%EZK_ESC THEN EZ_UnloadForm "{ME}"
          CASE %EZ_Click
          CASE %EZ_DClick
          CASE %EZ_SelectCursor
               EZ_SetCursor "", 7
               Cancel& = 1
          CASE %EZ_MouseMove
               LOCAL MyX&, MyY&
               ' use EZ_ConvertMousePos to convert to parent Forms coordinates
               MyX&=LOWRD(CVal&)
               MyY&=HIWRD(CVal&)
          CASE %EZ_MouseEnter
          CASE %EZ_MouseLeave
          CASE %EZ_Size
          CASE %EZ_FreeNow
          CASE %EZ_LButtonDC
          CASE %EZ_LButtonDown
          CASE %EZ_LButtonUp
          CASE %EZ_Sizing
          CASE %EZ_Redraw
          CASE %EZ_Loaded
          CASE %EZ_Loading
          CASE ELSE
     END SELECT
END SUB
SUB SETUPFORM_Thread1Events(BYVAL FormName$, BYVAL CID&, BYVAL CMsg&, CVal&, Cancel&)
     LOCAL STM&
     SELECT CASE CMsg&
          CASE %EZ_ThreadCode     ' Non-GUI Thread Code
               ' Cancel&=0      ' prevents %EZ_Thread event
          CASE %EZ_Thread         ' GUI Thread Code
          CASE %EZ_Started        ' Start Thread !
               STM&=10             ' millisecond delay
               EZ_StartThread FormName$, CID&, STM&
          CASE %EZ_Close          ' Terminate Thread when form closes !
               EZ_CloseThread FormName$, CID&
          CASE ELSE
     END SELECT
END SUB
SUB SETUPFORM_XSTART_Events( MyID&, CMsg&, CVal&, Cancel&)
     SELECT CASE CMsg&
          CASE %EZ_Change
          CASE %EZ_KeyDown
          CASE %EZ_LButtonDown
          CASE %EZ_Loaded
          CASE ELSE
     END SELECT
END SUB

SUB SETUPFORM_XEND_Events( MyID&, CMsg&, CVal&, Cancel&)
     SELECT CASE CMsg&
          CASE %EZ_Change
          CASE %EZ_NoFocus
          CASE ELSE
     END SELECT
END SUB

SUB SETUPFORM_YSTART_Events( MyID&, CMsg&, CVal&, Cancel&)
     SELECT CASE CMsg&
          CASE %EZ_Change
          CASE ELSE
     END SELECT
END SUB

SUB SETUPFORM_YEND_Events( MyID&, CMsg&, CVal&, Cancel&)
     SELECT CASE CMsg&
          CASE %EZ_Change
          CASE ELSE
     END SELECT
END SUB

SUB SETUPFORM_XINDEX_Events( MyID&, CMsg&, CVal&, Cancel&)
     SELECT CASE CMsg&
          CASE %EZ_Change
          CASE ELSE
     END SELECT
END SUB

SUB SETUPFORM_YINDEX_Events( MyID&, CMsg&, CVal&, Cancel&)
     SELECT CASE CMsg&
          CASE %EZ_Change
          CASE ELSE
     END SELECT
END SUB

SUB SETUPFORM_XSPEED_Events( MyID&, CMsg&, CVal&, Cancel&)
     SELECT CASE CMsg&
          CASE %EZ_Change
          CASE ELSE
     END SELECT
END SUB

SUB SETUPFORM_YSPEED_Events( MyID&, CMsg&, CVal&, Cancel&)
     SELECT CASE CMsg&
          CASE %EZ_Change
          CASE ELSE
     END SELECT
END SUB

SUB SETUPFORM_XPOS_Events( MyID&, CMsg&, CVal&, Cancel&)

     SELECT CASE CMsg&
          CASE %EZ_Change
          CASE %EZ_KEYDOWN
              IF CVal&=27 THEN
                  guimsgbox "Hello"

          CASE ELSE
     END SELECT
END SUB

SUB SETUPFORM_YPOS_Events( MyID&, CMsg&, CVal&, Cancel&)
     SELECT CASE CMsg&
          CASE %EZ_Change
          CASE ELSE
     END SELECT
END SUB

SUB SETUPFORM_XCTIN_Events( MyID&, CMsg&, CVal&, Cancel&)
     SELECT CASE CMsg&
          CASE %EZ_Change
          CASE ELSE
     END SELECT
END SUB

SUB SETUPFORM_YCTIN_Events( MyID&, CMsg&, CVal&, Cancel&)
     SELECT CASE CMsg&
          CASE %EZ_Change
          CASE ELSE
     END SELECT
END SUB

SUB SETUPFORM_XPLUSMIN_Events( MyID&, CMsg&, CVal&, Cancel&)
     SELECT CASE CMsg&
          CASE %EZ_Change
          CASE ELSE
     END SELECT
END SUB

SUB SETUPFORM_YPLUSMIN_Events( MyID&, CMsg&, CVal&, Cancel&)
     SELECT CASE CMsg&
          CASE %EZ_Change
          CASE ELSE
     END SELECT
END SUB

SUB SETUPFORM_INDEX_Events( MyID&, CMsg&, CVal&, Cancel&)
     SELECT CASE CMsg&
          CASE %EZ_Change
          CASE ELSE
     END SELECT
END SUB

SUB SETUPFORM_IDXHL_Events( MyID&, CMsg&, CVal&, Cancel&)
     SELECT CASE CMsg&
          CASE %EZ_Change
          CASE ELSE
     END SELECT
END SUB

SUB SETUPFORM_XONOFF_Events( MyID&, CMsg&, CVal&, Cancel&)
     SELECT CASE CMsg&
          CASE %EZ_Change
          CASE ELSE
     END SELECT
END SUB

SUB SETUPFORM_YONOFF_Events( MyID&, CMsg&, CVal&, Cancel&)
     SELECT CASE CMsg&
          CASE %EZ_Change
          CASE ELSE
     END SELECT
END SUB

SUB SETUPFORM_AUTOHD_Events( MyID&, CMsg&, CVal&, Cancel&)
     SELECT CASE CMsg&
          CASE %EZ_Change
          CASE ELSE
     END SELECT
END SUB

SUB SETUPFORM_DUALRAS_Events( MyID&, CMsg&, CVal&, Cancel&)
     SELECT CASE CMsg&
          CASE %EZ_Change
          CASE %EZ_Loaded
          CASE ELSE
     END SELECT
END SUB

SUB SETUPFORM_OVERLAP_Events( MyID&, CMsg&, CVal&, Cancel&)
     SELECT CASE CMsg&
          CASE %EZ_Change
          CASE ELSE
     END SELECT
END SUB

SUB SETUPFORM_APOS_Events( MyID&, CMsg&, CVal&, Cancel&)
     SELECT CASE CMsg&
          CASE %EZ_Change
          CASE ELSE
     END SELECT
END SUB

SUB SETUPFORM_ACTIN_Events( MyID&, CMsg&, CVal&, Cancel&)
     SELECT CASE CMsg&
          CASE %EZ_Change
          CASE ELSE
     END SELECT
END SUB

SUB SETUPFORM_CALBTN_Events( MyID&, CMsg&, CVal&, Cancel&)
     SELECT CASE CMsg&
          CASE %EZ_Click
          CASE ELSE
     END SELECT
END SUB

#IF %RealBackEnd
     #INCLUDE "realbackend.inc"
#ELSE
     #INCLUDE "backend.inc"
#ENDIF
' put all my code before backend include file so it is accessable to it.
