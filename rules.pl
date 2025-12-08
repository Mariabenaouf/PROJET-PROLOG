firstFreeIndexColonne(Board, ColIndex, Index):- 
    nth0(ColIndex, Board, Colonne), 
    between(0, 5, Index), 
    nth0(Index, Colonne, Elem), 
    var(Elem), !.
firstFreeIndexColonne(_, _, 6):- !.

replace_nth0(List, Index, OldElem, NewElem, NewList) :-
    nth0(Index,List,OldElem,Transfer),
    nth0(Index,NewList,NewElem,Transfer).

replaceElem(Board, ColIndex, ElemIndex, Player, NewBoard) :-
    nth0(ColIndex, Board, Colonne),
    replace_nth0(Colonne, ElemIndex, _, Player, NewColonne),
    replace_nth0(Board, ColIndex, Colonne, NewColonne, NewBoard).

playMove(Board, RandCol, ElemIndex, NewBoard, Player) :-
    replaceElem(Board, RandCol, ElemIndex, Player, NewBoard).

changePlayer(Player,NextPlayer):-
    (Player=='o',NextPlayer='x');(Player=='x',NextPlayer='o').

ia(Board, RandCol, ElemIndex, _):-
    repeat,
    random(0,7,RandCol),
    firstFreeIndexColonne(Board, RandCol, ElemIndex),
    ElemIndex\==6,
    !.
