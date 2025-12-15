:- consult('../src/rules.pl').

:- begin_tests(rules).

/*vérifie le replace_nth0 qui remplace un element à un indexe*/
% Test replace_nth0: replace element at index 1 in a small list
test(replace_nth0_replace_element) :-
    List = [a,b,c,d],
    replace_nth0(List,1,b,x,NewList),
    assertion(NewList == [a,x,c,d]).

/*vérifie le replaceElem qui remplace une cellule dans une colonne*/
% Test replaceElem: place 'x' in column 0, row 0
test(replaceElem_place_token) :-
    length(C0,6), length(C1,6), length(C2,6), length(C3,6), length(C4,6), length(C5,6), length(C6,6),
    Board = [C0,C1,C2,C3,C4,C5,C6],
    replaceElem(Board, 0, 0, x, NewBoard),
    nth0(0, NewBoard, NewC0),
    nth0(0, NewC0, Val),
    assertion(Val == x).

/*Vérifie PlayMove*/
% Test playMove wrapper: same effect as replaceElem
test(playMove_wrapper) :-
    length(C0,6), length(C1,6), length(C2,6), length(C3,6), length(C4,6), length(C5,6), length(C6,6),
    Board = [C0,C1,C2,C3,C4,C5,C6],
    playMove(Board, 2, 3, NewBoard, o),
    nth0(2, NewBoard, NewC2),
    nth0(3, NewC2, Val),
    assertion(Val == o).


/*Vérifie changePlayer*/
% Test changePlayer toggles between 'x' and 'o'
test(changePlayer_toggle) :-
    changePlayer(x, Xnext), assertion(Xnext == o),
    changePlayer(o, Onext), assertion(Onext == x).

:- end_tests(rules).
