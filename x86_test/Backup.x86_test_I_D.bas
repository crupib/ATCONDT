#COMPILE EXE
#DIM ALL

FUNCTION PBMAIN () AS LONG

    'Check_bLUT
    'Check_nLUT

    'Check_eLUT

    'Check_vLUT
    'Check_pLUT

    'end


    '*******************************************************************************************
    '  THIS CODE RUNS ONE TIME AT BEGINNING OF PROGRAM
    '*******************************************************************************************

    LOCAL PathCycles,PathCnts, pCycle, pCnt  AS LONG

    LOCAL Stp AS DOUBLE

    LOCAL Timer1Clk AS LONG ', PathOff, pCycle, PathNext AS LONG

    LOCAL Ctr, lCtr, cn AS LONG 'loop counters

    LOCAL PathOff, PathNext AS LONG

    LOCAL TRUE AS LONG

    TRUE = 1

    'Path counts are spread out into the fixed number of path cycles.
    'The path count must not exceed the fixed number of path cycles
    'Set number of path cycles run continuous irrelevent of path counts
    PathCycles = 1023 'default value, subject to change, user set

    'Maximum path counts equals the allowed limit any one path count can be.
    'examples, Path Counts = 400; 400/400 = 1 count output per 1 cycle
    '          Path Counts = 200; 400/200 = 1 count output per 2 cycles
    '          Path Counts = 150; 400/150 = 1 count output per 2 or 3 cycles
    '          Path Counts = 1;   400/1   = 1 count output per 400 cycles
    PathCnts = PathCycles 'always equals PathCycles

    Timer1Clk = 60 * PathCycles 'Timer1 clock = 60Hz * 400 Pathcycles = 24KHz

    DIM pCts(8) AS WORD  'as received, raw coded path
    DIM AB(8) AS BYTE    'quadrature encoded outputs
    DIM eCts(8) AS LONG  'encoder counters



'added: for testing only
    'needed for debug/testing only
    LOCAL pCtsN0,pCtsN1,pCtsN2,pCtsN3,pCtsN4,pCtsN5,pCtsN6,pCtsN7 AS BYTE '-path flag
    LOCAL Cts0,Cts1,Cts2,Cts3,Cts4,Cts5,Cts6,Cts7 AS INTEGER                 'path count for testing only
    LOCAL qCount0,qCount1,qCount2,qCount3,qCount4,qCount5,qCount6,qCount7 AS LONG  ' total counts since reset
    LOCAL A_B0,A_B1,A_B2,A_B3,A_B4,A_B5,A_B6,A_B7 AS BYTE ' the old, new code value
    LOCAL pByte1,pByte2, e0, e1, e2, e3,e4 AS BYTE

    'dLUT: encoder input decoder
    DIM dLUT(3,3) AS LOCAL INTEGER 'array to decode the 16 possible codes


'end



'added:

    'aLUT:decodes raw path as received to ABS count value
    DIM aLUT(65536) AS LOCAL WORD

    'fLUT:decodes raw path as received to sign flag: -1 = 1, 0 or 1 = 0
    DIM fLUT(65536) AS LOCAL BYTE

