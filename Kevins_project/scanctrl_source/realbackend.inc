MACRO CONST = MACRO
'misc const values
CONST ENABLE =  1
CONST DISABLE = 0

FUNCTION BackEndThreadFunc(BYVAL IFlag&) AS LONG
     ' =====================================================================
     IF IFlag&=0 THEN EXIT FUNCTION     ' only run this code once in thread
     ' =====================================================================
     LOCAL Control_ID&, CMsg&, CVal&, RV$, V#, CurrentTime AS EXTENDED, TimeSpan AS EXTENDED, KeyVal&, WhichCanvas&
     STATIC ScanningFlag&, ScanCount&, ScanTime AS EXTENDED

     ' Variables for drawing code
     LOCAL DG&, RX!, RY!, CircleDiam!
     LOCAL ySCRN&, xSCRN&, PlotClr&, ForeClr&,BackClr&
     LOCAL yScrn1!, xScrn1!, yScrn2!, xScrn2! , PixPerInch!
      ' Atco Variables
     LOCAL myoffset AS LONG
     LOCAL tempx1, tempx2, tempy1, tempy2 AS DOUBLE
     LOCAL tempSx1, tempSx2, tempSy1, tempSy2 AS SINGLE

     ' Initialize everything here before DO LOOP
     ScanningFlag& = 0 ' default not scanning


     ' set default values for Motor ON/OFF buttons
     GUISetXMotor 1
     GUISetYMotor 1
     GUISetRMotor 1
     ' set default state Polar or Cartesian
     GUISetPolarCartesian 1
     ' set default state Continuous or Step
     GUISetContinuousStep 1
     ' set default values for X,Y,R Position textboxes
     GUISetXPos  0.98#
     GUISetYPos  0.97#
     GUISetRPos  0.96#
     ' set default min,max and position for Jog rate TrackBar
     GUISetTrackBar 0, 200, 10
     ' set default text for Jog rate
     GUISetJogText "10"
     ' define some of the extra buttons
     GUISetButton 1, "Show Graphic"
     GUISetButton 2, "Draw Bitmap"
     GUISetButton 3, "Animate Small"
     GUISetButton 4, "Animate Big"
     ' disable scan stop button since no scanning yet
     GUI_STOPSCAN 0
     WhichCanvas& = 1
        'wlc
     OPEN EZ_AppPath+"axscan.dat" FOR BINARY AS #1 BASE = 0
     myoffset = 0
     ' disable scan stop button since no scanning yet
     DO
          ' ----------------------------------------
          GUIGetUserInput Control_ID&, CMsg&, CVal&
          ' ----------------------------------------
          IF Control_ID& <> %GUINoInput THEN    ' make sure some input has occurred
          ' ----------------------------------------
               ' ------------------------------------------
               ' Test for Key Events
               ' ------------------------------------------
               KeyVal& = GUICheckKey(CMsg&, CVal&)
               IF KeyVal& <> 0 THEN
                    ' do something with keys
                    ' KeyVal& has Key value in it (see EZGUI key constants in ezgui50.inc)
                    ' CMsg& has EZGUI event (%EZ_KeyPress, %EZ_KeyDown, %EZ_KeyUp) or (%EZ_SysKeyPress, %EZ_SysKeyDown, %EZ_SysKeyUp)
                    ' Control_ID& has ID of control which has focus and gets key event
                    ' Remember that controls will still get the keys no matter what you do here
                    SELECT CASE KeyVal&
                         CASE %EZK_ENTER
                              GUIPrintStatus "Enter - " + GUIEventName(CMsg&) + "   ID =" + STR$(Control_ID&)
                         CASE %EZK_ESC
                              GUIPrintStatus "ESC - " + GUIEventName(CMsg&) + "   ID =" + STR$(Control_ID&)
                         CASE %EZK_END
                              GUIPrintStatus "End - " + GUIEventName(CMsg&) + "   ID =" + STR$(Control_ID&)
                         CASE %EZK_HOME
                              GUIPrintStatus "Home - " + GUIEventName(CMsg&) + "   ID =" + STR$(Control_ID&)
                         CASE ELSE
                    END SELECT
               END IF
               ' ------------------------------------------
               SELECT CASE Control_ID&
                    ' -------------------------------------
                    ' Main Form events
                    ' -------------------------------------
                    CASE 0    ' Forms ID
                         IF CMsg&=%EZ_Close THEN
                              GUISetClose
                              EXIT LOOP
                         END IF
                    ' -------------------------------------
                    ' Main Canvas events
                    ' -------------------------------------
                    CASE %MAIN_MAINCANVAS
                    ' -------------------------------------
                    ' Jog Rotation control event
                    ' -------------------------------------
                    CASE %MAIN_CANVASJOGCONTROL
                    ' -------------------------------------
                    ' Scan Setting Buttons
                    ' -------------------------------------
                    CASE %MAIN_BUTTONXPOS
                         IF CMsg&=%EZ_Click THEN
                              RV$ = GUIShowInputBox("Enter new X Position")
                              IF RV$ <> "" THEN
                                   V# = VAL(RV$)
                                   GUISetXPos V#
                                   ' ----------------
                                   ' alternate method
                                   ' ----------------
                                   ' GUISetXText RV$
                              END IF
                         END IF
                    CASE %MAIN_BUTTONXONOFF
                         IF CMsg&=%EZ_Click THEN
                              GUIPrintStatus "Click X ON/OFF"
                         END IF
                    CASE %MAIN_BUTTONYPOS
                         IF CMsg&=%EZ_Click THEN
                              RV$ = GUIShowInputBox("Enter new Y Position")
                              IF RV$ <> "" THEN
                                   V# = VAL(RV$)
                                   GUISetYPos V#
                                   ' ----------------
                                   ' alternate method
                                   ' ----------------
                                   ' GUISetYText RV$
                              END IF
                         END IF
                    CASE %MAIN_BUTTONYONOFF
                         IF CMsg&=%EZ_Click THEN
                              GUIPrintStatus "Click Y ON/OFF
                         END IF
                    CASE %MAIN_BUTTONRPOS
                         IF CMsg&=%EZ_Click THEN
                              RV$ = GUIShowInputBox("Enter new R Position")
                              IF RV$ <> "" THEN
                                   V# = VAL(RV$)
                                   GUISetRPos V#
                                   ' ----------------
                                   ' alternate method
                                   ' ----------------
                                   ' GUISetRText RV$
                              END IF
                         END IF
                    CASE %MAIN_BUTTONRONOFF
                         IF CMsg&=%EZ_Click THEN
                              GUIPrintStatus "Click R ON/OFF"
                         END IF
                    CASE %MAIN_BUTTONPOLAR
                         IF CMsg&=%EZ_Click THEN
                              GUIPrintStatus "Click Polar"
                         END IF
                    CASE %MAIN_BUTTONCARTESIAN
                         IF CMsg&=%EZ_Click THEN
                              GUIPrintStatus "Click Cartesian"
                         END IF
                    CASE %MAIN_BUTTONALLPOS
                         IF CMsg&=%EZ_Click THEN
                              RV$ = GUIShowInputBox("Enter new Position for All")
                              IF RV$ <> "" THEN
                                   V# = VAL(RV$)
                                   GUISetXPos V#
                                   GUISetYPos V#
                                   GUISetRPos V#
                                   ' ----------------
                                   ' alternate method
                                   ' ----------------
                                   ' GUISetXText RV$
                                   ' GUISetYText RV$
                                   ' GUISetRText RV$
                              END IF
                         END IF
                    CASE %MAIN_BUTTONALLOFF
                         IF CMsg&=%EZ_Click THEN
                              GUISetXMotor 0
                              GUISetYMotor 0
                              GUISetRMotor 0
                         END IF
                    CASE %MAIN_BUTTONALLON
                         IF CMsg&=%EZ_Click THEN
                              GUISetXMotor 1
                              GUISetYMotor 1
                              GUISetRMotor 1
                         END IF
                    CASE %MAIN_BUTTONGOSCAN
                         IF CMsg&=%EZ_Click THEN
                              GUIPrintStatus "SCANNING Now!"
                              ScanCount& = 0
                              ScanningFlag& = 1
                              GUI_GOSCAN 0   ' disable Scan button while scanning
                              GUI_STOPSCAN 1 ' enable Stop Scan button
                              ScanTime = EZ_GetPTime ' this function should be Thread safe
                         END IF
                    CASE %MAIN_BUTTONEXTRASCAN
                         IF CMsg&=%EZ_Click THEN
                              GUIPrintStatus "Click Button Extra Scan"
                         END IF
                    CASE %MAIN_BUTTONSTOPSCAN
                         IF CMsg&=%EZ_Click THEN
                              IF ScanningFlag& <> 0 THEN
                                   ScanCount& = 0
                                   GUI_GOSCAN 1   ' Enable Scan button while scanning
                                   GUI_STOPSCAN 0 ' Disable Stop Scan button
                                   ScanningFlag& = 0
                                   GUIPrintStatus "SCAN Terminated!"
                              END IF
                         END IF
                    ' -------------------------------------
                    ' Jog Rate Buttons
                    ' -------------------------------------
                    CASE %MAIN_BUTTONJOGYPLUS
                         IF CMsg&=%EZ_Click THEN
                              GUIPrintStatus "Click JOG Y+"
                         END IF
                    CASE %MAIN_BUTTONJOGXMINUS
                         IF CMsg&=%EZ_Click THEN
                              GUIPrintStatus "Click JOG X-"
                         END IF
                    CASE %MAIN_BUTTONJOGXPLUS
                         IF CMsg&=%EZ_Click THEN
                              GUIPrintStatus "Click JOG X+"
                         END IF
                    CASE %MAIN_BUTTONJOGYMINUS
                         IF CMsg&=%EZ_Click THEN
                              GUIPrintStatus "Click JOG Y-"
                         END IF
                    CASE %MAIN_BUTTONJOGRPLUS
                         IF CMsg&=%EZ_Click THEN
                              GUIPrintStatus "Click JOG R+"
                         END IF
                    CASE %MAIN_BUTTONJOGRMINUS
                         IF CMsg&=%EZ_Click THEN
                              GUIPrintStatus "Click JOG R-"
                         END IF
                    CASE %MAIN_TRACKBARJOGRATE
                         IF CMsg&=%EZ_Change THEN
                              GUIPrintStatus "JOG TrackBar value "+STR$(CVal&)
                         END IF
                    CASE %MAIN_BUTTONJOGCONT
                         IF CMsg&=%EZ_Click THEN
                              GUIPrintStatus "Click JOG Continuous"
                         END IF
                    CASE %MAIN_BUTTONJOGSTEP
                         IF CMsg&=%EZ_Click THEN
                              GUIPrintStatus "Click JOG Step"
                         END IF
                    ' -------------------------------------
                    ' Extra Buttons
                    ' -------------------------------------
                    CASE 1    ' Extra Button 1
                         IF CMsg&=%EZ_Click THEN
                              Graphic_Show   ' Show Graphic Window above MAIN form
                         END IF
                    CASE 2    ' Extra Button 2
                         IF CMsg&=%EZ_Click THEN
                              GOSUB TestDrawBitmap
                         END IF
                    CASE 3    ' Extra Button 3
                         WhichCanvas& = 1
                         GOSUB TestAnimate
                    CASE 4    ' Extra Button 4
                         WhichCanvas& = 2
                         GOSUB TestAnimate
