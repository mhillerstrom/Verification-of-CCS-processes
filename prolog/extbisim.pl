/*****************************************************************************/
/*                                                                           */
/*      Expressions denoting Processes is given by the following             */
/*      grammar:                                                             */
/*                                                                           */
/*                                                                           */
/*           P ::=   i           (process identifier defined by :=:)         */
/*                |  nil         (inaction)                                  */
/*                |  a;P         (prefixing)                                 */
/*                |  P+P         (summation of processes)                    */
/*                |  P/P         (concurrent composition of processes)       */
/*                |  P\L         (restricts Ps action to L,                  */
/*                                where L is a list of atoms)                */
/*                |  P-[A:=B]    (renames Ps action according to A:=B,       */
/*                                where A and B are atoms)                   */
/*                                                                           */
/*                                                                           */
/*      The process identifiers are specified by simultaneous recursion:     */
/*                                                                           */
/*           i1 :=: P1.                                                      */
/*              .                                                            */
/*              .                                                            */
/*           in :=: Pn.                                                      */
/*                                                                           */
/*      where P1,...,Pn are process expressions over i1,...,in.              */
/*                                                                           */
/*                                                                           */
/*****************************************************************************/




/*****************************************************************************/
/*                                                                           */
/*                      O P E R A T I O N S                                  */
/*                                                                           */
/*****************************************************************************/

:- op(40,xfy,:=:).
:- op(11,xfy,;).
:- op(20,xfy,+).
:- op(30,xfy,/).
:- op(15,xfy,\).
:- op(15,yfx,-).
:- op(14,xfy,'and').
:- op(13,xfy,'or').
:- op(12,fy,'no').
:- op(11,xfy,';').
:- op(11,xfy,'&').
:- op(10,xfy,:=).

str(and,and).
str(or,or).



/*****************************************************************************/
/*                                                                           */
/*                 A U X I L I A R Y  P R E D I C A T E S                    */
/*                                                                           */
/*****************************************************************************/

in(A,[A|L]).
in(A,[B|L]) :- in(A,L).

append([],L,L).
append([X|L1],L2,[X|L3]) :- append(L1,L2,L3).

delete(A,[],[]).
delete(A,[A|L],M) :- delete(A,L,M).
delete(A,[B|L],[B|M]) :-  delete(A,L,M).

reduce([],[]).
reduce([A|L],[A|RL]) :- delete(A,L,L1), reduce(L1,RL).

reverse(L,RL) :- rev(L,[],RL).
rev([A|L],L2,L3) :- rev(L,[A|L2],L3).
rev([],RL,RL).

action(in(A)) :- atom(A).
action(out(A)) :- atom(A).
action(A) :- atom(A).

listofactions([]).
listofactions([A|L]) :- atom(A), listofactions(L).

listofassign([]).
listofassign([A:=B|L]) :- atom(A), atom(B), listofassign(L).



/*****************************************************************************/
/*                                                                           */
/*                O P E R A T I O N A L  S E M A N T I C S                   */
/*                                                                           */
/*****************************************************************************/

der(A;P,A,P).
der(P + Q,A,R) :- der(P,A,R).
der(P + Q,A,R) :- der(Q,A,R).
der(P / Q,A,R / Q) :- der(P,A,R).
der(P / Q,A,P / S) :- der(Q,A,S).
der(P / Q,tau,R / S) :- der(P,in(A),R), der(Q,out(A),S).
der(P / Q,tau,R / S) :- der(P,out(A),R), der(Q,in(A),S).
der(P\L,in(A),Q\L) :- in(A,L), der(P,in(A),Q).
der(P\L,out(A),Q\L) :- in(A,L), der(P,out(A),Q).
der(P\L,A,Q\L) :- in(A,L), der(P,A,Q).
der(P\L,tau,Q\L) :- der(P,tau,Q).
der(P-[A:=B],in(B),Q-[A:=B]) :- der(P,in(A),Q).
der(P-[A:=B],out(B),Q-[A:=B]) :- der(P,out(A),Q).
der(P-[A:=B],B,Q-[A:=B]) :- der(P,A,Q).
der(P-[A:=B],in(C),Q-[A:=B]) :- der(P,in(C),Q), A\= C.
der(P-[A:=B],out(C),Q-[A:=B]) :- der(P,out(C),Q), A\= C.
der(P-[A:=B],C,Q-[A:=B]) :- der(P,C,Q), atom(C), A\= C.
der(P,A,Q) :- decl(P,B), der(B,A,Q).

derset(P,M) :- setof([A,Q],der(P,A,Q),M), !.
derset(P,[]).



