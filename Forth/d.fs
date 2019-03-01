char A constant A
: l A + emit ;
: c 2* 1- spaces ;
: ls dup dup l c l ;
\ : ls 2dup l c l ; \ produce nice effect
: p dup if ls else l then ;
: ln over spaces p spaces ;
: r 2dup ln cr ;
: -- swap 1+ swap 1- ;
: ++ swap 1- swap 1+ ;
: h1 begin over while r ++ repeat ;
: h2 begin r -- dup 0 < until ;
: size A - ;
: d size 0 cr h1 h2 2drop ;
next-arg drop c@ d bye
