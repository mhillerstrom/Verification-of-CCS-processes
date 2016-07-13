/*****************************************************************************/
/*                                                                           */
/* Example file part of M.sc. Thesis "Verification of CCS-processes"         */
/*                      1987 by Michael Hillerström                          */
/*                                                                           */
/* Annotated for automatic snipplet construction and inclusion into thesis.  */
/*                                                                           */
/*****************************************************************************/

?- ['../newbisim'].

/*#snipplet: ex3a.inp */
/*#filter: s/?- //g */
?- vendonce_machine1 :=: coin;(coffee; nil + tea; nil).
/*#end*/

/*#snipplet: ex3b.inp */
/*#filter: s/?- //g */
?- vendonce_machine2 :=: coin; coffee; nil + coin; tea; nil.
/*#end*/

?- showdecl.

/*#filter: s/?- //g */
?- wstring("!out!"), nl, wstring("bisim(vendonce_machine1,vendonce_machine2)."), nl.
/*#snipplet: ex3.cmd */
?- bisim(vendonce_machine1,vendonce_machine2).
/*#end*/
?- nl, wstring("yes").

?- halt.