'                    Add Extra Buttons as you need them using ID's 2 to 18
                    CASE ELSE
                         GUIPrintStatus "Control ID: "+STR$(Control_ID&)+"  Control Message: "+STR$(CMsg&)+"  Value: "+STR$(CVal&)
               END SELECT
          ' ----------------------------------------
          ELSE ' no user input occurred so do something else
          ' ----------------------------------------
               IF ScanningFlag&<>0 THEN ' scanning is ON
                    ' do your scanning here
                    CurrentTime = EZ_GetPTime ' this function should be thread safe
                    IF ScanTime > CurrentTime THEN ScanTime = EZ_GetPTime ' clock has flipped back to zero
                    TimeSpan = CurrentTime - ScanTime
                    IF TimeSpan >= 0.03125## THEN ' this allows timing of GUI output to 1/32 second intervals
                         ScanCount& = ScanCount& +1
                         IF ScanCount& > 2000000000 THEN ScanCount& = 0
                         ScanTime = CurrentTime
                         GUIPrintStatus "Counting: "+STR$(ScanCount&)
                    END IF
                    ' do your hardware scanning here
               END IF
          ' ----------------------------------------
          END IF
     LOOP
     FUNCTION=0
     EXIT FUNCTION



TestDrawBitmap:
yScrn& = 1200
xScrn& = 800

