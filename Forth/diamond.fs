\ Diamond.fs

CHAR A CONSTANT START

: LETTER#    \ c -- l#
    START - 1+ ;

: CENTRAL    \ l# -- n
    2* 3 - ;

: BACKSPACE 
    8 EMIT ;

: .SPACES    \ n --  
    DUP 0>= IF SPACES
          ELSE DROP BACKSPACE 
          THEN ;

: LETTER     \ l# -- c 
    START 1- + EMIT ;

: LETTERS    \ l# -- 
    DUP LETTER 
    DUP CENTRAL .SPACES 
        LETTER ; 

: LINE       \ max#,l# -- 
    DUP -ROT - SPACES LETTERS ;

: 1ST-HALF   \ max# --
    DUP 1+ 1 DO
             DUP I CR LINE 
             LOOP DROP ;

: 2ND-HALF   \ max# --
    DUP 1+ 2 DO 
             DUP  DUP 1+ I -  CR LINE 
             LOOP DROP ;

: DIAMOND    \ c -- 
    LETTER# 
    DUP 1ST-HALF 
        2ND-HALF CR ;
