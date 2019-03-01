## The Diamond Kata
(this description is copied from http://cyber-dojo.org)

Given a letter print a diamond starting with 'A'
with the supplied letter at the widest point.

For example: print-diamond 'E' prints

<pre>
    A
   B B
  C   C
 D     D
E       E
 D     D
  C   C
   B B
    A
</pre>
For example: print-diamond 'C' prints

<pre>
  A
 B B
C   C
 B B
  A
</pre>

## Let's do it in Forth!

Our plan is to explore a bit.

In _gforth_ a character value is entered on the Stack with the word `char`:

```forth
char * . ⏎  42 ok
```
Char values being values, they can be subtracted on the stack:
```forth
char E char A - . ⏎  4 ok
char Z char A - . ⏎  25 ok
```
Given the last letter of the diamond, e.g E, the difference between this letter and A will give us the size of the largest margin to use at the top (and bottom) of the diamond, e.g. for a diamond from A to E, the largest margin is E-A = 4 spaces.
Let's put that in a constant and a firs word:
```forth
char A constant A ⏎  ok
: margin A - ; ⏎ ok
char E max-margin . ⏎  4 ok
char Z max-margin . ⏎  25 ok
```
The idea here is that values (from 0 to 25) can be used to calculate the size of the left margin, the size of the central space, and the char to print as well.
For example, in a diamond from A to E, these values are such :
<pre>
left  letter center
  4       A      -1 (negative, so the two A are at the same place)
  3       B      1
  2       C      3
  1       D      5
  0       E      7
</pre>

- The values on the first line would instruct our program to print 4 spaces, then the letter A, then go back one space, print the letter A again.
- The values on the second line would instruct our program to print 3 spaces, then the letter B, then print 1 space, then print the letter B again.
- and so on.

Let's create a word that given a number between 0 and 25, prints the corresponding letter:
```forth
: letter A + emit ; ⏎  ok
0 letter ⏎  A ok
20 letter ⏎  U ok
25 letter ⏎  Z ok
```
We are also able to calculate the number of spaces in the center given the letter number, it is this number time two minus one:
```forth
: center 2* 1- ; ⏎  ok
0 central . ⏎  -1 ok
1 central . ⏎  1 ok
2 central . ⏎  3 ok
3 central . ⏎  5 ok
```
Since we can't really move back one space in the printing, we have two distinct cases of printing a line:

- normal line : given the letter and the margin, print the margin, then the letter, then print the central spaces then print the letter again 
- special line : given the letter and the margin, print the margin, then the letter

```forth
: 1letter-line spaces letter ;  ok
: 2letter-line spaces dup letter dup central spaces letter ;  ok
0 4 1letter-line ⏎      A ok
1 3 2letter-line ⏎     B B ok
4 0 2letter-line ⏎  E       E ok
```
Given a letter number and a margin, if the letter number is zero, we need to print a one letter else a two letter line.
```forth
: line over if 2letter-line else 1letter-line then ; ⏎  ok
cr 0 4 line cr 1 3 line cr 2 2 line cr 3 1 line cr 4 0 line ⏎
    A
   B B
  C   C
 D     D
E       E ok
```
What we now need is a word to make the two parameters on the stack evolve like this : 0 4 → 1 3 → 2 2 → 3 1 → 4 0
```
: +- swap 1+ swap 1- ; ⏎  ok
0 4 cr .S +- cr .S +- cr .S +- cr .S +- cr .S ⏎
<2> 0 4
<2> 1 3
<2> 2 2
<2> 3 1
<2> 4 0  ok
```
Printing the firt half is then easy: print lines until the value on the top of the stack is below zero.
```forth
: 1st-half begin cr 2dup line +- dup 0 < until ;
0 4 1st-half ⏎
    A
   B B
  C   C
 D     D 
E       E ok
```
To print the second half we need to use the parameters left on the stack by `1st-half` and loop through them while increminting them the other way around:
```forth
: -+ swap 1- swap 1+ ; ⏎ ok
: 2nd-half begin dup 0 cr 2dup line -+ over 0 < until ; ⏎ ok
4 0 2nd-half ⏎
E       E
 D     D
  C   C
   B B
    A ok
```
Finally, our last word will set up the max margin parameter, run the two halves then drop the remaining arguments on the stack.
: diamond max-margin 0 swap 1st-half 2nd-half cr 2drop ;





