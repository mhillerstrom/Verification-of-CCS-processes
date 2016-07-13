/*****************************************************************************/
/*                                                                           */
/* Example file part of M.sc. Thesis "Verification of CCS-processes"         */
/*                      1987 by Michael Hillerström                          */
/*                                                                           */
/* Annotated for automatic snipplet construction and inclusion into thesis.  */
/*                                                                           */
/*****************************************************************************/

?- ['../extwbisim'].

/*#snipplet: ex17.inp */
/*#filter: s/?- //g */
?- p5 :=: alpha;nil+beta;nil+tau;beta;nil.
?- q5 :=: alpha;nil+beta;nil.
/*#end*/

?- showdecl.

/*#filter: s/?- //g */
?- wstring("!out!"), nl, wstring("bisim(p5,q5)."), nl.
/*#snipplet: ex17.cmd */
?- bisim(p5,q5).
?- nl, wstring("yes"), nl, nl, wstring("bisim(q5,p5)."), nl.
?- bisim(q5,p5).
/*#end*/
?- nl, wstring("yes").

?- halt.