'end

    'vLUT: flag if value of any path equals 1
    DIM vLUT(1,1,1,1) AS LOCAL BYTE

    'pLUT: path cycle lookup table
    DIM pLUT(PathCycles,PathCnts) AS LOCAL BYTE

    'cLUT: lookup table to set count CODE: code 0:-1,1:0,2: 1
    DIM cLUT(1,1) AS LOCAL BYTE 'set count sign code

    'nLUT: lookup table to set count number SIGN flag:(+):0,(-):1
    DIM nLUT(1,1) AS LOCAL INTEGER

    'eLUT: quadrature encoding lookup table
    DIM eLUT(3,2) AS LOCAL BYTE 'Current Encoder Val: 0-3,   Encoder Count Inc: -1, 0, 1

    'bLUT: byte written to port LUT, combines (4) AB encoder codes to a single byte
    DIM bLUT(3,3,3,3) AS LOCAL BYTE

    '**************************************************************************************
    ' ASSIGN VALUES TO ALL LOOKUP TABLES
    '**************************************************************************************
    'bLUT: lookup table for byte written to 8 bit encode port
    ARRAY ASSIGN bLUT() = _
    0,64,128,192,16,80,144,208,32,96,160,224,48,112,176,240,4,68,132,196,20,84,148,212,_
    36,100,164,228,52,116,180,244,8,72,136,200,24,88,152,216,40,104,168,232,56,120,184,248,_
    12,76,140,204,28,92,156,220,44,108,172,236,60,124,188,252,1,65,129,193,17,81,145,209,_
    33,97,161,225,49,113,177,241,5,69,133,197,21,85,149,213,37,101,165,229,53,117,181,245,_
    9,73,137,201,25,89,153,217,41,105,169,233,57,121,185,249,13,77,141,205,29,93,157,221,_
    45,109,173,237,61,125,189,253,2,66,130,194,18,82,146,210,34,98,162,226,50,114,178,242,_
    6,70,134,198,22,86,150,214,38,102,166,230,54,118,182,246,10,74,138,202,26,90,154,218,_
    42,106,170,234,58,122,186,250,14,78,142,206,30,94,158,222,46,110,174,238,62,126,190,254,_
    3,67,131,195,19,83,147,211,35,99,163,227,51,115,179,243,7,71,135,199,23,87,151,215,_
    39,103,167,231,55,119,183,247,11,75,139,203,27,91,155,219,43,107,171,235,59,123,187,251,_
    15,79,143,207,31,95,159,223,47,111,175,239,63,127,191,255


'added for testing only
'    'dLUT: encoder input decoder
    ARRAY ASSIGN dLUT() = 0,1,-1,0,-1,0,0,1,1,0,0,-1,0,-1,1,0

'    dLUT(0,0)= 0 'AB OLD: 00 / AB NEW: 00 = same, no change
'    dLUT(1,0)= 1 'AB OLD: 01 / AB NEW: 00 = +1 counts
'    dLUT(2,0)=-1 'AB OLD: 10 / AB NEW: 00 = -1 counts
'    dLUT(3,0)= 0 'AB OLD: 11 / AB NEW: 00 = NOT VALID, no change
'
'    dLUT(0,1)=-1 'AB OLD: 00 / AB NEW: 01 = -1 counts
'    dLUT(1,1)= 0 'AB OLD: 01 / AB NEW: 01 = same, no change
'    dLUT(2,1)= 0 'AB OLD: 10 / AB NEW: 01 = NOT VALID, no change
'    dLUT(3,1)= 1 'AB OLD: 11 / AB NEW: 01 = +1 counts
'
'    dLUT(0,2)= 1 'AB OLD: 00 / AB NEW: 10 = +1 counts
'    dLUT(1,2)= 0 'AB OLD: 01 / AB NEW: 10 = NOT VALID, no change
'    dLUT(2,2)= 0 'AB OLD: 10 / AB NEW: 10 = same, no change
'    dLUT(3,2)=-1 'AB OLD: 11 / AB NEW: 10 = -1 counts
'
'    dLUT(0,3)= 0 'AB OLD: 00 / AB NEW: 11 = NOT VALID, no change
'    dLUT(1,3)=-1 'AB OLD: 01 / AB NEW: 11 = -1 counts
'    dLUT(2,3)= 1 'AB OLD: 10 / AB NEW: 11 = +1 counts
'    dLUT(3,3)= 0 'AB OLD: 11 / AB NEW: 11 = same, no change


'end

    'vLUT: lookup table, TRUE if value of any path inc equals 1
    ARRAY ASSIGN vLUT() = 0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

    'cLUT: lookup table to set count sign code; 0:-1; 1:0; 2:1
    ARRAY ASSIGN cLUT() = 1,2,1,0

    'nLUT: lookup table to set count to plus or minus +/-
    ARRAY ASSIGN nLUT() = 0,1,0,-1

    'eLUT: lookup table for setting encoder output code
    ARRAY ASSIGN eLUT() = 1,3,0,2,0,1,2,3,2,0,3,1

    'pLUT: generate lookup table, based on Path cycle and Path counts
    ' all varibles are longs except Stp which is a float, double
    FOR pCnt = PathCnts TO 1 STEP -1
        Stp = CDBL(PathCycles/pCnt)
        Ctr = 0
        DO
           pCycle = CLNG(PathCycles - (Stp * Ctr))
           IF pCycle < 1 THEN
              EXIT DO
           ELSE
              pLUT(pCycle,pCnt) = 1
           END IF
           INCR Ctr
        LOOP
    NEXT


    'aLUT:generate ABS path count LUT
    'fLUT:generate true or false negative path flag
    FOR ctr = 0 TO 65535
       fLUT(ctr) = ctr AND &H1
       aLUT(ctr) = ctr
       SHIFT RIGHT aLUT(ctr),6 'path limited to 10 bits
    NEXT



    ' END OF STARTUP CODE
    '**************************************************************************************************


    'SET TIMER1 INTERRUPT to Timer1Clk and point Here:
    '*************************************************************************************************