PixPerInch! = 0.04!
yScrn1! = -(ySCRN& * .400! * PixPerInch!): yScrn2! = ySCRN& * .400! * PixPerInch!
xScrn1! = -(xSCRN& * .400! * PixPerInch!): xScrn2! = xSCRN& * .400! * PixPerInch!


PlotClr& = 15  ' white  DOS color index
BackClr& = 0   ' black DOS color index
ForeClr& = PlotClr&

Graphic_Bitmap ySCRN&, xSCRN& ' call before drawing

Graphic_Scale yScrn1!, xScrn1!, yScrn2!, xScrn2!, 1000 ' last parameter defines stack size for number of Graphic calls allowed
' Graphic Scale must come before all other commands, except Graphic_Bitmap

' Draw into Buffer 2 and we will copy it later
Graphic_SelectBuffer 2
Graphic_Color ForeClr&, BackClr&
Graphic_Clear
CircleDiam! = xScrn2! * 0.95!
FOR DG& = 0 TO 360 STEP 2
     Graphic_CalcPoint 0!,0!, CircleDiam!, DG&, RX!, RY!
     IF DG& <> 0 THEN
          Graphic_Color ForeClr&,BackClr&       ' set colors to light yellow on black
          Graphic_LineTo RX!, RY!  ' add outside of circle line
     END IF
     Graphic_Color ForeClr&, BackClr&   ' set colors to light blue on black
     Graphic_Line 0!,0!, RX!, RY!  ' draw radius line
