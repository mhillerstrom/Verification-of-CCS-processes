/*****************************************************************************/
/*                                                                           */
/* Example file part of M.sc. Thesis "Verification of CCS-processes"         */
/*                      1987 by Michael Hillerström                          */
/*                                                                           */
/* Annotated for automatic snipplet construction and inclusion into thesis.  */
/*                                                                           */
/*****************************************************************************/

?- ['../extwbisim'].

/*#snipplet: ex19.inp */
/*#filter: s/?- //g */
?- p7 :=: alpha;(beta;nil+tau;(gamma;nil+tau;delta;nil)).
?- q7 :=: alpha;(beta;nil+tau;(gamma;nil+tau;delta;nil))+
          alpha;(gamma;nil+tau;delta;nil)+alpha;delta;nil.
/*#end*/

?- showdecl.

/*#filter: s/?- //g */
?- wstring("!out!"), nl, wstring("bisim(p7,q7)."), nl.
/*#snipplet: ex19.cmd */
?- bisim(p7,q7).
/*#end*/
?- nl, wstring("yes").

?- halt.
