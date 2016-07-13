/*****************************************************************************/
/*                                                                           */
/* Example file part of M.sc. Thesis "Verification of CCS-processes"         */
/*                      1987 by Michael Hillerström                          */
/*                                                                           */
/* Annotated for automatic snipplet construction and inclusion into thesis.  */
/*                                                                           */
/*****************************************************************************/

?- ['../extwbisim'].

/*#snipplet: ex16.inp */
/*#filter: s/?- //g */
?- p4 :=: alpha;nil+beta;nil+tau;beta;nil.
?- q4 :=: alpha;nil+tau;beta;nil.
/*#end*/

?- showdecl.

/*#filter: s/?- //g */
?- wstring("!out!"), nl, wstring("bisim(p4,q4)."), nl.
/*#snipplet: ex16.cmd */
?- bisim(p4,q4).
/*#end*/
?- nl, wstring("yes").

?- halt.
