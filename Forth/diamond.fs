char A constant A
: margin-size A - ;
: letter   A + emit ;
: center   2* 1- spaces ;
: letters  dup dup letter center letter ;
: pattern  dup if letters else letter then ;
: line     over spaces pattern spaces ;
: run-line 2dup line cr ;
: increment   swap 1- swap 1+ ;
: first-half  begin over while run-line increment repeat ;
: decrement   swap 1+ swap 1- ;
: second-half begin run-line decrement dup 0 < until ;
: diamond margin-size 0 cr first-half second-half 2drop ;
next-arg drop c@ diamond bye
