bisim(P,Q) :- 
   closure(P,Q,[[P,Q]],C),
   prettyprint(P,Q,C,[]).

closure(P,Q,B,D) :-
   derset(P,M), matchl(P,Q,M,B,C),
   derset(Q,N), matchr(P,Q,N,C,D).

matchl(P,Q,[],B,B).
matchl(P,Q,[[A,P1]|M],B,D) :-
   der(Q,A,Q1),
   in([P1,Q1],B), !,
   matchl(P,Q,M,B,D).
matchl(P,Q,[[A,P1]|M],B,D) :-
   der(Q,A,Q1),
   closure(P1,Q1,[[P1,Q1]|B],C),
   matchl(P,Q,M,C,D).

matchr(P,Q,[],B,B).
matchr(P,Q,[[A,Q1]|N],B,D) :-
   der(P,A,P1),
   in([P1,Q1],B), !,
   matchr(P,Q,N,B,D).
matchr(P,Q,[[A,Q1]|N],B,D) :-
   der(P,A,P1),
   closure(P1,Q1,[[P1,Q1]|B],C),
   matchr(P,Q,N,C,D).