NEXT DG&
Graphic_Print yScrn1!, 0, "Hello There !"
Graphic_Render
RETURN



TestAnimate:
yScrn& = 1200
xScrn& = 800

PixPerInch! = 0.04!
yScrn1! = -(ySCRN& * .400! * PixPerInch!): yScrn2! = ySCRN& * .400! * PixPerInch!
xScrn1! = -(xSCRN& * .400! * PixPerInch!): xScrn2! = xSCRN& * .400! * PixPerInch!


PlotClr& = 15  ' white  DOS color index
BackClr& = 0   ' black DOS color index
ForeClr& = PlotClr&
LOCAL BoxColor&
BoxColor& = 4  ' red

' do not call Graphic_Bitmap since Graphic was already sized in previous routine

LOCAL BX!, BY!, BW!
BW! = xScrn2! / 8!
BY! = 0! - (BW!/2)

IF WhichCanvas& =  2 THEN
     Graphic_Show
END IF


'' LOCAL CT&, T1 AS EXTENDED, T2 AS EXTENDED, T$
'' CT&=0
'' T1=EZ_GetPTime
'FOR BX!=yScrn1! TO (yScrn2!-BW!) STEP (BW!/8)
''     CT&=CT&+1
'     Graphic_Scale yScrn1!, xScrn1!, yScrn2!, xScrn2!, 1000 ' last parameter defines stack size for number of Graphic calls allowed
'     Graphic_CopyBuffer 2,1   ' copy Buffer 2 to 1. 1 is front buffer and visible
'     Graphic_SelectBuffer 1
'     Graphic_Color ForeClr&, BoxColor&
'     Graphic_Box BX!, BY!, BX!+BW!, BY!+BW!,1
'     Graphic_Render
'     Graphic_Copy WhichCanvas&
'NEXT BX!
'' T2=EZ_GetPTime
'' T$=FORMAT$(CT&/(T2-T1), "000.00")+" fps"
'' GUIMsgBox T$

WHILE ISFALSE EOF(1)


        Graphic_Scale yScrn1!, xScrn1!, yScrn2!, xScrn2!, 1000 ' last parameter defines stack size for number of Graphic calls allowed
        Graphic_CopyBuffer 2,1   ' copy Buffer 2 to 1. 1 is front buffer and visible
        Graphic_SelectBuffer 1
        Graphic_Color ForeClr&, BoxColor&

  'draw transducer sides x4 (rectangle)
        GET  #1, myoffset,  tempy1
        myoffset = myoffset + 8
        GET  #1, myoffset,  tempx1
        myoffset = myoffset + 8
        GET  #1, myoffset,  tempy2
        myoffset = myoffset + 8
        GET  #1, myoffset,  tempx2
        myoffset = myoffset + 8
       'GRAPHIC LINE(tempy1,tempx1)-(tempy2,tempx2),clr1&
        graphic_line tempy1, tempx1, tempy2, tempx2
        GET  #1, myoffset,  tempy1
        myoffset = myoffset + 8
        GET  #1, myoffset,  tempx1
        myoffset = myoffset + 8
        GET  #1, myoffset,  tempy2
        myoffset = myoffset + 8
        GET  #1, myoffset,  tempx2
        myoffset = myoffset + 8
