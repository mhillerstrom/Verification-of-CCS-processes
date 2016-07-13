/*****************************************************************************/
/*                                                                           */
/* Example file part of M.sc. Thesis "Verification of CCS-processes"         */
/*                      1987 by Michael Hillerström                          */
/*                                                                           */
/* Annotated for automatic snipplet construction and inclusion into thesis.  */
/*                                                                           */
/*****************************************************************************/

?- ['../newwbisim'].

/*#snipplet: ex7.inp */
/*#filter: s/?- //g */
?- spec :=: in; out; spec.
/*#end*/

/*#snipplet: ex7a.inp */
/*#filter: s/?- //g */
?- m_sr0 :=: in(a); out(b); m_sr0.
?- m_rs0 :=: in(c); out(d); m_rs0.
/*#end*/

/*#snipplet: ex7b.inp */
/*#filter: s/?- //g */
?- s0 :=: in; out(a); in(d); s0.
?- r0 :=: in(b); out; out(c); r0.
/*#end*/

/*#snipplet: ex7c.inp */
/*#filter: s/?- //g */
?- sys :=: (s0/m_sr0/r0/m_rs0)\[in,out].
/*#end*/

?- showdecl.

/*#filter: s/?- //g */
?- wstring("!out!"), nl, wstring("bisim(sys,spec)."), nl.
/*#snipplet: ex7.cmd */
?- bisim(sys,spec).
/*#end*/
?- nl, wstring("yes").

?- halt.