'    IF PathOff THEN EXIT FUNCTION

'
'    'SET NEXT PATH CODE SECTION,  example only, needs much work
'    '----------------------------------------------------------------------------------------------
'    INCR pCycle  'Increment current path's cycle position = 1 to MaxCycle
'
'    IF pCycle > PathCycles THEN  'all path cycles complete,fetch next path if any.
'
'       IF PathNext THEN      'path in buffer?
'
'          pCycle = 0 'clear cycle
'
'          'NEXT PATH:  PREPARE THIS OUTSIDE OF INTERRUPT FUNCTION?
'

          '*************************************************************************************
          'simulated paths: REMOVE AND REPLACE
          Cts0 = -299 : Cts1 = 197 : Cts2 = -1023   : Cts3 = 23   'motors
          Cts4 = 10   : Cts5 = -43 : Cts6 = 200 : Cts7 = -163 'image

          'copy ABS values, set flag negative
          pCts(0) = ABS(Cts0):pCts(1) = ABS(Cts1):pCts(2) = ABS(Cts2):pCts(3) = ABS(Cts3)
          pCts(4) = ABS(Cts4):pCts(5) = ABS(Cts5):pCts(6) = ABS(Cts6):pCts(7) = ABS(Cts7)

          'ABS:a=b<0?0-b:b
          'flag = 1 for negative path, 0 for positive
          pCtsN0=BIT(Cts0,15):pCtsN1=BIT(Cts1,15):pCtsN2=BIT(Cts2,15):pCtsN3=BIT(Cts3,15)
          pCtsN4=BIT(Cts4,15):pCtsN5=BIT(Cts5,15):pCtsN6=BIT(Cts6,15):pCtsN7=BIT(Cts7,15)

          'encode the path words into the as received, raw paths

          SHIFT LEFT pCts(0),6 : SHIFT LEFT pCts(1),6 : SHIFT LEFT pCts(2),6 : SHIFT LEFT pCts(3),6
          SHIFT LEFT pCts(4),6 : SHIFT LEFT pCts(5),6 : SHIFT LEFT pCts(6),6 : SHIFT LEFT pCts(7),6


          pCts(0) = pCts(0) OR pCtsN0 : pCts(1) = pCts(1) OR pCtsN1 : pCts(2) = pCts(2) OR pCtsN2 : pCts(3) = pCts(3) OR pCtsN3
          pCts(4) = pCts(4) OR pCtsN4 : pCts(5) = pCts(5) OR pCtsN5 : pCts(6) = pCts(6) OR pCtsN6 : pCts(7) = pCts(7) OR pCtsN7


          PRINT Cts0;Cts1;Cts2;Cts3;Cts4;Cts5;Cts6;Cts7

          PRINT aLUT(pCts(0));aLUT(pCts(1));aLUT(pCts(2));aLUT(pCts(3));aLUT(pCts(4));aLUT(pCts(5));aLUT(pCts(6));aLUT(pCts(7))

          WAITKEY$

          'end


          '*************************************************************************************

'      ELSE   'no paths

'          PathOff = TRUE : EXIT FUNCTION
'
'       END IF
'
'    END IF
    '----------------------------------------------------------------------------------------------------
    'END OF SET NEXT PATH

    'Start of main interrupt code running at 60 * PathCycles. Example: 60Hz * 400 Pathcycles = 24KHz
    '----------------------------------------------------------------------------------------------------
