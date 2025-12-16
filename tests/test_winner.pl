
:- module(test_game, []).

:- use_module(library(plunit)).
% Import des modules du projet
:- use_module('../src/board').
:- use_module('../src/winner').

:- begin_tests(winner).

/*test de win vertical*/
test(vertical_win_x) :-
	% Column 0 has four x in a row at indices 0..3
	Col0 = ['x','x','x','x',_,_],
	length(C1,6), length(C2,6), length(C3,6), length(C4,6), length(C5,6), length(C6,6),
	Board = [Col0,C1,C2,C3,C4,C5,C6],
	assertion(winner(Board,'x')).
    
/*test de win horizontal*/
test(horizontal_win_o) :-
	% Row 2 (index 2) across columns 0..3 are 'o'
	C0 = [_,_,o,_,_,_],
	C1 = [_,_,o,_,_,_],
	C2 = [_,_,o,_,_,_],
	C3 = [_,_,o,_,_,_],
	length(C4,6), length(C5,6), length(C6,6),
	Board = [C0,C1,C2,C3,C4,C5,C6],
	assertion(winner(Board,o)).

/*test de win diagonal*/
test(diagonal_bh_win_x) :-
	% Diagonal from (col0,row0) to (col3,row3): x at (0,0),(1,1),(2,2),(3,3)
	C0 = [x,_,_,_,_,_],
	C1 = [_,x,_,_,_,_],
	C2 = [_,_,x,_,_,_],
	C3 = [_,_,_,x,_,_],
	length(C4,6), length(C5,6), length(C6,6),
	Board = [C0,C1,C2,C3,C4,C5,C6],
	assertion(winner(Board,'x')).

/*test si le board est plein*/
test(is_board_full_true) :-
	% All cells filled (simple full board)
	Col1 = [x,x,x,x,x,x], Col2 = [o,o,o,o,o,o], Col3 = [x,x,x,x,x,x],
	Col4 = [o,o,o,o,o,o], Col5 = [x,x,x,x,x,x], Col6 = [o,o,o,o,o,o], Col7 = [x,x,x,x,x,x],
	Board = [Col1,Col2,Col3,Col4,Col5,Col6,Col7],
	assertion(isBoardFull(Board)).

test(is_board_full_false) :-
	% Fresh empty board should not be full
	length(C0,6), length(C1,6), length(C2,6), length(C3,6), length(C4,6), length(C5,6), length(C6,6),
	Board = [C0,C1,C2,C3,C4,C5,C6],
	\+ isBoardFull(Board).

:- end_tests(winner).