/*****************************************************************************/
/*                                                                           */
/*              O B S E R V A T I O N A L  S E M A N T I C S                 */
/*                                                                           */
/*****************************************************************************/

obder(P,tau,P).
obder(P,A,Q) :-
   der(P,tau,R), P\==R, obder(R,A,Q).
obder(P,A,Q) :-
   der(P,A,R), A\==tau, obder(R,tau,Q).



/*****************************************************************************/
/*                                                                           */
/*                R E C U R S I V E  D E F I N I T I O N S                   */
/*                                                                           */
/*****************************************************************************/

N :=: B :- asserta(decl(N,B)).



/*****************************************************************************/
/*                                                                           */
/*                 S T R O N G  B I S I M U L A T I O N S                    */
/*                                                                           */
/*        To get weak bisimulations replace 'der' with 'obder'.              */
/*                                                                           */
/*****************************************************************************/

bisim(P,Q) :-
   nl, wstring("Searching for a strong bisimulation..."), nl,
   closure(P,Q,[[P,Q]],C,[],Fout), prettyprint(P,Q,C,Fout).

closure(P,Q,B,D,Fin,Fout) :-
   derset(P,M), matchl(P,Q,M,B,C,Fin,F1), not(in([P,Q,_],F1)), !,
   derset(Q,N), matchr(P,Q,N,C,D,F1,Fout).
closure(P,Q,B,D,Fin,Fout) :-
   derset(P,M), matchl(P,Q,M,B,D,Fin,Fout).

matchl(P,Q,[],B,B,Fin,Fin).
matchl(P,Q,[[A,P1]|M],B,D,Fin,Fout) :-
   not(in([P,Q,_],Fin)),
   der(Q,A,Q1), in([P1,Q1,_,_],B),
   add_f(P,Q,[[A,P1],Q1],B,B1), !,
   matchl(P,Q,M,B1,D,Fin,Fout).
matchl(P,Q,[[A,P1]|M],B,D,Fin,Fout) :-
   not(in([P,Q,_],Fin)),
   der(Q,A,Q1),
   not(in([P1,Q1,_],Fin)),
   add_f(P,Q,[[A,P1],Q1],B,B1),
   closure(P1,Q1,[[P1,Q1,[],[]]|B1],C,Fin,F1),
   in([P1,Q1,_],F1), !,
   matchl(P,Q,[[A,P1]|M],B,D,F1,Fout).
matchl(P,Q,[[A,P1]|M],B,D,Fin,Fout) :-
   not(in([P,Q,_],Fin)),
   der(Q,A,Q1),
   not(in([P1,Q1,_],Fin)),
   add_f(P,Q,[[A,P1],Q1],B,B1), !,
   closure(P1,Q1,[[P1,Q1,[],[]]|B1],C,Fin,F1),
   not(in([P1,Q1,_],F1)),
   matchl(P,Q,M,C,D,F1,Fout).
matchl(P,Q,[[A,P1]|M],B,B,Fin,[[P,Q,A&G]|Fin]) :-
   not(in([P,Q,_],Fin)), !,
   findall(F1, ( der(Q,A,Q1), in([P1,Q1,F1],Fin) ), LF),
   reduce(LF,RLF), conjunctlist(RLF,G).
matchl(P,Q,[[A,P1]|M],B,B,Fin,Fin).

matchr(P,Q,[],B,B,Fin,Fin).
matchr(P,Q,[[A,Q1]|N],B,D,Fin,Fout) :-
   not(in([P,Q,_],Fin)),
   der(P,A,P1), in([P1,Q1,_,_],B),
   add_g(P,Q,[[A,Q1],P1],B,B1), !,
   matchr(P,Q,N,B1,D,Fin,Fout).
matchr(P,Q,[[A,Q1]|N],B,D,Fin,Fout) :-
   not(in([P,Q,_],Fin)),
   der(P,A,P1),
   not(in([P1,Q1,_],Fin)),
   add_g(P,Q,[[A,Q1],P1],B,B1),
   closure(P1,Q1,[[P1,Q1,[],[]]|B1],C,Fin,F1),
   in([P1,Q1,_],F1), !,
   matchr(P,Q,[[A,Q1]|N],B1,D,F1,Fout).
matchr(P,Q,[[A,Q1]|N],B,D,Fin,Fout) :-
   not(in([P,Q,_],Fin)),
   der(P,A,P1),
   not(in([P1,Q1,_],Fin)),
   add_g(P,Q,[[A,Q1],P1],B,B1),
   closure(P1,Q1,[[P1,Q1,[],[]]|B1],C,Fin,F1),
   not(in([P1,Q1,_],F1)),
   matchr(P,Q,N,C,D,F1,Fout).