FOR pCycle = 1 TO PathCycles
    '(4) MOTOR CHANNELS:



    'skip altogether if every motor channel count equals zero
    IF vLUT(pLUT(pCycle,aLUT(pCts(0))),pLUT(pCycle,aLUT(pCts(1))),pLUT(pCycle,aLUT(pCts(2))),pLUT(pCycle,aLUT(pCts(3)))) THEN

'added for testing only
       A_B0 = AB(0)  'copy old value
       A_B1 = AB(1)
       A_B2 = AB(2)
       A_B3 = AB(3)
'end
       FOR cn = 0 TO 3
           AB(cn) = eLUT(AB(cn),cLUT(pLUT(pCycle,aLUT(pCts(cn))),fLUT(pCts(cn)))) 'translate to AB code: = 0,1,2 or 3
           eCts(cn) += nLUT(pLUT(pCycle,aLUT(pCts(cn))),fLUT(pCts(cn)))           'update motor counters
       NEXT

      'OUT PORT(port4,bLUT(AB(3),AB(2),AB(1),AB(0)))           'write translated byte to motor port

'added for testing only
       e0 = AB(0) : e1 = AB(1) : e2 = AB(2) : e3 = AB(3)
       SHIFT LEFT e3,6 : SHIFT LEFT e2,4 : SHIFT LEFT e1,2

       pbyte1 = e0 OR e1 OR e2 OR e3
       pbyte2 = bLUT(AB(3),AB(2),AB(1),AB(0))

       IF pbyte1 <> pbyte2 THEN
          PRINT "port errror"
       END IF

       qCount0 += dLUT(A_B0,AB(0))  ' get the change from the LUT: -1,0,1
       qCount1 += dLUT(A_B1,AB(1))
       qCount2 += dLUT(A_B2,AB(2))
       qCount3 += dLUT(A_B3,AB(3))
'end

    END IF

    '(4) IMAGE CHANNELS:

    'skip altogether if every image channel count equals zero
    IF vLUT(pLUT(pCycle,aLUT(pCts(4))),pLUT(pCycle,aLUT(pCts(5))),pLUT(pCycle,aLUT(pCts(6))),pLUT(pCycle,aLUT(pCts(7)))) THEN

'added for testing only
       A_B4 = AB(4)  'copy old value
       A_B5 = AB(5)
       A_B6 = AB(6)
       A_B7 = AB(7)
'end
       FOR cn = 4 TO 7
           AB(cn) = eLUT(AB(cn),cLUT(pLUT(pCycle,aLUT(pCts(cn))),fLUT(pCts(cn)))) 'translate to AB code: = 0,1,2 or 3
           eCts(cn) += nLUT(pLUT(pCycle,aLUT(pCts(cn))),fLUT(pCts(cn)))           'update motor counters
       NEXT

       'OUT PORT(port5,bLUT(AB(7),AB(6),AB(5),AB(4)))            'write translated byte to image port

'added for testing only
       qCount4 += dLUT(A_B4,AB(4))  ' get the change from the LUT: -1,0,1
       qCount5 += dLUT(A_B5,AB(5))
       qCount6 += dLUT(A_B6,AB(6))
       qCount7 += dLUT(A_B7,AB(7))
'end

    END IF

    '----------------------------------------------------------------------------------------------------
    'End of main interrupt code

NEXT

'added for testing only
       PRINT eCts(0);pCts(0);qCount0
       PRINT eCts(1);pCts(1);qCount1
       PRINT eCts(2);pCts(2);qCount2
       PRINT eCts(3);pCts(3);qCount3
       PRINT eCts(4);pCts(4);qCount4
       PRINT eCts(5);pCts(5);qCount5
       PRINT eCts(6);pCts(6);qCount6
       PRINT eCts(7);pCts(7);qCount7

       WAITKEY$
'end


  'program ends

END FUNCTION





