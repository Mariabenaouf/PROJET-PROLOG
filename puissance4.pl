:- dynamic board/1. % permet l'assertion et le retrait de faits board/1

/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* Display the board */
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/

% Print the value of the board at index N (?, x or o) 
printVal(C, N) :- 
    board(B), nth0(C,B,Colonne), nth0(N,Colonne,Val),   % récupère l'élément à l'indice C,N
    var(Val), write('?'), write(' '), !.                % si c'est pas instancié, affiche '?' et ne fais pas la clause suivante

printVal(C, N) :- board(B), nth0(C,B,Colonne), nth0(N,Colonne,Val), write(Val), write(' '). %  récupère l'élément à l'indice C,N et l'affiche
   
printLigne(N) :- printVal(0,N), printVal(1,N), printVal(2,N), printVal(3,N), printVal(4,N), printVal(5,N), printVal(6,N), writeln('').

% Display the board
displayBoard :- 
    writeln('*---------------------*'),
	printLigne(5), printLigne(4), printLigne(3), printLigne(2), printLigne(1), printLigne(0), % affiche dans le sens inverse
    writeln('*---------------------*').

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
applyIt(Board,NewBoard):-retract(board(Board)), assert(board(NewBoard)).

changePlayer(Player,NextPlayer):-(Player=='o',NextPlayer='x');(Player=='x',NextPlayer='o').

% Basic IA that plays randomly in a non-full column
ia(Board, RandCol, ElemIndex, _):-
    repeat, random(0,7,RandCol), firstFreeIndexColonne(Board, RandCol, ElemIndex), ElemIndex\==6, !.

/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* Check for game over */
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/

gameover(Winner) :- board(Board), winner(Board,Winner), !. 
gameover('Draw') :- board(Board), isBoardFull(Board).

% Test if a Board is a winning configuration for player P.
winnerColonne(Colonne, P) :- Colonne = [P,Q,R,S,_,_], P==Q, Q==R, R==S, nonvar(P).
winnerColonne(Colonne, P) :- Colonne = [_,P,Q,R,S,_], P==Q, Q==R, R==S, nonvar(P).
winnerColonne(Colonne, P) :- Colonne = [_,_,P,Q,R,S], P==Q, Q==R, R==S, nonvar(P).
winnerLigne(Ligne, Board, P) :- 
    nth0(0,Board,C0), nth0(Ligne,C0,P), nonvar(P),
    nth0(1,Board,C1), nth0(Ligne,C1,V1), P==V1,
    nth0(2,Board,C2), nth0(Ligne,C2,V2), P==V2,
    nth0(3,Board,C3), nth0(Ligne,C3,V3), P==V3.
winnerLigne(Ligne, Board, P) :- 
    nth0(1,Board,C1), nth0(Ligne,C1,P), nonvar(P),
    nth0(2,Board,C2), nth0(Ligne,C2,V2), P==V2,
    nth0(3,Board,C3), nth0(Ligne,C3,V3), P==V3,
    nth0(4,Board,C4), nth0(Ligne,C4,V4), P==V4.
winnerLigne(Ligne, Board, P) :- 
    nth0(2,Board,C2), nth0(Ligne,C2,P), nonvar(P),
    nth0(3,Board,C3), nth0(Ligne,C3,V3), P==V3,
    nth0(4,Board,C4), nth0(Ligne,C4,V4), P==V4,
    nth0(5,Board,C5), nth0(Ligne,C5,V5), P==V5.
winnerLigne(Ligne, Board, P) :- 
    nth0(3,Board,C3), nth0(Ligne,C3,P), nonvar(P),
    nth0(4,Board,C4), nth0(Ligne,C4,V4), P==V4,
    nth0(5,Board,C5), nth0(Ligne,C5,V5), P==V5,
    nth0(6,Board,C6), nth0(Ligne,C6,V6), P==V6.
winnerDiagonaleGD(L, C, Board, P) :-
    nth0(C,Board,C0), nth0(L,C0,P), nonvar(P),
    C1Index is C+1, nth0(C1Index,Board,C1), L1Index is L-1, nth0(L1Index,C1,V1), P==V1,
    C2Index is C+2, nth0(C2Index,Board,C2), L2Index is L-2, nth0(L2Index,C2,V2), P==V2,
    C3Index is C+3, nth0(C3Index,Board,C3), L3Index is L-3, nth0(L3Index,C3,V3), P==V3.
winnerDiagonaleDG(L, C, Board, P) :-
    nth0(C,Board,C0), nth0(L,C0,P), nonvar(P),
    C1Index is C-1, nth0(C1Index,Board,C1), L1Index is L+1, nth0(L1Index,C1,V1), P==V1,
    C2Index is C-2, nth0(C2Index,Board,C2), L2Index is L+2, nth0(L2Index,C2,V2), P==V2,
    C3Index is C-3, nth0(C3Index,Board,C3), L3Index is L+3, nth0(L3Index,C3,V3), P==V3.

winner(Board, P) :-
    member(Colonne, Board), % pour chaque membre Ligne de Board
    winnerColonne(Colonne, P).
winner(Board, P) :-
    between(0, 5, Ligne),
    winnerLigne(Ligne, Board, P).
winner(Board, P) :-
    between(3, 5, Ligne),
    between(0, 3, Colonne),
    winnerDiagonaleGD(Ligne, Colonne, Board, P).
winner(Board, P) :-
    between(0, 2, Ligne),
    between(3, 6, Colonne),
    winnerDiagonaleDG(Ligne, Colonne, Board, P).

% Check if all the elements of the List (the board) are instanciated
isBoardFull([]).
isBoardFull([Col|Rest]) :-
    maplist(nonvar, Col),
    isBoardFull(Rest).



/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* Main game loop */
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
play(_) :- gameover(Winner), !, write('Game is Over. Winner: '), writeln(Winner), displayBoard.
play(Player):-write('New turn for:'), writeln(Player),
   		board(Board), % instanciate the board from the knowledge base
      	displayBoard, % print it
        ia(Board, RandCol, ElemIndex, Player), % ask the AI for a move, that is, an index for the Player
   	    playMove(Board, RandCol, ElemIndex, NewBoard, Player), % Play the move and get the result in a new Board
		applyIt(Board, NewBoard), % Remove the old board from the KB and store the new one
   	    changePlayer(Player,NextPlayer), % Change the player before next turn
        play(NextPlayer). % next turn!

%%%%% Start the game!
init :-
    length(Col1,6),
    length(Col2,6),
    length(Col3,6),
    length(Col4,6),
    length(Col5,6),
    length(Col6,6),
    length(Col7,6),
    Board = [Col1,Col2,Col3,Col4,Col5,Col6,Col7],
    assert(board(Board)),
    play('x').

/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* Tests */
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/


test:-test1.

test1:- length(Board,7), assert(board(Board)),displayBoard.

test2:- length(Board,9), assert(board(Board)),displayBoard,
   ia(Board,Move,'x'), writeln(Move),
   playMove(Board,Move,NewBoard,'x'), writeln(NewBoard).

test3:-Board=['x','o','x','o','x','o','x','o','o'],gameover(Board,Winner),writeln(Winner).