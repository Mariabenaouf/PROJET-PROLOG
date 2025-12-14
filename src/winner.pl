/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* Check for game over */
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/

gameover(Winner) :- board(Board), winner(Board,Winner), !. 
gameover('Draw') :- board(Board), isBoardFull(Board).

% Test if a Board is a winning configuration for player P.

% Pour les colonnes on regarde si on a 4 fois le même symbole de suite
% nonvar(P) vérifie que l'on regarde bien les cases instanciées (celles où les joueurs ont joué)
winnerColonne(Colonne, P) :- Colonne = [P,Q,R,S,_,_], P==Q, Q==R, R==S, nonvar(P).
winnerColonne(Colonne, P) :- Colonne = [_,P,Q,R,S,_], P==Q, Q==R, R==S, nonvar(P).
winnerColonne(Colonne, P) :- Colonne = [_,_,P,Q,R,S], P==Q, Q==R, R==S, nonvar(P).

% Pour les lignes on regarde chaque ligne (between(0,5,Ligne)) et on vérifie 4 colonnes si on a le même symbole
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

% Pour les diagonales il y a deux directions (de gauche à droite): de haut en bas et de bas en haut
% De G à D : On prend la case de départ (on itère sur les lignes 3 à 5 et les colonnes 0 à 3) et on regarde les 3 cases suivantes en diagonale en augmentant C et diminuant L
winnerDiagonaleHB(L, C, Board, P) :-
    nth0(C,Board,C0), nth0(L,C0,P), nonvar(P),
    C1Index is C+1, nth0(C1Index,Board,C1), L1Index is L-1, nth0(L1Index,C1,V1), P==V1,
    C2Index is C+2, nth0(C2Index,Board,C2), L2Index is L-2, nth0(L2Index,C2,V2), P==V2,
    C3Index is C+3, nth0(C3Index,Board,C3), L3Index is L-3, nth0(L3Index,C3,V3), P==V3.

% De D à G : On prend la case de départ (on itère sur les lignes 0 à 2 et les colonnes 0 à 3) et on regarde les 3 cases suivantes en diagonale en augmentant C et L
winnerDiagonaleBH(L, C, Board, P) :-
    nth0(C,Board,C0), nth0(L,C0,P), nonvar(P),
    C1Index is C+1, nth0(C1Index,Board,C1), L1Index is L+1, nth0(L1Index,C1,V1), P==V1,
    C2Index is C+2, nth0(C2Index,Board,C2), L2Index is L+2, nth0(L2Index,C2,V2), P==V2,
    C3Index is C+3, nth0(C3Index,Board,C3), L3Index is L+3, nth0(L3Index,C3,V3), P==V3.

winner(Board, P) :-
    member(Colonne, Board),
    winnerColonne(Colonne, P).
winner(Board, P) :-
    between(0, 5, Ligne),
    winnerLigne(Ligne, Board, P).
winner(Board, P) :-
    between(3, 5, Ligne),
    between(0, 3, Colonne),
    winnerDiagonaleHB(Ligne, Colonne, Board, P).
winner(Board, P) :-
    between(0, 2, Ligne),
    between(0, 3, Colonne),
    winnerDiagonaleBH(Ligne, Colonne, Board, P).

% Check if all the elements of the List (the board) are instanciated
isBoardFull([]).
isBoardFull([Col|Rest]) :-
    maplist(nonvar, Col),
    isBoardFull(Rest).
