/*****************************************************************************/
/*                                                                           */
/* Example file part of M.sc. Thesis "Verification of CCS-processes"         */
/*                      1987 by Michael Hillerström                          */
/*                                                                           */
/* Annotated for automatic snipplet construction and inclusion into thesis.  */
/*                                                                           */
/*****************************************************************************/

?- ['../extwbisim'].

?- man :=: injob;(in(gh); out(ph); outjob; man +
               in(gm); out(pm); outjob; man).
?- hammer :=: out(gh); in(ph); hammer.
?- mallet :=: out(gm); in(pm); mallet.
?- closedshop :=: (man/man/hammer/mallet)\[injob,outjob].
?- one :=: injob; outjob; one + outjob; injob; one.
?- donothing :=: injob; one.

?- showdecl.

/*#filter: s/?- //g */
?- wstring("!out!"), nl, wstring("bisim(closedshop,donothing)."), nl.
/*#snipplet: ex21.cmd */
?- bisim(closedshop,donothing).
/*#end*/
?- nl, wstring("yes").

?- halt.
