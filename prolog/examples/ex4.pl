/*****************************************************************************/
/*                                                                           */
/* Example file part of M.sc. Thesis "Verification of CCS-processes"         */
/*                      1987 by Michael Hillerström                          */
/*                                                                           */
/* Annotated for automatic snipplet construction and inclusion into thesis.  */
/*                                                                           */
/*****************************************************************************/

?- ['../newbisim'].

?- vendonce_machine1 :=: coin;(coffee; nil + tea; nil).
?- vendonce_machine2 :=: coin; coffee; nil + coin; tea; nil.

?- showdecl.

/*#filter: s/?- //g */
?- wstring("!out!"), nl, wstring("bisim(vendonce_machine2,vendonce_machine1)."), nl.
/*#snipplet: ex4.cmd */
?- bisim(vendonce_machine2,vendonce_machine1).
/*#end*/
?- nl, wstring("yes").

?- halt.
