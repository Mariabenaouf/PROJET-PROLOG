:- module(test_minimax, []).

:- use_module(library(plunit)).

% Import des modules du projet
:- use_module('../src/winner').
:- use_module('../src/minimax').
:- use_module('../src/ai').

:- begin_tests(minimax).

/* verifications de la fonction utility (signature utility(Board,Player,Utility)) */
test(utility_positive_for_x_win) :-
    Col0 = ['x','x','x','x',_,_],
    length(C1,6), length(C2,6), length(C3,6), length(C4,6), length(C5,6), length(C6,6),
    Board = [Col0,C1,C2,C3,C4,C5,C6],
    utility(Board, x, U), assertion(U >= 10000).

test(utility_positive_for_o_win_when_evaluating_o) :-
    % horizontal o win on row 1 across columns 1..4
    C0 = [_,_,_,_,_,_],
    C1 = [_,o,_,_,_,_],
    C2 = [_,o,_,_,_,_],
    C3 = [_,o,_,_,_,_],
    C4 = [_,o,_,_,_,_],
    length(C5,6), length(C6,6),
    Board = [C0,C1,C2,C3,C4,C5,C6],
    utility(Board, o, U), assertion(U >= 10000).

test(utility_returns_0_for_empty_board_and_isEmpty_true) :-
    length(C0,6), length(C1,6), length(C2,6), length(C3,6), length(C4,6), length(C5,6), length(C6,6),
    Board = [C0,C1,C2,C3,C4,C5,C6],
    isBoardEmpty(Board),
    utility(Board, x, U), assertion(U == 0).

/* verifications de firstFreeIndexColonne : doit retourner l'index libre dans une colonne */
test(firstFreeIndexColonne_returns_index) :-
    % Column 0 has two filled then free at index 2
    C0 = [x,o,_,_,_,_],
    length(C1,6), length(C2,6), length(C3,6), length(C4,6), length(C5,6), length(C6,6),
    Board = [C0,C1,C2,C3,C4,C5,C6],
    firstFreeIndexColonne(Board, 0, Index), assertion(Index == 2).

test(firstFreeIndexColonne_returns_6_for_full_column) :-
    Cfull = [x,o,x,o,x,o],
    length(C1,6), length(C2,6), length(C3,6), length(C4,6), length(C5,6), length(C6,6),
    Board = [Cfull,C1,C2,C3,C4,C5,C6],
    firstFreeIndexColonne(Board, 0, Index), assertion(Index == 6).

/* teste les moves possibles */
test(possible_moves_excludes_full_columns) :-
    Cfull = [x,o,x,o,x,o],
    Cfree = [_,_,_,_,_,_],
    Board = [Cfull,Cfree,Cfree,Cfull,Cfree,Cfree,Cfree],
    possible_moves(Board, List),
    % full columns (0 and 3) should not appear
    \+ member(0, List), \+ member(3, List),
    % some free columns should appear
    member(1, List), member(2, List), assertion(is_list(List)).

:- end_tests(minimax).
