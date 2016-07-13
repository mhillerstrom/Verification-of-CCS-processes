/*****************************************************************************/
/*                                                                           */
/* Example file part of M.sc. Thesis "Verification of CCS-processes"         */
/*                      1987 by Michael Hillerström                          */
/*                                                                           */
/* Annotated for automatic snipplet construction and inclusion into thesis.  */
/*                                                                           */
/*****************************************************************************/

?- ['../extwbisim'].

/*#snipplet: ex18.inp */
/*#filter: s/?- //g */
?- p6 :=: alpha;(beta;nil+tau;beta;nil).
?- q6 :=: alpha;beta;nil.
/*#end*/

?- showdecl.

/*#filter: s/?- //g */
?- wstring("!out!"), nl, wstring("bisim(p6,q6)."), nl.
/*#snipplet: ex18.cmd */
?- bisim(p6,q6).
/*#end*/
?- nl, wstring("yes").

?- halt.
