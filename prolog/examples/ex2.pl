/*****************************************************************************/
/*                                                                           */
/* Example file part of M.sc. Thesis "Verification of CCS-processes"         */
/*                      1987 by Michael Hillerström                          */
/*                                                                           */
/* Annotated for automatic snipplet construction and inclusion into thesis.  */
/*                                                                           */
/*****************************************************************************/

?- ['../newbisim'].

?- p1 :=: a; b; nil + a; nil.
?- q1 :=: a; b; nil.

?- showdecl.

/*#filter: s/?- //g */
?- wstring("!out!"), nl, wstring("bisim(q1,p1)."), nl.
/*#snipplet: ex2.cmd */
?- bisim(q1,p1).
/*#end*/
?- nl, wstring("yes").

?- halt.
