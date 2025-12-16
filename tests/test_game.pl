:- module(test_game, []).
% Module de tests pour la partie "game" (boucle de jeu).
% On ne teste pas une partie complète (trop d'I/O + IA + hasard),
% mais on teste des invariants essentiels.

:- use_module(library(plunit)).
% Bibliothèque de tests unitaires

% Import des modules du projet
:- use_module('../src/board').
% Contient le fait dynamique board/1 et applyIt/2 (mise à jour du plateau)

:- use_module('../src/game').
% Contient play/1 et play2/3 (boucle principale du jeu)

:- use_module('../src/rules').
% Contient playMove/5 (poser un pion) et changePlayer/2

:- use_module('../src/winner').
% Contient winner/2 + gameover/1 (détecte fin de partie)

:- begin_tests(game).
% Début du groupe de tests "game"

% -------------------------------------------------------------------
% TEST 1 : play/1 doit s'arrêter si la partie est déjà finie
% -------------------------------------------------------------------
test(play_stops_on_gameover) :-
    % On construit un plateau où X a déjà gagné :
    % 4 pions x empilés dans la colonne 0 (indices 0..3)
    Col0 = [x,x,x,x,_,_],

    % Les 6 autres colonnes sont vides
    length(C1,6), length(C2,6), length(C3,6),
    length(C4,6), length(C5,6), length(C6,6),

    % Board = liste de 7 colonnes
    Board = [Col0,C1,C2,C3,C4,C5,C6],

    % IMPORTANT :
    % board/1 est un prédicat dynamique dans le MODULE board.
    % Donc ici on manipule explicitement board:board/1, sinon le jeu ne "verrait" pas notre plateau.
    retractall(board:board(_)),
    assert(board:board(Board)),

    % "Sanity check" (= vérification de cohérence) :
    % avant de tester play/1, on confirme que le plateau est bien terminal (gameover vrai)
    assertion(winner:gameover(_)),

    % On lance play(x) :
    % - play/1 commence par vérifier gameover/1
    % - si gameover est vrai, il doit s’arrêter immédiatement
    % once/1 garantit qu'on ne laisse pas de choix ouverts (test déterministe)
    once(game:play(x)),

    % On re-lit l'état dynamique et on vérifie que la victoire existe toujours :
    % (On ne compare pas l'égalité stricte du plateau, car l'affichage peut toucher aux variables internes.)
    board:board(B2),
    assertion(winner:winner(B2, x)),

    % Nettoyage : on enlève le plateau du module board pour ne pas polluer les autres tests
    retractall(board:board(_)).

% -------------------------------------------------------------------
% TEST 2 : séquence minimale d'un tour (playMove -> applyIt)
% -------------------------------------------------------------------
test(turn_sequence_applyIt) :-
    % On crée un plateau vide (7 colonnes de 6 cases)
    length(C0,6), length(C1,6), length(C2,6),
    length(C3,6), length(C4,6), length(C5,6), length(C6,6),
    Board = [C0,C1,C2,C3,C4,C5,C6],

    % On initialise l'état dynamique à ce plateau vide
    retractall(board:board(_)),
    assert(board:board(Board)),

    % On simule un coup "manuel" :
    % jouer x dans la colonne 4, ligne 2.
    % playMove/5 ne modifie pas la base dynamique : il retourne juste NewBoard.
    rules:playMove(Board, 4, 2, NewBoard, x),

    % applyIt/2 met à jour le fait dynamique board/1 en base (board(Board) -> board(NewBoard))
    board:applyIt(Board, NewBoard),

    % On vérifie dans l'état dynamique que la case (col 4, row 2) est bien devenue x.
    board:board(B3),
    nth0(4, B3, Col4),
    nth0(2, Col4, Val),
    assertion(Val == x),

    % Nettoyage
    retractall(board:board(_)).

:- end_tests(game).
% Fin du groupe de tests "game"
