:- use_module('../metagol').

%% metagol settings
metagol:functional.

%% tell metagol to use the BK
prim(copy1/2).
prim(skip1/2).
prim(write1/3).
prim(next_empty/1).

%% metarules
metarule([P,Q,R],([P,A,B]:-[[Q,A,C],[R,C,B]])).
metarule([P,Q,R],([P,A,B]:-[[Q,A],[R,A,B]])).
metarule([P,Q,X],([P,A,B]:-[[Q,A,B,X]])).
metarule([P,Q],([P,A,B]:-[[Q,A,C],@term_gt(A,C),[P,C,B],@term_gt(C,B)])).
%% SEE STRINGS3 FOR AN EXAMPLE WITHOUT AN ORDERING CONSTRAINT

%% background knowledge
copy1([H|RestIn]/[H|RestOut],[H|RestIn]/RestOut).
skip1([_|RestIn]/Out,RestIn/Out).
write1(In/[H|RestOut],In/RestOut,H).
next_empty([_]/_).

func_test(Atom,PS,G):-
  Atom = [P,In/B,_/[]],
  Actual = [P,In/Z,_/[]],
  \+ (metagol:prove_deduce([Actual],PS,G),Z \= B).

%% term ordering for recursive metarule that ensures that with each iteration the length of the string decreases
term_gt(A,B):-
  A = In1/_,
  B = In2/_,
  length(In1,X),
  length(In2,Y),
  X>Y.

a :-
  Pos = [
    f(['a','b','c']/['a','b','c','d'],_/[]),
    f(['a','a','c']/['a','a','c','d'],_/[]),
    f(['a','c']/['a','c','d'],_/[])
  ],
  learn(Pos,[]).