/*****************************************************************************/
/*                                                                           */
/* Example file part of M.sc. Thesis "Verification of CCS-processes"         */
/*                      1987 by Michael Hillerström                          */
/*                                                                           */
/* Annotated for automatic snipplet construction and inclusion into thesis.  */
/*                                                                           */
/*****************************************************************************/

?- ['../newwbisim'].

?- good_machine :=: in(coin); (out(coffee); good_machine + out(tea); good_machine).
?- bad_machine :=: in(coin); out(coffee); bad_machine +
                in(coin); out(tea); bad_machine.
?- door :=: in(close); in(open); door.
?- computer_scientist :=: out(close); out(coin); in(cofee);
                       out(open); pub; computer_scientist.
?- good_department :=: (computer_scientist/door/good_machine)\[pub].
?- bad_department :=: (computer_scientist/door/bad_machine)\[pub].
?- ideal_department:=: pub; ideal_department.

?- showdecl.

/*#filter: s/?- //g */
?- wstring("!out!"), nl, wstring("bisim(bad_department,ideal_department)."), nl.
/*#snipplet: ex6.cmd */
?- bisim(bad_department,ideal_department).
/*#end*/
?- nl, wstring("yes").

?- halt.
