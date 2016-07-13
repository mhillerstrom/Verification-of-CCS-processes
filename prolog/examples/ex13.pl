/*****************************************************************************/
/*                                                                           */
/* Example file part of M.sc. Thesis "Verification of CCS-processes"         */
/*                      1987 by Michael Hillerström                          */
/*                                                                           */
/* Annotated for automatic snipplet construction and inclusion into thesis.  */
/*                                                                           */
/*****************************************************************************/

?- ['../extwbisim'].

/*#snipplet: ex13.inp */
/*#filter: s/?- //g */
?- p1 :=: alpha;tau;gamma;nil.
?- q1 :=: alpha;gamma;nil.
/*#end*/

?- showdecl.

/*#filter: s/?- //g */
?- wstring("!out!"), nl, wstring("bisim(p1,q1)."), nl.
/*#snipplet: ex13.cmd */
?- bisim(p1,q1).
/*#end*/
?- nl, wstring("yes").

?- halt.
