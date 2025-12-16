:- module(test_ai, []).

:- use_module(library(plunit)).
% Import des modules du projet
:- use_module('../src/ai').

:- begin_tests(ai).

test(first_free_index) :-
	C0 = [x,o,_,_,_,_],
	length(C1,6), length(C2,6), length(C3,6), length(C4,6), length(C5,6), length(C6,6),
	Board = [C0,C1,C2,C3,C4,C5,C6],
	firstFreeIndexColonne(Board,0,Index),
	assertion(Index == 2).

test(gagnable_detects_win) :-
	Col0 = [x,x,x,_,_,_],
	length(C1,6), length(C2,6), length(C3,6), length(C4,6), length(C5,6), length(C6,6),
	Board = [Col0,C1,C2,C3,C4,C5,C6],
	gagnable(Board, 'x', Col),
	assertion(Col == 0).

test(ia1_returns_nonfull_column) :-
	length(C0,6), length(C1,6), length(C2,6), length(C3,6), length(C4,6), length(C5,6), length(C6,6),
	Board = [C0,C1,C2,C3,C4,C5,C6],
	ia1(Board, Col, Index, _),
	assertion(Index \== 6).

:- end_tests(ai).