:- module(main, [main/0]).

% Charger les modules du projet
:- use_module(src/board).
:- use_module(src/display).
:- use_module(src/rules).
:- use_module(src/winner).
:- use_module(src/ai).
:- use_module(src/minimax).
:- use_module(src/game).

% Charger la librairie de tests
:- use_module(library(plunit)).

% Charger les tests
:- use_module(tests/test_board).
:- use_module(tests/test_winner).
:- use_module(tests/test_rules).
:- use_module(tests/test_minimax).
:- use_module(tests/test_game).
:- use_module(tests/test_display).
:- use_module(tests/test_ai).

% Pour le CI
main :-
    run_tests,
    halt.

% Lancer automatiquement
:- initialization(main, main).
