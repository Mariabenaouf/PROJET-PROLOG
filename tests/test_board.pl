:- module(test_board, []).
% Module de tests pour board.pl.
% board.pl gère l'état du jeu via un fait dynamique board/1 :
% - on peut "stocker" le plateau courant en base de faits
% - et le remplacer quand un coup est joué

:- use_module(library(plunit)).
% Framework de tests unitaires

:- use_module('../src/board').
% On importe le module board, qui contient :
% - board/1 (fait dynamique)
% - applyIt/2 (mise à jour du plateau)
% - init/0 (initialisation du plateau mais chez vous init lance aussi un match,
%   donc on évite de l'appeler directement dans les tests)

:- begin_tests(board).
% Début du groupe de tests "board"

% -------------------------------------------------------------------
% TEST 1 : vérifier que la structure du plateau est correcte
% -------------------------------------------------------------------
test(init_creates_board) :-
    % Nettoyage : on supprime un éventuel plateau déjà présent
    retractall(board:board(_)),

    % On construit un plateau vide manuellement :
    % 7 colonnes, chaque colonne est une liste de 6 cases (variables)
    length(C0,6), length(C1,6), length(C2,6),
    length(C3,6), length(C4,6), length(C5,6), length(C6,6),
    Board = [C0,C1,C2,C3,C4,C5,C6],

    % On injecte ce plateau dans l'état dynamique (dans le module board)
    assert(board:board(Board)),

    % On relit ce plateau depuis la base dynamique
    board:board(B),

    % 1) On vérifie qu'il y a bien 7 colonnes
    length(B, 7),

    % 2) On vérifie que chaque colonne contient bien 6 cases
    forall(member(Col, B), length(Col, 6)),

    % Nettoyage pour ne pas impacter les tests suivants
    retractall(board:board(_)).

% -------------------------------------------------------------------
% TEST 2 : vérifier que applyIt/2 met bien à jour l'état dynamique
% -------------------------------------------------------------------
test(applyIt_updates_board) :-
    % On crée un plateau initial vide (Board)
    length(A0,6), length(A1,6), length(A2,6),
    length(A3,6), length(A4,6), length(A5,6), length(A6,6),
    Board = [A0,A1,A2,A3,A4,A5,A6],

    % On initialise l'état dynamique avec ce plateau
    retractall(board:board(_)),
    assert(board:board(Board)),

    % On prépare un "NewBoard" qui représente l'état après un coup :
    % Ici, on dit que dans la colonne 2, à la ligne 1, il y a un pion x.
    % B2 = [_, x, _, _, _, _] -> l'index 1 vaut x
    %
    % (Les autres colonnes restent vides.)
    B0 = A0,
    B1 = A1,
    B2 = [_,x,_,_,_,_],
    length(B3,6), length(B4,6), length(B5,6), length(B6,6),

    NewBoard = [B0,B1,B2,B3,B4,B5,B6],

    % applyIt/2 doit remplacer le fait dynamique :
    % - retract(board(Board))
    % - assert(board(NewBoard))
    applyIt(Board, NewBoard),

    % On relit le plateau dynamique et on vérifie que la modification est bien là
    board:board(B),
    nth0(2, B, Col2),       % récupère la colonne 2
    nth0(1, Col2, Val),     % récupère la ligne 1 dans cette colonne
    assertion(Val == x),    % vérifie que c'est bien x

    % Nettoyage
    retractall(board:board(_)).

:- end_tests(board).
% Fin du groupe de tests "board"

