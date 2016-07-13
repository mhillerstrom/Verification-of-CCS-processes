/*****************************************************************************/
/*                                                                           */
/* Example file part of M.sc. Thesis "Verification of CCS-processes"         */
/*                      1987 by Michael Hillerström                          */
/*                                                                           */
/* Annotated for automatic snipplet construction and inclusion into thesis.  */
/*                                                                           */
/*****************************************************************************/

?- ['../extwbisim'].

/*#snipplet: ex15.inp */
/*#filter: s/?- //g */
?- p3 :=: alpha;(beta;nil+tau;gamma;nil).
?- q3 :=: alpha;(beta;nil+gamma;nil)+alpha;gamma;nil.
/*#end*/

?- showdecl.

/*#filter: s/?- //g */
?- wstring("!out!"), nl, wstring("bisim(p3,q3)."), nl.
/*#snipplet: ex15.cmd */
?- bisim(p3,q3).
?- nl, wstring("yes"), nl, nl, wstring("bisim(q3,p3)."), nl.
?- bisim(q3,p3).
/*#end*/
?- nl, wstring("yes").

?- halt.
