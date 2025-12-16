:- module(test_ai, []).
% Module de tests pour ai.pl.
% On valide ici les briques de base utilisées par les IA :
% - trouver où tombe un pion dans une colonne (gravité)
% - détecter un coup gagnant (gagnable/3)
% - vérifier que l'IA aléatoire joue toujours dans une colonne non pleine

:- use_module(library(plunit)).
% Framework de tests unitaires plunit

% Import des modules du projet
:- use_module('../src/ai').
% On teste des prédicats du module ai :
% - firstFreeIndexColonne/3
% - gagnable/3
% - ia1/4


:- begin_tests(ai).
% Début du groupe de tests "ai"



% -------------------------------------------------------------------
% TEST 2 : gagnable/3
% -------------------------------------------------------------------
test(gagnable_detects_win) :-
    % Ici, on construit un plateau où le joueur x
    % peut gagner au prochain coup dans la colonne 0 :
    % Col0 = [x, x, x, _, _, _]
    %
    % Le prochain pion dans cette colonne tomberait à l'index 3,
    % ce qui ferait 4 x d'affilée verticalement => victoire.
    Col0 = [x,x,x,_,_,_],

    length(C1,6), length(C2,6), length(C3,6),
    length(C4,6), length(C5,6), length(C6,6),

    Board = [Col0,C1,C2,C3,C4,C5,C6],

    % gagnable(Board, Player, ColonneAJouer)
    % signifie : "Player a un coup gagnant immédiat en jouant dans ColonneAJouer"
    %
    % once/1 est important car il peut y avoir plusieurs coups gagnants :
    % on veut juste en récupérer un, pour rendre le test déterministe.
    once(gagnable(Board, 'x', Col)),

    % Ici le seul coup gagnant évident est la colonne 0
    assertion(Col == 0).

% -------------------------------------------------------------------
% TEST 3 : ia1/4 (IA aléatoire)
% -------------------------------------------------------------------
test(ia1_returns_nonfull_column) :-
    % On crée un plateau vide.
    % L’IA choisit une colonne aléatoire NON pleine et renvoie aussi ElemIndex.
    length(C0,6), length(C1,6), length(C2,6),
    length(C3,6), length(C4,6), length(C5,6), length(C6,6),
    Board = [C0,C1,C2,C3,C4,C5,C6],

    % ia1(Board, RandCol, ElemIndex, _)
    % Comme c'est aléatoire, on ne teste pas la colonne exacte.
    % On teste un invariant : ElemIndex ne doit pas être 6.
    % (Dans votre convention : 6 = colonne pleine / pas jouable)
    ia1(Board, _, Index, _),

    assertion(Index \== 6).
    % Donc on garantit que l'IA joue toujours un coup légal.

:- end_tests(ai).
% Fin du groupe de tests "ai"
