char A constant A
: max-margin ( c -- n  size of max margin)
    A - ;

: .letter     ( n --   print letter #n)
    A + emit ;

: .center     ( n --   print 2n-1 spaces )
    2* 1- spaces ;

: .letters    ( m,n --    print letter, central space and letter )
    dup dup .letter .center .letter ;

: .pattern    ( n --   print letter pattern )
    dup if .letters else .letter then ;

: .diamond-line   ( m,n --   print line )
    over spaces .pattern spaces ;

: run-line    ( m,n -- m,n   print line and cr without loss of args )
    2dup .diamond-line cr ;
        
: increment   ( m,n -- m-1,n+1 )
    swap 1- swap 1+ ;

: first-half  ( m,n -- m',n'  print the first half )
    begin over while run-line increment repeat ;

: decrement   ( m,n -- m+1,n-1 )
    swap increment swap ;

: second-half ( m,n -- m',n'  print the second half )
    begin run-line decrement dup 0 < until ;

: diamond     ( c --    print a diamond )
    max-margin 0 cr first-half second-half 2drop ;

next-arg drop c@ diamond bye