SUB Check_nLUT

    LOCAL lCtr0, lCtr1 AS LONG

    'fLUT: -/+ count sign lookup table
    DIM nLUT(1,1) AS LOCAL BYTE 'set count sign: -1=0,0=1,1=2

    'TEST: tLUT: -/+ count sign lookup table
    DIM tLUT(1,1) AS LOCAL BYTE 'set count sign: -1=0,0=1,1=2

    'fLUT Generate:  count sign flag lookup tables
    tLUT(0,0)= 0 '1 'Count=0,Sign+ =0 / = 0 count
    tLUT(1,0)= 1 '2 'Count=1,Sign+ =0 / = +1 count
    tLUT(0,1)= 0 '1 'Count=0,Sign- =1 / = 0 count
    tLUT(1,1)= -1 '0 'Count=1,Sign- =1 / = -1 count

    ARRAY ASSIGN nLUT() = 0,1,0,-1
    FOR lCtr1 = 0 TO 1
        FOR lCtr0 = 0 TO 1
            IF tLUT(lCtr0,lCtr1) = nLUT(lCtr0,lCtr1) THEN
               'all OK
            ELSE
               PRINT "Error"
            END IF
        NEXT
    NEXT

    PRINT "nLUT Check Completed"
    WAITKEY$



END SUB

SUB Check_bLUT

    LOCAL lCtr0, lCtr1, lCtr2, lCtr3 AS LONG


    LOCAL eBit0, ebit1, ebit2, ebit3 AS BYTE 'used for temp decoding encoder of AB LUT


    'bLUT: byte written to port LUT
    DIM bLUT(3,3,3,3) AS LOCAL BYTE

    'test: bLUT: byte written to port LUT
    DIM tLUT(3,3,3,3) AS LOCAL BYTE


    'TEST: bLUT Generate:  port byte lookup table
    FOR lCtr0 = 0 TO 3
        ebit0 = lCtr0
        FOR lCtr1 = 0 TO 3
            ebit1 = lCtr1 : SHIFT LEFT ebit1,2
            FOR lCtr2 = 0 TO 3
                ebit2 = lCtr2 : SHIFT LEFT ebit2,4
                FOR lCtr3 = 0 TO 3
                    ebit3 = lCtr3 : SHIFT LEFT ebit3,6
                    tLUT(lCtr3,lCtr2,lCtr1,lCtr0) = ebit3 OR ebit2 OR ebit1 OR ebit0
                    'tLUT(lCtr0,lCtr1,lCtr2,lCtr3) = ebit3 OR ebit2 OR ebit1 OR ebit0
                    'print tLUT(lCtr0,lCtr1,lCtr2,lCtr3);" "
               NEXT
            NEXT
        NEXT
    NEXT


    ARRAY ASSIGN bLUT() = _
    0,64,128,192, 16,80,144,208, 32,96,160,224, 48,112,176,240,_
    4,68,132,196, 20,84,148,212, 36,100,164,228, 52,116,180,244,_
    8,72,136,200, 24,88,152,216, 40,104,168,232, 56,120,184,248,_
    12,76,140,204, 28,92,156,220, 44,108,172,236, 60,124,188,252,_
    1,65,129,193,17,81,145,209,33,97,161,225,49,113,177,241,5,69,133,197,21,85,149,213,37,101,165,229,53,117,181,245,_
    9,73,137,201,25,89,153,217,41,105,169,233,57,121,185,249,13,77,141,205,29,93,157,221,_
    45,109,173,237,61,125,189,253,2,_
    66,130,194,18,82,146,210,34,98,162,226,50,114,178,242,_
    6,70,134,198,22,86,150,214,38,102,166,230,54,118,182,246,10,74,138,202,26,90,154,218,_
    42,106,170,234,58,122,186,250,14,78,142,206,30,94,158,222,46,110,174,238,62,126,190,254,_
    3,67,131,195,19,83,147,211,35,99,163,227,51,115,179,243,7,71,135,199,23,87,151,215,_
    39,103,167,231,55,119,183,247,11,75,139,203,27,91,155,219,43,107,171,235,59,123,187,251,_
    15,79,143,207,31,95,159,223,47,111,175,239,63,127,191,255

    'TEST: bLUT Generate:  port byte lookup table
    FOR lCtr0 = 0 TO 3
        FOR lCtr1 = 0 TO 3
            FOR lCtr2 = 0 TO 3
                FOR lCtr3 = 0 TO 3
                    IF tLUT(lCtr3,lCtr2,lCtr1,lCtr0) = bLUT(lCtr3,lCtr2,lCtr1,lCtr0) THEN
                       'all OK
                    ELSE
                        PRINT "Error"
                    END IF
                NEXT
            NEXT
        NEXT
    NEXT

    PRINT "bLUT Check Completed"
    WAITKEY$



END SUB


