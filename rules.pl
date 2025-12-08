/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* Game rules */
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/

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
