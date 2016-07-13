/*****************************************************************************/
/*                                                                           */
/* Example file part of M.sc. Thesis "Verification of CCS-processes"         */
/*                      1987 by Michael Hillerström                          */
/*                                                                           */
/* Annotated for automatic snipplet construction and inclusion into thesis.  */
/*                                                                           */
/*****************************************************************************/

?- ['../extwbisim'].

/*#snipplet: ex20.inp */
/*#filter: s/?- //g */
?- p8 :=: alpha;(beta;nil+tau;(gamma;nil+tau;delta;nil)).
?- q8 :=: alpha;(beta;nil+gamma;nil+delta;nil)+
          alpha;(gamma;nil+delta;nil)+alpha;delta;nil.
/*#end*/

?- showdecl.

/*#filter: s/?- //g */
?- wstring("!out!"), nl, wstring("bisim(p8,q8)."), nl.
/*#snipplet: ex20.cmd */
?- bisim(p8,q8).
?- nl, wstring("yes"), nl, nl, wstring("bisim(q8,p8)."), nl.
?- bisim(q8,p8).
/*#end*/
?- nl, wstring("yes").

?- halt.