'       'GRAPHIC LINE(tempy1,tempx1)-(tempy2,tempx2),clr1&
        graphic_line tempy1, tempx1, tempy2, tempx2

        GET  #1, myoffset,  tempy1
        myoffset = myoffset + 8
        GET  #1, myoffset,  tempx1
        myoffset = myoffset + 8
        GET  #1, myoffset,  tempy2
        myoffset = myoffset + 8
        GET  #1, myoffset,  tempx2
        myoffset = myoffset + 8

        'GRAPHIC LINE(tempy1,tempx1)-(tempy2,tempx2),clr1&
        graphic_line tempy1, tempx1, tempy2, tempx2

        GET  #1, myoffset,  tempy1
        myoffset = myoffset + 8
        GET  #1, myoffset,  tempx1
        myoffset = myoffset + 8
        GET  #1, myoffset,  tempy2
        myoffset = myoffset + 8
        GET  #1, myoffset,  tempx2
        myoffset = myoffset + 8

        'GRAPHIC LINE(tempy1,tempx1)-(tempy2,tempx2),clr1&
        graphic_line tempy1, tempx1, tempy2, tempx2
        'make sure all (4) corners of the rectangle are sealed before calling GRAPHIC PAINT, otherwise paint leaks out everywhere!!
        GET  #1, myoffset,  tempy1
        myoffset = myoffset + 8
        GET  #1, myoffset,  tempx1
        myoffset = myoffset + 8

        'GRAPHIC SET PIXEL (tempy1,tempx1),clr1&

        GET  #1, myoffset,  tempy1
        myoffset = myoffset + 8
        GET  #1, myoffset,  tempx1
        myoffset = myoffset + 8

        'GRAPHIC SET PIXEL (tempy1,tempx1),clr1&

        GET  #1, myoffset,  tempy1
        myoffset = myoffset + 8
        GET  #1, myoffset,  tempx1
        myoffset = myoffset + 8

        'GRAPHIC SET PIXEL (tempy1,tempx1),clr1&

        GET  #1, myoffset,  tempy1
        myoffset = myoffset + 8
        GET  #1, myoffset,  tempx1
        myoffset = myoffset + 8

        'GRAPHIC SET PIXEL (tempy1,tempx1),clr1&

        GET  #1, myoffset,  tempy1
        myoffset = myoffset + 8
        GET  #1, myoffset,  tempx1
        myoffset = myoffset + 8
        Graphic_Color 4, 8
        'GRAPHIC PAINT (tempy1, tempx1), %RGB_ORANGE, clr1&
        'graphic_paint tempy1,tempx1

        Graphic_Color ForeClr&, BoxColor&

        GET  #1, myoffset,  tempSy1
        myoffset = myoffset + 4
        GET  #1, myoffset,  tempSx1
        myoffset = myoffset + 4
        GET  #1, myoffset,  tempSy2
        myoffset = myoffset + 4
        GET  #1, myoffset,  tempSx2
        myoffset = myoffset + 4


        'GRAPHIC LINE(tempSy1,tempSx1)-(tempSy2,tempSx2),clr1&  'RGB_WHITE 'LIGHTGOLDENRODYELLOW '%RGB_GHOSTWHITE 'draw line on HALO
        graphic_line tempSy1, tempSx1, tempSy2, tempSx2

        GET  #1, myoffset,  tempSy1
        myoffset = myoffset + 4
        GET  #1, myoffset,  tempSx1
        myoffset = myoffset + 4
        GET  #1, myoffset,  tempSy2
        myoffset = myoffset + 4
        GET  #1, myoffset,  tempSx2
        myoffset = myoffset + 4

        'GRAPHIC LINE(tempSy1,tempSx1)-(tempSy2,tempSx2),clr1&
        graphic_line tempSy1, tempSx1, tempSy2, tempSx2

        GET  #1, myoffset,  tempSy1
        myoffset = myoffset + 4
        GET  #1, myoffset,  tempSx1
        myoffset = myoffset + 4
        GET  #1, myoffset,  tempSy2
        myoffset = myoffset + 4
        GET  #1, myoffset,  tempSx2
        myoffset = myoffset + 4
'
        'GRAPHIC ELLIPSE (tempSy1,tempSx1)-(tempSy2,tempSx2), %RGB_WHITE, -1 'orange, -1 '%WHITE, -1 'clr1&
        Graphic_Ellipse tempSy1,tempSx1, tempSy2, tempSx2, 9
        Graphic_Render
        Graphic_Copy WhichCanvas&

'        Graphic_Print yScrn1!, 0, "Hello There !"
        EZ_Delay 0.0125!

WEND
CLOSE #1
RETURN


END FUNCTION
