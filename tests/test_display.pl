:- module(test_display, []).

:- use_module(library(plunit)).
% Import des modules du projet
:- use_module('../src/display').

:- use_module('../src/board').

:- begin_tests(display).

test(displayBoard_succeeds) :-
	retractall(board(_)),
	length(C0,6), length(C1,6), length(C2,6), length(C3,6), length(C4,6), length(C5,6), length(C6,6),
	Board = [C0,C1,C2,C3,C4,C5,C6],
	assert(board(Board)),
	displayBoard,
	retractall(board(_)).

:- end_tests(display).