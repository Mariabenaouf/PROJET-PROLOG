:- module(rules, [
    playMove/5,
    replaceElem/5,
    changePlayer/2,
    replace_nth0/5,
    askHumanMove/3,
    firstFreeIndexColonne/3
]).
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* Game rules */
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/


firstFreeIndexColonne(Board, ColIndex, Index):- 
    nth0(ColIndex, Board, Colonne), 
    between(0, 5, Index), 
    nth0(Index, Colonne, Elem), 
    var(Elem), !. % cherche le premier indice libre dans la colonne, s'arrête au premier trouvé
firstFreeIndexColonne(_, _, 6):- !. % si on n'a pas trouvé d'indice libre, on renvoie 7 (colonne pleine)

replace_nth0(List, Index, OldElem, NewElem, NewList) :-
   % predicate works forward: Index,List -> OldElem, Transfer
   nth0(Index,List,OldElem,Transfer),
   % predicate works backwards: Index,NewElem,Transfer -> NewList
   nth0(Index,NewList,NewElem,Transfer).

replaceElem(Board, ColIndex, ElemIndex, Player, NewBoard) :-
    % Récupérer la colonne
    nth0(ColIndex, Board, Colonne),

    % Modifier un élément dans la colonne
    replace_nth0(Colonne, ElemIndex, _, Player, NewColonne),

    % Remettre la colonne modifiée dans le board
    replace_nth0(Board, ColIndex, Colonne, NewColonne, NewBoard).


playMove(Board, RandCol, ElemIndex, NewBoard, Player):-replaceElem(Board, RandCol, ElemIndex, Player, NewBoard).

changePlayer(Player,NextPlayer):-(Player=='o',NextPlayer='x');(Player=='x',NextPlayer='o').


% askHumanMove(+Board, -Col, -ElemIndex)
% Demande une colonne à l'humain et vérifie qu'elle est valide.
askHumanMove(Board, Col, ElemIndex) :-
    repeat,
        write('Choisissez une colonne (0-6) : '),
        read(UserInput),

        integer(UserInput),
        UserInput >= 0, UserInput =< 6,

        firstFreeIndexColonne(Board, UserInput, ElemIndex),
        ElemIndex \== 6,  % 6 = colonne pleine

    !,
    Col = UserInput.
