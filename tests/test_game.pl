:- consult('../src/board.pl').
:- consult('../src/game.pl').
:- consult('../src/rules.pl').

:- begin_tests(game).

/*Test vérifie si un joueur a déjà gagné*/
% If the board already contains a winner, play/1 should stop immediately
test(play_stops_on_gameover) :-
    % build a board where column 0 contains four 'x' from index 0..3
    Col0 = ['x','x','x','x',_,_],
    length(C1,6), length(C2,6), length(C3,6), length(C4,6), length(C5,6), length(C6,6),
    Board = [Col0,C1,C2,C3,C4,C5,C6],
    % ensure a clean dynamic board and assert our test board
    retractall(board(_)),
    assert(board(Board)),
    % calling play(_) must succeed and not enter the normal-turn branch
    play(x),
    % board fact should remain equal to what we asserted
    board(B2), assertion(B2 == Board),
    % cleanup
    retractall(board(_)).

/*Vérifie la séquence de tour (playMove -> applyIt)*/
% Simulate one-turn sequence (playMove -> applyIt) and verify the board updated
test(turn_sequence_applyIt) :-
    % create an empty board
    length(C0,6), length(C1,6), length(C2,6), length(C3,6), length(C4,6), length(C5,6), length(C6,6),
    Board = [C0,C1,C2,C3,C4,C5,C6],
    retractall(board(_)), assert(board(Board)),
    % simulate playing 'x' at column 4, row 2
    playMove(Board, 4, 2, NewBoard, x),
    applyIt(Board, NewBoard),
    % verify the dynamic board was updated and contains 'x' at the right place
    board(B3), nth0(4,B3,Col4), nth0(2,Col4,Val), assertion(Val == x),
    retractall(board(_)).

:- end_tests(game).
