:- module(test_winner, []).
% On déclare un module Prolog pour ce fichier de tests.
% Ici il n’exporte rien ([]), il sert juste à regrouper les tests.

:- use_module(library(plunit)).
% plunit = bibliothèque de tests de SWI-Prolog

% Import des modules du projet
:- use_module('../src/board').
% Ici ce import n’est pas strictement nécessaire pour tester winner/2,
% car on construit Board "à la main" dans les tests.
% Mais ça ne gêne pas et ça fait partie des modules du projet.

:- use_module('../src/winner').
% On charge le module winner qui contient :
% - winner/2 : détecte si un joueur a gagné sur un Board
% - isBoardFull/1 : détecte si le plateau est plein
% - gameover/1 : utilise board/1 dynamique (pas utilisé ici)

:- begin_tests(winner).
% Début du groupe de tests appelé "winner".
% Quand on fera run_tests, il lancera tous les tests de ce bloc.

% -------------------------------------------------------------------
% TEST 1 : victoire verticale
% -------------------------------------------------------------------
test(vertical_win_x) :-
    % Dans votre représentation : Board = liste de 7 colonnes,
    % chaque colonne est une liste de 6 cases.
    %
    % Ici, on construit une colonne 0 (Col0) avec 4 'x' empilés aux indices 0..3.
    % Les deux dernières cases restent libres (variables _).
    Col0 = ['x','x','x','x',_,_],

    % On crée les 6 autres colonnes vides (6 cases non instanciées).
    % length(C1,6) crée une liste de 6 variables : [_,_,_,_,_,_]
    length(C1,6), length(C2,6), length(C3,6),
    length(C4,6), length(C5,6), length(C6,6),

    % On assemble le plateau complet (7 colonnes).
    Board = [Col0,C1,C2,C3,C4,C5,C6],

    % assertion/1 vérifie que l’expression est vraie.
    % winner(Board,'x') doit réussir car il y a 4 x alignés verticalement.
    assertion(winner(Board,'x')).

% -------------------------------------------------------------------
% TEST 2 : victoire horizontale
% -------------------------------------------------------------------
test(horizontal_win_o) :-
    % Ici on veut 4 'o' alignés sur une même ligne.
    %
    % Attention : dans votre représentation, l’index dans une colonne correspond à une ligne.
    % Exemple : nth0(2, Col, Val) veut dire "à la ligne 2 de cette colonne".
    %
    % Donc en mettant o à l'index 2 dans plusieurs colonnes, on crée une ligne horizontale.
    % C0..C3 ont un 'o' à l'index 2.
    C0 = [_,_,o,_,_,_],
    C1 = [_,_,o,_,_,_],
    C2 = [_,_,o,_,_,_],
    C3 = [_,_,o,_,_,_],

    % Les colonnes restantes sont vides.
    length(C4,6), length(C5,6), length(C6,6),

    Board = [C0,C1,C2,C3,C4,C5,C6],

    % winner(Board,o) doit réussir : victoire horizontale de o.
    % (Ici tu utilises o sans guillemets : c’est aussi un atome Prolog valide.)
    assertion(winner(Board,o)).

% -------------------------------------------------------------------
% TEST 3 : victoire diagonale (bas -> haut, vers la droite)
% -------------------------------------------------------------------
test(diagonal_bh_win_x) :-
    % Diagonale de (col0,row0) à (col3,row3) :
    % (0,0) = x
    % (1,1) = x
    % (2,2) = x
    % (3,3) = x
    %
    % On place donc x à des indices différents dans chaque colonne.
    C0 = [x,_,_,_,_,_],
    C1 = [_,x,_,_,_,_],
    C2 = [_,_,x,_,_,_],
    C3 = [_,_,_,x,_,_],

    % Les colonnes restantes sont vides.
    length(C4,6), length(C5,6), length(C6,6),

    Board = [C0,C1,C2,C3,C4,C5,C6],

    % winner(Board,'x') doit réussir : victoire diagonale pour x.
    assertion(winner(Board,'x')).

% -------------------------------------------------------------------
% TEST 4 : plateau plein
% -------------------------------------------------------------------
test(is_board_full_true) :-
    % Ici on remplit toutes les cases (aucune variable).
    % Donc isBoardFull/1 doit réussir.
    Col1 = [x,x,x,x,x,x],
    Col2 = [o,o,o,o,o,o],
    Col3 = [x,x,x,x,x,x],
    Col4 = [o,o,o,o,o,o],
    Col5 = [x,x,x,x,x,x],
    Col6 = [o,o,o,o,o,o],
    Col7 = [x,x,x,x,x,x],

    Board = [Col1,Col2,Col3,Col4,Col5,Col6,Col7],

    assertion(isBoardFull(Board)).

% -------------------------------------------------------------------
% TEST 5 : plateau non plein
% -------------------------------------------------------------------
test(is_board_full_false) :-
    % Un plateau "vide" = 7 colonnes de 6 variables.
    % Donc isBoardFull/1 doit échouer.
    length(C0,6), length(C1,6), length(C2,6),
    length(C3,6), length(C4,6), length(C5,6), length(C6,6),
    Board = [C0,C1,C2,C3,C4,C5,C6],

    % \+ Goal = "not provable" : on vérifie que isBoardFull(Board) échoue.
    \+ isBoardFull(Board).

:- end_tests(winner).
% Fin du groupe de tests "winner".


