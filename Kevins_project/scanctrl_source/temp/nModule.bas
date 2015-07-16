#DIM ALL

SUB Graphic_Color (BYVAL ForeColor&, BYVAL BackColor&)
    GRAPHIC COLOR ForeColor&, BackColor&
END SUB

SUB Graphic_Clear()
    GRAPHIC CLEAR
END SUB

SUB Graphic_Scale(BYVAL X1 AS DOUBLE, BYVAL Y1 AS DOUBLE, BYVAL X2 AS DOUBLE, BYVAL Y2 AS DOUBLE)
    GRAPHIC SCALE(X1,Y1)-(X2,Y2)
END SUB


SUB Graphic_Line (BYVAL X1 AS DOUBLE, BYVAL Y1 AS DOUBLE, BYVAL X2 AS DOUBLE, BYVAL Y2 AS DOUBLE, BYVAL RGBColor&)
    GRAPHIC LINE (X1,Y1)-(X2,Y2), RGBColor&
    GRAPHIC SET PIXEL (X2, Y2), RGBColor&
END SUB

SUB Graphic_LineX (BYVAL X1 AS DOUBLE, BYVAL Y1 AS DOUBLE, BYVAL X2 AS DOUBLE, BYVAL Y2 AS DOUBLE, BYVAL RGBColor&)
    GRAPHIC LINE (X1,Y1)-(X2,Y2), RGBColor&
END SUB

SUB Graphic_Width(BYVAL LineWidth&)
    GRAPHIC WIDTH LineWidth&
END SUB

SUB Graphic_Paint(BYVAL X1 AS DOUBLE, BYVAL Y1 AS DOUBLE, BYVAL FillColor&, BYVAL BorderColor&)
    GRAPHIC PAINT (X1,Y1), FillColor&, BorderColor&
END SUB

SUB Graphic_Ellipse(BYVAL X1 AS DOUBLE, BYVAL Y1 AS DOUBLE, BYVAL X2 AS DOUBLE, BYVAL Y2 AS DOUBLE, BYVAL LineColor&)
    GRAPHIC ELLIPSE (X1,Y1)-(X2,Y2), LineColor&
END SUB

SUB Graphic_Print(BYVAL X1 AS DOUBLE, BYVAL Y1 AS DOUBLE, BYVAL T$)
    GRAPHIC SET POS (X1,Y1)
    GRAPHIC PRINT T$
END SUB

SUB GUI_Print(BYVAL T$)
    PRINT T$
END SUB

SUB Graphic_Redraw(BYVAL ContinueFlag&)
    ' ContinueFlag& ignored in DDT version
    GRAPHIC REDRAW
END SUB

SUB Graphic_Style(BYVAL GStyle&)
    GRAPHIC STYLE GStyle&
END SUB

SUB Graphic_Render()
     ' ignored in DDT version
END SUB

GLOBAL App_hWin AS DWORD
GLOBAL App_hBitmap AS DWORD

SUB Graphic_Font(BYVAL N&)
    SELECT CASE N&
        CASE 12
            GRAPHIC FONT "Times New Roman", 12, 1
        CASE 20
            GRAPHIC FONT "Times New Roman", 20, 1
        CASE ELSE
            GRAPHIC FONT "Times New Roman", 10, 1
    END SELECT
END SUB


SUB Graphic_Attach(BYVAL AMode&, BYVAL RedrawMode&)
    ' mode 0 is Graphic control
    ' mode 1 is bitmap buffer
    SELECT CASE AMode&
        CASE 0
            IF RedrawMode& THEN
                GRAPHIC ATTACH App_hWin, 0, REDRAW
            ELSE
                GRAPHIC ATTACH App_hWin, 0
            END IF
        CASE 1
                GRAPHIC ATTACH App_hBitmap, 0
        CASE ELSE
    END SELECT
END SUB

SUB Graphic_Copy()
    GRAPHIC COPY App_hBitmap, App_hWin
END SUB

#INCLUDE "nModule.inc

'  Each Canvas should have two buffers 1 will be treated as the Graphic Window, 2 will be treated as the Bitmap for drawing
'  Allow drawing into any Canvas



FUNCTION PBMAIN
    ' RunScan 1,0 .... means GENERATE AXIAL SCAN PATH SEGMENTS  - Raster Axial FALSE
    ' RunScan 2,0 .... means GENERATE CIRC SCAN PATH SEGMENTS  - Raster Axial FALSE
    ' RunScan 1,1 .... means GENERATE AXIAL SCAN PATH SEGMENTS  - Raster Axial TRUE
    ' RunScan 2,1 .... means GENERATE CIRC SCAN PATH SEGMENTS  - Raster Axial TRUE
    LOCAL W&, H&
    W& = 1800
    H& = 1000

    ' WE don't create the Graphic window or bitmap in scanner code since GUI already creates them
    GRAPHIC WINDOW "NOZZLE 'Top View'", 10, 10, W&, H& TO App_hWin   'Create a graphic window and assign it a handle
    GRAPHIC ATTACH App_hWin, 0
    GRAPHIC SET FOCUS
    GRAPHIC BITMAP NEW W&, H& TO App_hBitmap 'bitmap window for current nozzle weld scan model



    RunScan  2, 1, W&, H&, 0.04!

    BEEP

    PRINT "WAITKEY$"

    WAITKEY$

    ' Cleanup Graphic window and bitmap (not needed in real app since app will do this)

    'Close and exit all windows
    GRAPHIC ATTACH App_hWin, 0&  'select the STANDARD Graphics window
    GRAPHIC WINDOW END          'close the selected STANDARD Graphics window

    GRAPHIC ATTACH App_hBitmap, 0&  'select the Memory Bitmap Graphics window
    GRAPHIC BITMAP END          'close the selected Memory Bitmap Graphics window


END FUNCTION