SUB Check_eLUT

    LOCAL lCtr0, lCtr1 AS LONG

    'eLUT: quadrature encoding lookup table
    DIM eLUT(3,2) AS LOCAL BYTE 'Current Encoder Val: 0-3,   Encoder Count Inc: -1, 0, 1

    'tLUT: test quadrature encoding lookup table
    DIM tLUT(3,2) AS LOCAL BYTE 'Current Encoder Val: 0-3,   Encoder Count Inc: -1, 0, 1


    'TEST: tLUT Generate: encoding lookup tables
    'Increment = -1       AB
    tLUT(0,0)= 1 'AB OLD: 00 / AB NEW: 01
    tLUT(1,0)= 3 'AB OLD: 01 / AB NEW: 11
    tLUT(2,0)= 0 'AB OLD: 10 / AB NEW: 00
    tLUT(3,0)= 2 'AB OLD: 11 / AB NEW: 10
    'Increment = 0         AB
    tLUT(0,1)= 0  'AB OLD: 00 / AB NEW: 00 = same, no change
    tLUT(1,1)= 1  'AB OLD: 01 / AB NEW: 01 = same, no change
    tLUT(2,1)= 2  'AB OLD: 10 / AB NEW: 10 = same, no change
    tLUT(3,1)= 3  'AB OLD: 11 / AB NEW: 11 = same, no change
    'Increment = +1        AB
    tLUT(0,2)= 2  'AB OLD: 00 / AB NEW: 10
    tLUT(1,2)= 0  'AB OLD: 01 / AB NEW: 00
    tLUT(2,2)= 3  'AB OLD: 10 / AB NEW: 11
    tLUT(3,2)= 1  'AB OLD: 11 / AB NEW: 01

    ARRAY ASSIGN eLUT() = 1,3,0,2,0,1,2,3,2,0,3,1

    FOR lCtr1 = 0 TO 2
        FOR lCtr0 = 0 TO 3
            IF tLUT(lCtr0,lCtr1) = eLUT(lCtr0,lCtr1) THEN
               'all OK
            ELSE
               PRINT "Error"
            END IF
        NEXT
    NEXT

    PRINT "eLUT Check Completed"
    WAITKEY$


END SUB


SUB Check_pLUT



    LOCAL Stp AS DOUBLE

    LOCAL PathCycle, PathCycles, PathCnts,  PathCnt, Ctr AS LONG 'DOUBLE

    PathCnts = 1023 : PathCycles = PathCnts 'always equal: 1 cycle per Path count

    DIM pLUT(PathCycles,PathCnts) AS LOCAL BYTE

    '******************************************************************************
    'Create the Look up table  - one time only, could stored and loaded from disk!
GOTO Skip

    FOR PathCnt = PathCnts TO 1 STEP -1
        Stp = CDBL(PathCycles/PathCnt)
        Ctr = 0
        DO

           PathCycle = CLNG(PathCycles - (Stp * Ctr))
           IF PathCycle < 1 THEN
              EXIT DO
           ELSE
              pLUT(PathCycle,PathCnt) = 1
           END IF
           INCR Ctr

        LOOP
    NEXT

Skip:

     FOR PathCnt = 1 TO PathCnts ' STEP -1
        Stp = CDBL(PathCycles/PathCnt)
        Ctr = 0
        DO

           PathCycle = CLNG(PathCycles - (Stp * Ctr))
           IF PathCycle < 1 THEN '=> PathCycles THEN
              EXIT DO
           ELSE
              pLUT(PathCycle,PathCnt) = 1
           END IF
           INCR Ctr

        LOOP
    NEXT


    'check results for errors
    Ctr=0
    FOR PathCnt = 1 TO PathCnts
        FOR PathCycle = 1 TO PathCycles
            Ctr = Ctr + pLUT(PathCycle,PathCnt)
            IF (PathCnt = 1) AND ( pLUT(PathCycle,PathCnt)=1 ) THEN
                PRINT "PathCycle: "; PathCycle  '" Ctr: ";Ctr
                WAITKEY$
            END IF

        NEXT
        PRINT "PathCnt: "; PathCnt;" Ctr: ";Ctr
        IF Ctr <> PathCnt THEN WAITKEY$
        Ctr = 0
    NEXT

    PRINT "DONE !"
    WAITKEY$
    EXIT SUB




