/*****************************************************************************/
/*                                                                           */
/* Example file part of M.sc. Thesis "Verification of CCS-processes"         */
/*                      1987 by Michael Hillerström                          */
/*                                                                           */
/* Annotated for automatic snipplet construction and inclusion into thesis.  */
/*                                                                           */
/*****************************************************************************/

?- ['../extwbisim'].

/*#snipplet: ex12.inp */
/*#filter: s/?- //g */
?- sys :=: (s0/m_sr0/r0/m_rs0)\[in,out].
?- spec :=: in; out; spec.
?- s0 :=: in; out(a); in(d); s0.
?- r0 :=: in(b); out; out(c); r0.
?- m_sr0 :=: in(a); out(b); m_sr0.
?- m_rs0 :=: in(c); out(d); m_rs0.
/*#end*/

?- showdecl.

/*#filter: s/?- //g */
?- wstring("!out!"), nl, wstring("bisim(sys,spec)."), nl.
/*#snipplet: ex12.cmd */
?- bisim(sys,spec).
/*#end*/
?- nl, wstring("yes").

?- halt.
