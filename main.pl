:- consult(board).
:- consult(display).
:- consult(rules).
:- consult(winner).
:- consult(game).

start_human_vs_ai :-
    init,
    play(human).