matchr(P,Q,[[A,Q1]|N],B,B,Fin,[[P,Q,A;G]|Fin]) :-
   not(in([P,Q,_],Fin)), !,
   findall(F1, ( der(P,A,P1), in([P1,Q1,F1],Fin) ), LF),
   reduce(LF,RLF), disjunctlist(RLF,G).
matchr(P,Q,[[A,Q1]|N],B,B,Fin,Fin).

conjunctlist([],tt).
conjunctlist([F|[]],F).
conjunctlist([F|LF],F and G) :- conjunctlist(LF,G).

disjunctlist([],no tt).
disjunctlist([F|[]],F).
disjunctlist([F|LF],F or G) :- disjunctlist(LF,G).

add_f(P,Q,D,[],[]).
add_f(P,Q,D,[[P,Q,F,G]|L],[[P,Q,[D|F],G]|L1]) :-
    add_f(P,Q,D,L,L1).
add_f(P,Q,D,[A|L],[A|L1]) :-
    add_f(P,Q,D,L,L1).

add_g(P,Q,D,[],[]).
add_f(P,Q,D,[[P,Q,F,G]|L],[[P,Q,F,[D|G]]|L1]) :-
    add_g(P,Q,D,L,L1).
add_g(P,Q,D,[A|L],[A|L1]) :-
    add_g(P,Q,D,L,L1).


/*****************************************************************************/
/*                                                                           */
/*                      H E L P  P R E D I C A T E S                         */
/*                                                                           */
/*****************************************************************************/

showdecl :-
   nl, decl(N,B), write(N), wstring(":=: "), write(B), wstring("."), nl, fail.
showdecl :- nl.

deldecl :- retractall(decl(N,P)), wstring("All declarations deleted."), nl.

showder :- listing(fderset).
cleanup :- retractall(fderset(A,B)).

bisim_type(strong).   /* change to 'weak' if weak bisimulations are desired */
bisim_type :- bisim_type(T), tab(1), write(T), tab(1).

help :-
   wstring("HELP menu for finding"), bisim_type,
   wstring("bisimulations."), nl, nl,
   wstring("To get information on a specific subject"), nl,
   wstring("you should type:   help( subj )"), nl,
   wstring("where 'subj' is one of the following subjects:"), nl, subjects.
help(Subject) :-
   subject(Subject), subject(Subject,info).
help(NoInfo) :-
   wstring("Sorry, no information available on '"), write(NoInfo),
   wstring("'."), nl.

subjects :-
   subject(Subject), write(Subject), nl, fail.
subjects.

subject(syntax).
subject(syntax,info) :-
   wstring("P ::=   i           (process identifier defined by :=:)"), nl,
   wstring("     |  nil         (inaction)"), nl,
   wstring("     |  a;P         (prefixing)"), nl,
   wstring("     |  P+P         (summation of processes)"), nl,
   wstring("     |  P/P         (concurrent composition of processes)"), nl,
   wstring("     |  P\\L         (restricts Ps action to L,"), nl,
   wstring("                     where L is a list of atoms)"), nl,
   wstring("     |  P-[A:=B]    (renames Ps action according to A:=B,"), nl,
   wstring("                     where A and B are atoms)"), nl, nl,
   wstring("A special action is the one denoting 'silent' actions, tau"), nl,
   wstring("Complementaty actions are denoted by te two predicates"), nl,
   wstring("      in(action)   and   out(action)"), nl,
   wstring("Example:  in(a) is the complement of out(a)."), nl.

subject(modal_properties).
subject(modal_properties,info) :-
   wstring("Modal properties are used in order to describe the"), nl,
   wstring("properties which a process enjoy. The modal language"), nl,
   wstring("used consists of the following constructs"), nl,
   wstring("        tt    the property which all processes enjoy"), nl,
   bisim_type(strong),
   wstring("     <a>tt    it is possible to perform an a-experiment"), nl,
   wstring(" not <a>tt    it is not possible to perform an a-experiment"), nl,
   wstring("The following short hands are used:"), nl,
   wstring("        ff    stands for    not tt"), nl,
   wstring("     [a]ff    stands for    not <a> not tt"), nl,
   wstring("Furthermore, 'and' and 'or' are used as"), nl,
   wstring("conjunction and disjunction of properties."), nl.
subject(modal_properties,info) :-
   wstring("   <<a>>tt    it is possible to perform an a-experiment"), nl,
   wstring("not<<a>>tt    it is not possible to perform an a-experiment"), nl,
   wstring("The following short hands are used:"), nl,
   wstring("        ff    stands for    not tt"), nl,
   wstring("   [[a]]ff    stands for    not <<a>> not tt"), nl,
   wstring("Furthermore, 'and' and 'or' are used as"), nl,
   wstring("conjunction and disjunction of properties."), nl.

