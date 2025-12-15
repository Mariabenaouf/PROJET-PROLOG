:- module(minimax, [
    minimax/5,
	ia_player/1
]).
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* Move */
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
move(Board,ColIndex,Player,Board2):-
	firstFreeIndexColonne(Board, ColIndex, ElemIndex), ElemIndex\==6,
	copy_term(Board, BoardCopy),
	replaceElem(BoardCopy, ColIndex, ElemIndex, Player, Board2).

/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* Utility */
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/

% Évalue le plateau du point de vue du joueur Player
utility(Board,Player,Utility) :-
	utilityWin(Board,Player,Utility3),
	utilityLoose(Board,Player,Utility4),
	utilityGagnable(Board,Player,Utility1),
	utilityPerdable(Board,Player,Utility2),
	Utility is Utility3 + Utility4 + Utility1 + Utility2.

utilityWin(Board,Player,Utility) :-
	(winner(Board,Player) ->
		Utility = 10000
	;
		Utility = 0
	).

utilityLoose(Board,Player,Utility) :-
	changePlayer(Player,Opponent),
	(winner(Board,Opponent) ->
		Utility = -12000
	;
		Utility = 0
	).

utilityGagnable(Board,Player,Utility) :-
	findall(Colone, gagnable(Board,Player,Colone), Colones),
	length(Colones, N),
	Utility is N * 100.

utilityPerdable(Board,Player,Utility) :-
	changePlayer(Player,Opponent),
	findall(Colone, gagnable(Board,Opponent,Colone), Colones),
	length(Colones, N),
	Utility is N * -11000.

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

% Coup d'ouverture optimal
minimax(_,Board,_,4,0) :-
    isBoardEmpty(Board), !.

% Si quelqu'un a gagné ou profondeur max atteinte
minimax(Depth,Board,Player,_,Utility) :- 
    (Depth >= 4 ; winner(Board, _)),
    utility(Board,Player,Utility), !.

% Cas récursif
minimax(Depth,Board,Player,ColIndex,Utility) :-
    Depth2 is Depth+1,     	 							% On augmente la profondeur
    possible_moves(Board,List), !,
    best(Depth2,Board,Player,List,ColIndex,Utility), !. % on parcours les coups possibles avec best

% Plus de coups possibles
minimax(_,Board,Player,_,Utility) :- 
    utility(Board,Player,Utility).

/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* best */
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/

% Un seul coup disponible
best(Depth,Board,Player,[ColIndex1],ColIndex1,Utility) :-
	move(Board,ColIndex1,Player,Board2),
	changePlayer(Player,Player2), !,
	minimax(Depth,Board2,Player2,_,Utility2),
	% On inverse l'utility car on change de joueur
	Utility is -Utility2, !.

% Plusieurs coups disponibles
best(Depth,Board,Player,[ColIndex1|Other_Moves],ColIndex,Utility) :-
	move(Board,ColIndex1,Player,Board2),
	changePlayer(Player,Player2), !,
	minimax(Depth,Board2,Player2,_,Utility2),
	% On inverse l'utility car on change de joueur
	Utility1 is -Utility2,
	best(Depth,Board,Player,Other_Moves,ColIndex2,Utility2b),
	better(Depth,Player,ColIndex1,Utility1,ColIndex2,Utility2b,ColIndex,Utility).

/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* better */
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/

% Retourne le meilleur des deux coups - on maximise toujours
better(_,_Player,ColIndex1,Utility1,_ColIndex2,Utility2,ColIndex1,Utility1) :-
	Utility1 > Utility2, !.

better(_,Player,ColIndex1,Utility1,ColIndex2,Utility2,ColIndex,Utility) :-
	Utility1 == Utility2,
	random_between(1,10,R),
	better2(_,R,Player,ColIndex1,Utility1,ColIndex2,Utility2,ColIndex,Utility), !.

better(_,_Player,_ColIndex1,_Utility1,ColIndex2,Utility2,ColIndex2,Utility2).

/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* better2 */
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/

better2(_,R,_Player,ColIndex1,Utility1,_ColIndex2,_Utility2,ColIndex1,Utility1) :- R < 6, !.
better2(_,_R,_Player,_ColIndex1,_Utility1,ColIndex2,Utility2,ColIndex2,Utility2).

/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* maximizing / minimizing /// Ne sert pas dans cette version de minimax car elle est implémentée dans la fonction best  en faisant utility is -utility2
Cela permet de ne pas écrire en dure le nom de l'ia_player
*/
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/

maximizing(Player) :-
    ia_player(Player).

minimizing(Player) :-
    ia_player(IA),
    Player \= IA.

ia_player(x).  % Définir le joueur IA ici (x ou o)