/*****************************************************************************/
/*                                                                           */
/* Example file part of M.sc. Thesis "Verification of CCS-processes"         */
/*                      1987 by Michael Hillerström                          */
/*                                                                           */
/* Annotated for automatic snipplet construction and inclusion into thesis.  */
/*                                                                           */
/*****************************************************************************/

?- ['../extwbisim'].

/*#snipplet: ex11.inp */
/*#filter: s/?- //g */
?- ideal_department:=: pub; ideal_department.
?- good_department :=: (computer_scientist/door/good_machine)\[pub].

?- computer_scientist :=: out(close); out(coin); in(coffee);
                       out(open); pub; computer_scientist.
?- door :=: in(close); in(open); door.

?- good_machine :=: in(coin); (out(coffee); good_machine +
                                           out(tea); good_machine).
/*#end*/

?- showdecl.

?- wstring("!out!"), nl, wstring("bisim(good_department,ideal_department)."), nl.
/*#snipplet: ex11.cmd */
/*#filter: s/?- //g */
?- bisim(good_department,ideal_department).
/*#end*/
?- nl, wstring("yes").

?- halt.
