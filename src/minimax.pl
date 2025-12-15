:- module(minimax, [
    minimax/5,
	ia_player/1
]).
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* Move */
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
move(Board,ColIndex,Player,Board2):-
	firstFreeIndexColonne(Board, ColIndex, ElemIndex), ElemIndex\==6,
	replaceElem(Board, ColIndex, ElemIndex, Player, Board2).

/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* Utility */
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/

% It computes the value of a given board position
% 
utility(Board,Player,Utility) :-
	utilityGagnable(Board,Player,Utility1),
	utilityPerdable(Board,Player,Utility2),
	Utility is Utility1 + Utility2.

utilityGagnable(Board,Player,Utility) :-
	findall(Colone, gagnable(Board,Player,Colone), Colones),
	length(Colones, N),
	Utility is N * 10.

utilityPerdable(Board,Player,Utility) :-
	changePlayer(Player,Opponent),
	findall(Colone, gagnable(Board,Opponent,Colone), Colones),
	length(Colones, N),
	Utility is N * -10.

/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* Useful predicates */
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/


% Test si aucune case du board n'est instanciée
isBoardEmpty(Board) :-
    forall(member(Colonne, Board), 
    forall(member(Elem, Colonne), var(Elem))).


% Retourne une liste de toutes les colonnes non pleines
possible_moves(Board, List) :-
    findall(ColIndex,
        (between(0,6,ColIndex), firstFreeIndexColonne(Board, ColIndex, ElemIndex), ElemIndex\==6),
        List).

/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* Minimax */
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
% The minimax algorithm always assumes an optimal opponent.
% This is inpired by the classic minimax algorithm for tic-tac-toe.

% For the opening move against an optimal player the best move is to play in the center ColIndex.

minimax(_,Board,_,4,0) :-
    isBoardEmpty(Board), !.

minimax(Depth,Board,Player,_,Utility) :- %%% If the depth limit has been reached,
    Depth >= 4,
    utility(Board,Player,Utility), !.

minimax(Depth,Board,Player,ColIndex,Utility) :-
 Depth2 is Depth+1,
 possible_moves(Board,List), !,		%%% get the list of possible moves
	best(Depth2,Board,Player,List,ColIndex,Utility), !.	
					%%% recursively determine the best available move

% If there are no more available moves, then the minimax value is 
% the utility of the given board position 
 
minimax(_,Board,Player,_,Utility) :- utility(Board,Player,Utility). %%% no more moves available

/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* best */
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
% determines the best move in a given list of moves by 
% recursively calling minimax


best(Depth,Board,Player,[ColIndex1],ColIndex1,Utility) 
	:-	move(Board,ColIndex1,Player,Board2),	%%% apply that move to the board,
			changePlayer(Player,Player2), !,
			%%% then recursively search for the utility of that move.
				minimax(Depth,Board2,Player2,_,Utility), !.	 

% if there is more than one move in the list... 

best(Depth,Board,Player,[ColIndex1|Other_Moves],ColIndex,Utility) 
	:-	move(Board,ColIndex1,Player,Board2),	%%% apply the first move (in the list)
			changePlayer(Player,Player2), !,
				minimax(Depth,Board2,Player2,_,Utility1),	
			%%% recursively search for the utility value of that move
			%%% and determine the best move of the remaining moves
				best(Depth,Board,Player,Other_Moves,ColIndex2,Utility2),	
			better(Depth,Player,ColIndex1,Utility1,ColIndex2,Utility2,ColIndex,Utility). 	
	%%% choose the better of the two moves based on their utility values

%.......................................
% better
%.......................................
% returns the better of two moves based on their utility values.
%
% if both moves have the same utility value, then one is chosen at random. 
%
better(_,Player,ColIndex1,Utility1,_ColIndex2,Utility2,ColIndex1,Utility1) 
	:-	maximizing(Player),				%%% if the player is maximizing
		Utility1 > Utility2, !.		%%% then greater is better.

better(_,Player,ColIndex1,Utility1,_ColIndex2,Utility2,ColIndex1,Utility1) 
	:-	minimizing(Player),				%%% if the player is minimizing,
		Utility1 < Utility2, !.		%%% then lesser is better.
	
better(_,Player,ColIndex1,Utility1,ColIndex2,Utility2,ColIndex,Utility) 
	:-	Utility1 == Utility2,		%%% if moves have equal utility,
		random_between(1,10,R),		%%% then pick one of them at random
		better2(_,R,Player,ColIndex1,Utility1,ColIndex2,Utility2,ColIndex,Utility), !.

better(_,_Player,_ColIndex1,_Utility1,ColIndex2,Utility2,ColIndex2,Utility2). 
									%%% otherwise, second move is better
	
%.......................................
% better2
%.......................................
% randomly selects among two ColIndexs of the same utility value
%
better2(_,R,_Player,ColIndex1,Utility1,_ColIndex2,_Utility2,ColIndex1,Utility1) :- R < 6, !.
better2(_,_R,_Player,_ColIndex1,_Utility1,ColIndex2,Utility2,ColIndex2,Utility2).




%.......................................
% maximizing / minimizing
%.......................................
maximizing(Player) :-
    ia_player(Player).

minimizing(Player) :-
    ia_player(IA),
    Player \= IA.


ia_player(x).