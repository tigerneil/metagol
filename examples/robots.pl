:- use_module('../metagol').

%% metagol settings
metagol:functional.
metagol:max_clauses(10).

%% tell metagol to use the BK
prim(move_left/2).
prim(move_right/2).
prim(move_forwards/2).
prim(move_backwards/2).
prim(grab_ball/2).
prim(drop_ball/2).

%% metarules
metarule([P,Q],([P,A,B]:-[[Q,A,B]])).
metarule([P,Q,R],([P,A,B]:-[[Q,A,C],[R,C,B]])).

%% functional check
func_test(Atom,PS,G):-
  Atom = [P,A,B],
  Actual = [P,A,Z],
  \+ (metagol:prove_deduce([Actual],PS,G),Z \= B).

%% robot learning to move a ball to a specific position
a :-
  Pos = [f(world((1/1),(1/1),false),world((3/3),(3/3),false))],
  learn(Pos,[]).

b :-
  Pos = [f(world((1/1),(1/1),false),world((5/5),(5/5),false))],
  learn(Pos,[]).

c :-
  Pos = [f(world((1/1),(1/1),false),world((6/6),(6/6),false))],
  learn(Pos,[]).

d :-
  Pos = [f(world((1/1),(1/1),false),world((7/7),(7/7),false))],
  learn(Pos,[]).

%% background knowledge
max_right(6).
max_forwards(6).

grab_ball(world(Pos,Pos,false),world(Pos,Pos,true)).

drop_ball(world(Pos,Pos,true),world(Pos,Pos,false)).

move_left(world(X1/Y1,Bpos,false),world(X2/Y1,Bpos,false)):-
  X1 > 0,
  X2 is X1-1.

move_left(world(X1/Y1,_,true),world(X2/Y1,X2/Y1,true)):-
  X1 > 0,
  X2 is X1-1.

move_right(world(X1/Y1,Bpos,false),world(X2/Y1,Bpos,false)):-
  max_right(MAXRIGHT),
  X1 < MAXRIGHT,
  X2 is X1+1.

move_right(world(X1/Y1,_,true),world(X2/Y1,X2/Y1,true)):-
  max_right(MAXRIGHT),
  X1 < MAXRIGHT,
  X2 is X1+1.

move_backwards(world(X1/Y1,Bpos,false),world(X1/Y2,Bpos,false)):-
  Y1 > 0,
  Y2 is Y1-1.

move_backwards(world(X1/Y1,_,true),world(X1/Y2,X1/Y2,true)):-
  Y1 > 0,
  Y2 is Y1-1.

move_forwards(world(X1/Y1,Bpos,false),world(X1/Y2,Bpos,false)):-
  max_forwards(MAXFORWARDS),
  Y1 < MAXFORWARDS,
  Y2 is Y1+1.

move_forwards(world(X1/Y1,_,true),world(X1/Y2,X1/Y2,true)):-
  max_forwards(MAXFORWARDS),
  Y1 < MAXFORWARDS,
  Y2 is Y1+1.