subject(declarations).
subject(declarations,info) :-
   wstring("Declarations are use in order to define short hand"), nl,
   wstring("notations of CCS expressions and/or to define recursive"), nl,
   wstring("processes, ex."), nl,
   wstring("    bad_machine :=: in(coin);out(coffee);bad_machine +"), nl,
   wstring("                    in(coin);out(tea);bad_machine."), nl,
   wstring("The set of all declarations defined so far can be viewed by"), nl,
   wstring("   showdecl."), nl,
   wstring("and all declarations are erased by"), nl,
   wstring("   deldecl."), nl.



/*****************************************************************************/
/*                                                                           */
/*                      P R E T T Y  P R I N T I N G                         */
/*                                                                           */
/*****************************************************************************/

wstring([]).
wstring([A|L]) :-
   put(A), !, wstring(L).

prettyprint(P,Q,C,Fout) :- in([P,Q,F],Fout), sadmsg(P,Q), prettyproperties(F,O), nl, nl.
prettyprint(P,Q,C,Fout) :- happymsg(P,Q), !, postnumber(No,C,C1), !,
                           postprocess(C1,C1,C2), !, reverse(C2,RC2), prettybisim(RC2), nl.

happymsg(P,Q) :-
   wstring("Here is a listing of a strong bisimulation of the processes"),
   nl, tab(5), write(P), tab(5), wstring("and"), tab(5), write(Q),
   nl, nl.

sadmsg(P,Q) :-
   wstring("The process"), nl, tab(5), write(P), nl,
   wstring("enjoys some properties which the process"), nl,
   tab(5),
   write(Q), nl, wstring("doesn't. One property is:"), nl, tab(5).



postnumber(O,[],[]).
postnumber(No1,[[P,Q,F,G]|L],[[No,P,Q,F,G|L1]) :-
    postnumber(No,L,L1), No1 is No+1.


f_action_to_pair(B,[],[]).
f_action_to_pair(B,[[[A,P],Q]|L],[[A,No]|L1]) :-
    in([No,P,Q,F,G],B), f_action_to_pair(B,L,L1).

g_action_to_pair(B,[],[]).
g_action_to_pair(B,[[[A,Q],P]|L],[[A,No]|L1]) :-
    in([No,P,Q,F,G],B), g_action_to_pair(B,L,L1).


postprocess(C,[],[]).
postprocess(C,[[No,P,Q,F,G]|L],[[No,P,Q,F1,G1]|L1]) :-
    reduce(F,RF), f_action_to_pair(C,RF,F1), !
    reduce(G,RG), g_action_to_pair(C,Rg,G1), !
    postprocess(C,L,L1).


prettybisim([]).
prettybisim([[No,P,Q,F,G]|L]) :- 
    write(No), nl,
    write(P), nl,
    tab(15), write(Q), nl,
    print_action_to_pair("LHS",F), !,
    print_action_to_pair("RHS",G), !,
    prettybisim(L).

print_action_to_pair(Side,[]).
print_action_to_pair(Side,[[A,No]|L]) :-
    tab(25), wstring(Side), wstring("--> "), write(A),
    wstring(" ==> "), write(No), nl, !, print_action_to_pair(Side,L).


prp(F1 or F2,O) :- 
   str(or,O),
   prp(F1,or), wstring(" or "), prp(F2,or), !.
prp(F1 or F2,O) :- 
   wstring("("), prp(F1,or),
   wstring(" or "), prp(F2,or),
   wstring(")").
prp(F1 and F2,O) :- 
   str(and,O),
   prp(F1,and), wstring(" and "), prp(F2,and), !.
prp(F1 and F2,O) :-
   wstring("("), prp(F1,and),
   wstring(" and "), prp(F2,and),
   wstring(")").
prp(no (no F),O) :-
   prp(F,O).
prp(no (F1 or F2),O) :-
   prp((no F1) and (no F2),O).
prp(no (F1 and F2),O) :-
   prp((no F1) or (no F2),O).
prp(no (A;F),O) :-
   prp(A&(no F),O).
prp(no (A&F),O) :-
   prp(A;(no F),O).
prp(no tt,O) :-
   wstring("ff").
prp(A;F,O) :-
   wstring("["), write(A), wstring("]"), prp(F,;).
prp(A&F,O) :-
   wstring("<"), write(A), wstring(">"), prp(F,&).
prp(tt,O) :-
   wstring("tt"), !.
prp(ff,O) :-
   wstring("ff"), !.
prp(F,O) :-
   nl, nl, wstring("This is an impossible situation!!!"), nl.

