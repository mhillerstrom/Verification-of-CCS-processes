/*****************************************************************************/
/*                                                                           */
/* Example file part of M.sc. Thesis "Verification of CCS-processes"         */
/*                      1987 by Michael Hillerström                          */
/*                                                                           */
/* Annotated for automatic snipplet construction and inclusion into thesis.  */
/*                                                                           */
/*****************************************************************************/

?- ['../extwbisim'].

/*#snipplet: ex14.inp */
/*#filter: s/?- //g */
?- p2 :=: alpha;(beta;nil+tau;gamma;nil).
?- q2 :=: alpha;(beta;nil+gamma;nil).
/*#end*/

?- showdecl.

/*#filter: s/?- //g */
?- wstring("!out!"), nl, wstring("bisim(p2,q2)."), nl.
/*#snipplet: ex14.cmd */
?- bisim(p2,q2).
?- nl, wstring("yes"), nl, nl, wstring("bisim(q2,p2)."), nl.
?- bisim(q2,p2).
/*#end*/
?- nl, wstring("yes").

?- halt.
