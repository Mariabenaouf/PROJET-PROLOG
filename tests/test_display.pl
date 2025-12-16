:- module(test_display, []).
% Module de tests pour l'affichage (displayBoard/0).
% On ne teste pas "ce qui est imprimé exactement",
% on teste simplement que l'appel réussit (donc pas d'erreur / pas d'échec).

:- use_module(library(plunit)).
% Framework de tests unitaires plunit

:- use_module('../src/display').
% On importe displayBoard/0 (affiche le plateau en console)

:- use_module('../src/board').
% displayBoard/0 lit le plateau via board:board/1 (fait dynamique),
% donc on doit pouvoir initialiser/vider ce fait dans le test.

:- begin_tests(display).
% Début du groupe de tests "display"

test(displayBoard_succeeds) :-
    % Nettoyage : on s'assure qu'il n'y a pas d'ancien plateau
    % dans la base dynamique du module board.
    retractall(board:board(_)),

    % On crée un plateau vide :
    % 7 colonnes de 6 cases non instanciées.
    length(C0,6), length(C1,6), length(C2,6),
    length(C3,6), length(C4,6), length(C5,6), length(C6,6),
    Board = [C0,C1,C2,C3,C4,C5,C6],

    % On injecte ce plateau dans l'état global (module board).
    % C'est essentiel : displayBoard/0 appelle board(B) en interne,
    % donc il faut que board:board/1 existe.
    assert(board:board(Board)),

    % Appel de l'affichage :
    % Le test passe si displayBoard réussit (ne plante pas et ne fail pas).
    displayBoard,

    % Nettoyage final pour ne pas polluer les tests suivants.
    retractall(board:board(_)).

:- end_tests(display).
% Fin du groupe de tests "display"

