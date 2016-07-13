/*****************************************************************************/
/*                                                                           */
/* Example file part of M.sc. Thesis "Verification of CCS-processes"         */
/*                      1987 by Michael Hillerström                          */
/*                                                                           */
/* Annotated for automatic snipplet construction and inclusion into thesis.  */
/*                                                                           */
/*****************************************************************************/

?- ['../newwbisim'].

/*#snipplet: ex9a.inp */
/*#filter: s/?- //g */
?- aux_s1 :=: out(a); aux_s1 + in(d); s1.
?- s1 :=: in(d); s1 + in; aux_s1.
?- aux_r1 :=: in(b); aux_r1 + out; r1.
?- r1 :=: out(c); r1 + in(b); aux_r1.
/*#end*/

?- m_sr1 :=: in(a); (out(b); m_sr1 + tau; m_sr1).
?- m_rs1 :=: in(c); (out(b); m_rs1 + tau; m_rs1).

/*#snipplet: ex9b.inp */
/*#filter: s/?- //g */
?- sys2 :=: (s1/m_sr1/r1/m_rs1)\[in,out].
/*#end*/

?- spec :=: in; out; spec.

?- showdecl.

/*#filter: s/?- //g */
?- wstring("!out!"), nl, wstring("bisim(sys2,spec)."), nl.
/*#snipplet: ex9.cmd */
?- bisim(sys2,spec).
/*#end*/
?- nl, wstring("yes").

?- halt.