END SUB


SUB Check_vLUT

    'vLUT: flag if value of any path equals 1
    DIM vLUT(1,1,1,1) AS LOCAL BYTE

    LOCAL lCtr0, lCtr1, lCtr2, lCtr3 AS LONG

    ARRAY ASSIGN vLUT() = 0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

    GOTO skip1

    'vLUT Generate: set flag if value of any path equals 1
    FOR lCtr0 = 0 TO 1
        FOR lCtr1 = 0 TO 1
            FOR lCtr2 = 0 TO 1
                 FOR lCtr3 = 0 TO 1
                     IF lCtr0 OR lCtr1 OR lCtr2 OR lCtr3 THEN
                        vLUT(lCtr0,lCtr1,lCtr2,lCtr3) = 1
                     ELSE
                        vLUT(lCtr0,lCtr1,lCtr2,lCtr3) = 0
                     END IF
                 NEXT
            NEXT
        NEXT
    NEXT


skip1:
     'vLUT Generate: set flag if value of any path equals 1
    FOR lCtr0 = 0 TO 1
        FOR lCtr1 = 0 TO 1
            FOR lCtr2 = 0 TO 1
                 FOR lCtr3 = 0 TO 1
                     IF lCtr0 OR lCtr1 OR lCtr2 OR lCtr3 THEN
                        IF vLUT(lCtr0,lCtr1,lCtr2,lCtr3) THEN
                           'all ok
                        ELSE
                           PRINT "error"
                           WAITKEY$
                        END IF
                     ELSE
                        IF vLUT(lCtr0,lCtr1,lCtr2,lCtr3) = 0 THEN
                           'all ok
                        ELSE
                           PRINT "error"
                           WAITKEY$
                        END IF
                     END IF
                 NEXT
            NEXT
        NEXT
    NEXT

    PRINT "vLUT Check Completed"
    WAITKEY$


END SUB

SUB GetDecode

    'encoder input decoder

    DIM dLUT(3,3) AS LOCAL INTEGER    'array to decode the 16 possible BIT codes

    'dLUT: encoder input decoder
    ARRAY ASSIGN dLUT() = 0,1,-1,0,-1,0,0,1,1,0,0,-1,0,-1,1,0

'    dLUT(0,0)= 0 'AB OLD: 00 / AB NEW: 00 = same, no change
'    dLUT(1,0)= 1 'AB OLD: 01 / AB NEW: 00 = +1 counts
'    dLUT(2,0)=-1 'AB OLD: 10 / AB NEW: 00 = -1 counts
'    dLUT(3,0)= 0 'AB OLD: 11 / AB NEW: 00 = NOT VALID, no change
'
'    dLUT(0,1)=-1 'AB OLD: 00 / AB NEW: 01 = -1 counts
'    dLUT(1,1)= 0 'AB OLD: 01 / AB NEW: 01 = same, no change
'    dLUT(2,1)= 0 'AB OLD: 10 / AB NEW: 01 = NOT VALID, no change
'    dLUT(3,1)= 1 'AB OLD: 11 / AB NEW: 01 = +1 counts
'
'    dLUT(0,2)= 1 'AB OLD: 00 / AB NEW: 10 = +1 counts
'    dLUT(1,2)= 0 'AB OLD: 01 / AB NEW: 10 = NOT VALID, no change
'    dLUT(2,2)= 0 'AB OLD: 10 / AB NEW: 10 = same, no change
'    dLUT(3,2)=-1 'AB OLD: 11 / AB NEW: 10 = -1 counts
'
'    dLUT(0,3)= 0 'AB OLD: 00 / AB NEW: 11 = NOT VALID, no change
'    dLUT(1,3)=-1 'AB OLD: 01 / AB NEW: 11 = -1 counts
'    dLUT(2,3)= 1 'AB OLD: 10 / AB NEW: 11 = +1 counts
'    dLUT(3,3)= 0 'AB OLD: 11 / AB NEW: 11 = same, no change

    LOCAL qCount AS LONG  ' total counts since reset
    LOCAL A_B, AB AS BYTE ' the old, new code value

    qCount += dLUT(A_B,AB)  ' get the change from the LUT: -1,0,1
    A_B = AB  'copy new

END SUB
