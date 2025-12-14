:- initialization(main,main).

main :-
    % Charger les fichiers du code source
    consult('src/minimax.pl'),
    consult('src/board.pl'),
    consult('src/display.pl'),
    consult('src/rules.pl'),
    consult('src/winner.pl'),
    consult('src/game.pl'),

    % Charger les fichiers de tests
    consult('tests/test_board.pl'),
    consult('tests/test_winner.pl'),
    consult('tests/test_rules.pl'),
    consult('tests/test_minimax.pl'),   
    consult('tests/test_game.pl'),
    consult('tests/test_display.pl'),
    consult('tests/test_ai.pl'),

    % Lancer les tests
    run_tests,

    halt.
