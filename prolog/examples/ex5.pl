/*****************************************************************************/
/*                                                                           */
/* Example file part of M.sc. Thesis "Verification of CCS-processes"         */
/*                      1987 by Michael Hillerström                          */
/*                                                                           */
/* Annotated for automatic snipplet construction and inclusion into thesis.  */
/*                                                                           */
/*****************************************************************************/

?- ['../newwbisim'].

/*#snipplet: ex5.inp */
/*#filter: s/?- //g */
?- good_machine :=: in(coin); (out(coffee); good_machine +
                            out(tea); good_machine).
?- bad_machine :=: in(coin); out(coffee); bad_machine +
                in(coin); out(tea); bad_machine.
/*#end*/

/*#snipplet: ex5a.inp */
/*#filter: s/?- //g */
?- door :=: in(close); in(open); door.
/*#end*/

/*#snipplet: ex5b.inp */
/*#filter: s/?- //g */
?- computer_scientist :=: out(close); out(coin); in(coffee);
                       out(open); pub; computer_scientist.
/*#end*/

/*#snipplet: ex5c.inp */
/*#filter: s/?- //g */
?- good_department :=: (computer_scientist/door/good_machine)\[pub].
?- bad_department :=: (computer_scientist/door/bad_machine)\[pub].
?- ideal_department:=: pub; ideal_department.
/*#end*/

?- showdecl.

?- wstring("!out!"), nl, wstring("bisim(good_department,ideal_department)."), nl.
/*#snipplet: ex5.cmd */
/*#filter: s/?- //g */
?- bisim(good_department,ideal_department).
/*#end*/
?- nl, wstring("yes"), nl.

?- halt.
