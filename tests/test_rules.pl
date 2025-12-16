:- module(test_rules, []).
% On définit un module de tests appelé test_rules.
% Il ne fournit rien à l’extérieur, il sert uniquement à contenir les tests.

:- use_module(library(plunit)).
% plunit = framework de tests unitaires en Prolog.

:- use_module('../src/rules').
% On importe le module rules, qui contient :
% - replace_nth0/5
% - replaceElem/5
% - playMove/5
% - changePlayer/2

:- begin_tests(rules).
% Début du groupe de tests nommé "rules".

% -------------------------------------------------------------------
% TEST 1 : firstFreeIndexColonne/3
% -------------------------------------------------------------------
test(first_free_index) :-
    % On construit un plateau :
    % Dans la colonne 0 : [x, o, _, _, _, _]
    % Donc les index 0 et 1 sont occupés,
    % et la première case libre est à l'index 2.
    C0 = [x,o,_,_,_,_],

    % Les autres colonnes sont vides (6 cases libres)
    length(C1,6), length(C2,6), length(C3,6),
    length(C4,6), length(C5,6), length(C6,6),

    Board = [C0,C1,C2,C3,C4,C5,C6],

    % On demande la première case libre dans la colonne 0
    firstFreeIndexColonne(Board, 0, Index),

    % On vérifie que l'index retourné est bien 2
    assertion(Index == 2).

% -------------------------------------------------------------------
% TEST 1 : replace_nth0/5
% -------------------------------------------------------------------
% Objectif :
% Vérifier que replace_nth0 remplace bien un élément
% à un index donné dans une liste.

test(replace_nth0_replace_element) :-
    % Liste de départ
    List = [a,b,c,d],

    % replace_nth0(List, Index, OldElem, NewElem, NewList)
    % Ici :
    % - on remplace b par x à l’index 1
    replace_nth0(List, 1, b, x, NewList),

    % On vérifie que la nouvelle liste est correcte
    assertion(NewList == [a,x,c,d]).

% -------------------------------------------------------------------
% TEST 2 : replaceElem/5
% -------------------------------------------------------------------
% Objectif :
% Vérifier que replaceElem place bien un pion
% à une position (colonne, ligne) dans le plateau.

test(replaceElem_place_token) :-
    % On crée un plateau vide :
    % 7 colonnes, chaque colonne est une liste de 6 cases vides (_)
    length(C0,6), length(C1,6), length(C2,6),
    length(C3,6), length(C4,6), length(C5,6), length(C6,6),
    Board = [C0,C1,C2,C3,C4,C5,C6],

    % On place le pion 'x' dans la colonne 0, ligne 0
    replaceElem(Board, 0, 0, x, NewBoard),

    % On récupère la colonne 0 du nouveau plateau
    nth0(0, NewBoard, NewC0),

    % On récupère la case à l’index 0 de cette colonne
    nth0(0, NewC0, Val),

    % On vérifie que la valeur est bien 'x'
    assertion(Val == x).

% -------------------------------------------------------------------
% TEST 3 : playMove/5
% -------------------------------------------------------------------
% Objectif :
% Vérifier que playMove est bien un "wrapper" de replaceElem.
% Autrement dit : playMove doit produire exactement le même effet.

test(playMove_wrapper) :-
    % Création d’un plateau vide
    length(C0,6), length(C1,6), length(C2,6),
    length(C3,6), length(C4,6), length(C5,6), length(C6,6),
    Board = [C0,C1,C2,C3,C4,C5,C6],

    % On joue un coup :
    % colonne 2, ligne 3, joueur 'o'
    playMove(Board, 2, 3, NewBoard, o),

    % On vérifie que la colonne 2 a bien été modifiée
    nth0(2, NewBoard, NewC2),
    nth0(3, NewC2, Val),

    % La valeur doit être 'o'
    assertion(Val == o).

% -------------------------------------------------------------------
% TEST 4 : changePlayer/2
% -------------------------------------------------------------------
% Objectif :
% Vérifier que changePlayer alterne correctement :
% x -> o et o -> x

test(changePlayer_toggle) :-
    % once/1 est utilisé pour éviter les choicepoints
    % (changePlayer est défini avec un OR ;)
    once(changePlayer(x, Xnext)),
    assertion(Xnext == o),

    once(changePlayer(o, Onext)),
    assertion(Onext == x).

:- end_tests(rules).
% Fin du groupe de tests "rules".
