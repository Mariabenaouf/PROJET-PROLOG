:- module(test_minimax, []).
% Module de tests pour la partie "minimax".
% Il sert à vérifier la fonction d’évaluation et la génération de coups possibles.

:- use_module(library(plunit)).
% Framework de tests unitaires

:- use_module('../src/winner').
% winner/2 est utilisé indirectement par utility/3
% (utility regarde si quelqu’un a déjà gagné)

:- use_module('../src/minimax').
% Module principal testé ici :
% - utility/3
% - isBoardEmpty/1
% - possible_moves/2
% - minimax/5 (pas testé directement ici)

:- use_module('../src/ai').
% Contient firstFreeIndexColonne/3, utilisé par minimax

:- begin_tests(minimax).
% Début du groupe de tests "minimax"

% -------------------------------------------------------------------
% TEST 1 : utility/3 donne une valeur très positive si x a gagné
% -------------------------------------------------------------------
test(utility_positive_for_x_win) :-
    % On crée un plateau gagnant pour x :
    % 4 x alignés verticalement dans la colonne 0
    Col0 = [x,x,x,x,_,_],
    length(C1,6), length(C2,6), length(C3,6),
    length(C4,6), length(C5,6), length(C6,6),
    Board = [Col0,C1,C2,C3,C4,C5,C6],

    % utility/3 peut être non déterministe, donc on utilise once/1
    once(minimax:utility(Board, x, U)),

    % Si x a gagné, l’utilité doit être très élevée (>= 10000)
    assertion(U >= 10000).

% -------------------------------------------------------------------
% TEST 2 : utility/3 vue du point de vue de o
% -------------------------------------------------------------------
test(utility_positive_for_o_win_when_evaluating_o) :-
    % On construit un plateau où o gagne horizontalement
    % (ligne 1, colonnes 1 à 4)
    C0 = [_,_,_,_,_,_],
    C1 = [_,o,_,_,_,_],
    C2 = [_,o,_,_,_,_],
    C3 = [_,o,_,_,_,_],
    C4 = [_,o,_,_,_,_],
    length(C5,6), length(C6,6),
    Board = [C0,C1,C2,C3,C4,C5,C6],

    % On évalue le plateau du point de vue de o
    once(minimax:utility(Board, o, U)),

    % Si o a gagné, l’utilité doit aussi être très élevée
    assertion(U >= 10000).

% -------------------------------------------------------------------
% TEST 3 : plateau vide → utility = 0
% -------------------------------------------------------------------
test(utility_returns_0_for_empty_board_and_isEmpty_true) :-
    % Création d’un plateau entièrement vide
    length(C0,6), length(C1,6), length(C2,6),
    length(C3,6), length(C4,6), length(C5,6), length(C6,6),
    Board = [C0,C1,C2,C3,C4,C5,C6],

    % Vérification que le plateau est bien reconnu comme vide
    minimax:isBoardEmpty(Board),

    % Sur un plateau vide, l’utilité doit être neutre (0)
    minimax:utility(Board, x, U),
    assertion(U == 0).

% -------------------------------------------------------------------
% TEST 4 : firstFreeIndexColonne/3 retourne le bon index libre
% -------------------------------------------------------------------
test(firstFreeIndexColonne_returns_index) :-
    % Dans la colonne 0 :
    % index 0 = x
    % index 1 = o
    % index 2 = libre
    C0 = [x,o,_,_,_,_],
    length(C1,6), length(C2,6), length(C3,6),
    length(C4,6), length(C5,6), length(C6,6),
    Board = [C0,C1,C2,C3,C4,C5,C6],

    % Le premier index libre doit être 2
    firstFreeIndexColonne(Board, 0, Index),
    assertion(Index == 2).

% -------------------------------------------------------------------
% TEST 5 : colonne pleine → index = 6
% -------------------------------------------------------------------
test(firstFreeIndexColonne_returns_6_for_full_column) :-
    % Colonne complètement remplie
    Cfull = [x,o,x,o,x,o],
    length(C1,6), length(C2,6), length(C3,6),
    length(C4,6), length(C5,6), length(C6,6),
    Board = [Cfull,C1,C2,C3,C4,C5,C6],

    % firstFreeIndexColonne doit renvoyer 6
    % (valeur conventionnelle pour "colonne pleine")
    firstFreeIndexColonne(Board, 0, Index),
    assertion(Index == 6).

% -------------------------------------------------------------------
% TEST 6 : possible_moves/2 exclut les colonnes pleines
% -------------------------------------------------------------------
test(possible_moves_excludes_full_columns) :-
    % Colonnes 0 et 3 sont pleines
    Cfull = [x,o,x,o,x,o],

    % Colonnes libres
    Cfree = [_,_,_,_,_,_],

    Board = [Cfull,Cfree,Cfree,Cfull,Cfree,Cfree,Cfree],

    % possible_moves/2 renvoie la liste des colonnes jouables
    once(minimax:possible_moves(Board, List)),

    % Les colonnes pleines ne doivent pas apparaître
    \+ memberchk(0, List),
    \+ memberchk(3, List),

    % Certaines colonnes libres doivent apparaître
    memberchk(1, List),
    memberchk(2, List),

    assertion(is_list(List)).

:- end_tests(minimax).
% Fin du groupe de tests "minimax".

