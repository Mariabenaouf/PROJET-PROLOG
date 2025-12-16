:- module(test_board, []).

:- use_module(library(plunit)).
% Import des modules du projet
:- use_module('../src/board').

:- begin_tests(board).

test(init_creates_board) :-
	retractall(board(_)),
	length(C0,6), length(C1,6), length(C2,6), length(C3,6), length(C4,6), length(C5,6), length(C6,6),
	Board = [C0,C1,C2,C3,C4,C5,C6],
	assert(board(Board)),
	board(B), length(B,7),
	forall(member(Col, B), length(Col,6)),
	retractall(board(_)).

test(applyIt_updates_board) :-
	% original empty board
	length(A0,6), length(A1,6), length(A2,6), length(A3,6), length(A4,6), length(A5,6), length(A6,6),
	Board = [A0,A1,A2,A3,A4,A5,A6],
	retractall(board(_)), assert(board(Board)),
	% create a new board with an 'x' at column 2, row 1
	B0 = A0, B1 = A1, B2 = [_,x,_,_,_,_], length(B3,6), length(B4,6), length(B5,6), length(B6,6),
	NewBoard = [B0,B1,B2,B3,B4,B5,B6],
	applyIt(Board, NewBoard),
	board(B), nth0(2,B,Col2), nth0(1,Col2,Val), assertion(Val == x),
	retractall(board(_)).

:- end_tests(board).