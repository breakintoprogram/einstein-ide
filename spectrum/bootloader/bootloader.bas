100 REM Set Port B to Mode 3 and all pins to input
110 :
120 OUT 127, BIN 11001111
130 OUT 127, BIN 11111111
140 :
150 REM Set Port A to Mode 3
160 REM Pin 0 (Ready)  - input
170 REM Pin 1 (Strobe) - output
180 :
190 OUT 95, BIN 11001111
200 OUT 95, BIN 00000001
210 :
220 PRINT "Waiting for data from assembler"
230 :
240 REM Read the header in first
250 :
260 FOR l=1 TO 3
270 GO SUB 900
280 IF b<>1 THEN PRINT "Header error": STOP
290 NEXT l
300 GO SUB 900
310 IF b<>0 THEN PRINT "Header error": STOP
320 :
330 REM Read in the address and length words
340 :
350 GO SUB 900: LET addr=b
360 GO SUB 900: LET addr=addr+256*b
370 GO SUB 900: LET len=b
380 GO SUB 900: LET len=len+256*b
390 :
400 PRINT "ORG: ";addr
410 PRINT "LEN: ";len
420 REM Read in the binary data
430 :
440 FOR l=0 TO len-1
450 GO SUB 900
460 POKE addr+l,b
470 OUT 254,b
480 NEXT l
490 OUT 254,7
500 PRINT "Done!"
870 :
880 STOP
890 :
900 REM Subroutine to read in a byte of data
910 :
920 LET h=IN 31
930 IF h/2=INT(h/2) THEN GO TO 920: REM Wait until the Ready line goes high
940 : 
950 LET b=IN 63: REM Read the data into variable b
960 OUT 31,0: REM Pulse the strobe line low
970 OUT 31,2: REM Then high to indicate data has been read
980 RETURN