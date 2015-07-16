' DDT commands still to replace







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
'                    EZ_ShowC "GRAPHIC", %GRAPHIC_FRONTCANVAS, %GRAPHIC_FRONTCANVAS
                    EZ_ResizeC "GRAPHIC", %GRAPHIC_BACKCANVAS, 0,0, EZ_CX(BWidth&), EZ_CY(BHeight&)
               ELSE
                    ' Canvas fits inside Form
                    X& = (W! - BWidth&)/2
                    Y& = (H! - BHeight&)/2
                    EZ_ResizeC "GRAPHIC", %GRAPHIC_BACKCANVAS, EZ_CX(X&),EZ_CY(Y&), EZ_CX(BWidth&), EZ_CY(BHeight&)
                    EZ_ShowC "GRAPHIC", %GRAPHIC_BACKCANVAS, %GRAPHIC_BACKCANVAS
'                    EZ_HideC "GRAPHIC", %GRAPHIC_FRONTCANVAS, %GRAPHIC_FRONTCANVAS
               END IF
          CASE ELSE
     END SELECT
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
'               IF EZ_IsControl("GRAPHIC",%GRAPHIC_FRONTCANVAS, "V") THEN
'                    DestForm$ = "GRAPHIC"
'                    DestID& = %GRAPHIC_FRONTCANVAS
'                    GOSUB DrawBuffer
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


SUB Graphic_SelectBuffer(BYVAL BufferNumber&)
     IF App_GI& < App_GMax& THEN
          IF BufferNumber& = 1 OR BufferNumber& = 2 THEN
               App_GI& = App_GI& +1
               App_GraphicTask(App_GI&).TaskID = %App_GBuffer
               App_GraphicTask(App_GI&).Param1.L = BufferNumber&
          END IF
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




FUNCTION Graphic_GetAspectRatio() AS SINGLE
     EZ_SendThreadEvent App_MainHandle&, %MAIN_FakeID, 102
     FUNCTION = App_AspectRatio!
END FUNCTION
