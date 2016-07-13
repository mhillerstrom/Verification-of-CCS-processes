/*****************************************************************************/
/*                                                                           */
/* Example file part of M.sc. Thesis "Verification of CCS-processes"         */
/*                      1987 by Michael Hillerström                          */
/*                                                                           */
/* Annotated for automatic snipplet construction and inclusion into thesis.  */
/*                                                                           */
/*****************************************************************************/

?- ['../newbisim'].

/*#snipplet: ex1.inp */
/*#filter: s/?- //g */
?- p1 :=: a; b; nil + a; nil.
?- q1 :=: a; b; nil.
/*#end*/

?- showdecl.

/*#filter: s/?- //g */
?- wstring("!out!"), nl, wstring("bisim(p1,q1)."), nl.
/*#snipplet: ex1.cmd */
?- bisim(p1,q1).
/*#end*/
?- nl, wstring("yes").

?- halt.
