/*****************************************************************************/
/*                                                                           */
/* Example file part of M.sc. Thesis "Verification of CCS-processes"         */
/*                      1987 by Michael Hillerström                          */
/*                                                                           */
/* Annotated for automatic snipplet construction and inclusion into thesis.  */
/*                                                                           */
/*****************************************************************************/

?- ['../newwbisim'].

?- s0 :=: in; out(a); in(d); s0.
?- r0 :=: in(b); out; out(c); r0.
?- spec :=: in; out; spec.

/*#snipplet: ex8a.inp */
/*#filter: s/?- //g */
?- m_sr1 :=: in(a); (out(b); m_sr1 + tau; m_sr1).
?- m_rs1 :=: in(c); (out(d); m_rs1 + tau; m_rs1).
/*#end*/

/*#snipplet: ex8b.inp */
/*#filter: s/?- //g */
?- sys1 :=: (s0/m_sr1/r0/m_rs1)\[in,out].
/*#end*/

?- showdecl.

/*#filter: s/?- //g */
?- wstring("!out!"), nl, wstring("bisim(sys1,spec)."), nl.
/*#snipplet: ex8.cmd */
?- bisim(sys1,spec).
/*#end*/
?- nl, wstring("yes").

?- halt.
