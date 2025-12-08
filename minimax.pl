module(minimax, [minimax/5]).   
:- use_module(puissance4).

/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* Utility */
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/

% It computes the value of a given board position
% 
utility(Board,1) :- winner(Board,'x'), !.
utility(Board,-1) :- winner(Board,'o'), !.
utility(_,0).

/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* Useful predicates */
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
% Basic IA that plays randomly in a non-full column
ia(Board, RandCol, ElemIndex, _):-
    repeat, random(0,7,RandCol), firstFreeIndexColonne(Board, RandCol, ElemIndex), ElemIndex\==6, !.

% Test si aucune case du board n'est instanciée
isBoardEmpty(Board) :-
    forall(member(Colonne, Board), 
    forall(member(Elem, Colonne), var(Elem))).

% Retourne l'indice de la première case libre dans une colonne
firstFreeIndexColonne(Board, ColIndex, Index):- 
    nth0(ColIndex, Board, Colonne), 
    between(0, 5, Index), 
    nth0(Index, Colonne, Elem), 
    var(Elem), !. % cherche le premier indice libre dans la colonne, s'arrête au premier trouvé
firstFreeIndexColonne(_, _, 6):- !. % si on n'a pas trouvé d'indice libre, on renvoie 7 (colonne pleine)

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

% For the opening move against an optimal player the best move is to play in the center square.

minimax(Depth,Board,Player,4,0,Utility) :-
    isBoardEmpty(Board), !.

minimax(Depth,Board,Player,ColIndex,Utility) :-
 Depth2 is Depth+1,
 possible_moves(Board,List), !,		%%% get the list of possible moves
	best(Depth2,Board,Player,List,ColIndex,Utility), !.	
					%%% recursively determine the best available move

% If there are no more available moves, then the minimax value is 
% the utility of the given board position 
 
minimax(Depth,Board,Player,ColIndex,Utility) :- utility(Board,Utility).

/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* best */
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
% determines the best move in a given list of moves by 
% recursively calling minimax


best(Depth,Board,Player,[ColIndex],ColIndex,Utility) 
	:-	move(Board,ColIndex,Player,Board2),	%%% apply that move to the board,
			inverse_mark(Player,Player2), !,
			%%% then recursively search for the utility of that move.
				minimax(Depth,Board2,Player2,_,Utility), !,	 
				output_value(Depth,ColIndex,Utility), !.

% if there is more than one move in the list... 

best(Depth,Board,Player,[ColIndex|Other_Moves],ColIndex,Utility) 
	:-	move(Board,ColIndex,Player,Board2),	%%% apply the first move (in the list)
			inverse_mark(Player,Player2), !,
				minimax(Depth,Board2,Player2,_,Utility1),	
			%%% recursively search for the utility value of that move
			%%% and determine the best move of the remaining moves
				best(Depth,Board,Player,Other_Moves,Square2,Utility2),	
				output_value(Depth,Square1,Utility1),
			better(Depth,Player,Square1,Utility1,Square2,Utility2,Square,Utility). 	
	%%% choose the better of the two moves based on their utility values

%.......................................
% better
%.......................................
% returns the better of two moves based on their utility values.
%
% if both moves have the same utility value, then one is chosen at random. 
%
better(_,Mark,ColIndex1,Utility1,ColIndex2,Utility2,ColIndex1,Utility1) 
	:-	maximizing(M),				%%% if the player is maximizing
		Utility1 > Utility2, !.		%%% then greater is better.

better(_,Mark,ColIndex1,Utility1,ColIndex2,Utility2,ColIndex1,Utility1) 
	:-	minimizing(M),				%%% if the player is minimizing,
		Utility1 < Utility2, !.		%%% then lesser is better.
	
better(_,Mark,ColIndex1,Utility1,ColIndex2,Utility2,ColIndex,Utility) 
	:-	Utility1 == Utility2,		%%% if moves have equal utility,
		random_between(1,10,R),		%%% then pick one of them at random
		better2(_,R,Mark,ColIndex1,Utility1,ColIndex2,Utility2,ColIndex,Utility), !.

better(_,Mark,ColIndex1,Utility1,ColIndex2,Utility2,ColIndex2,Utility2). 
									%%% otherwise, second move is better
	
%.......................................
% better2
%.......................................
% randomly selects among two squares of the same utility value
%
better2(_,R,Mark,Square1,Utility1,Square2,Utility2,Square1,Utility1) :- R < 6, !.
better2(_,R,Mark,Square1,Utility1,Square2,Utility2,Square2,Utility2).