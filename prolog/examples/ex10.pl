/*****************************************************************************/
/*                                                                           */
/* Example file part of M.sc. Thesis "Verification of CCS-processes"         */
/*                      1987 by Michael Hillerström                          */
/*                                                                           */
/* Annotated for automatic snipplet construction and inclusion into thesis.  */
/*                                                                           */
/*****************************************************************************/

?- ['../newwbisim'].

/*#snipplet: ex10a.inp */
/*#filter: s/?- //g */
?- man :=: injob;(in(gh); out(ph); outjob; man +
               in(gm); out(pm); outjob; man).
/*#end*/

/*#snipplet: ex10b.inp */
/*#filter: s/?- //g */
?- hammer :=: out(gh); in(ph); hammer.
?- mallet :=: out(gm); in(pm); mallet.
/*#end*/

/*#snipplet: ex10c.inp */
/*#filter: s/?- //g */
?- closedshop :=: (man/man/hammer/mallet)\[injob,outjob].
/*#end*/

/*#snipplet: ex10d.inp */
/*#filter: s/?- //g */
?- one :=: injob; outjob; one + outjob; injob; one.
?- donothing :=: injob; one.
/*#end*/

?- showdecl.

/*#filter: s/?- //g */
?- wstring("!out!"), nl, wstring("bisim(closedshop,donothing)."), nl.
/*#snipplet: ex10.cmd */
?- bisim(closedshop,donothing).
/*#end*/
?- nl, wstring("yes").

?- halt.
