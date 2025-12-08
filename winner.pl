gameover(Winner) :- board(Board), winner(Board,Winner), !.
gameover('Draw') :- board(Board), isBoardFull(Board).

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

winnerDiagonaleHB(L, C, Board, P) :-
    nth0(C,Board,C0), nth0(L,C0,P), nonvar(P),
    C1 is C+1, nth0(C1,Board,Ca), L1 is L-1, nth0(L1,Ca,V1), P==V1,
    C2 is C+2, nth0(C2,Board,Cb), L2 is L-2, nth0(L2,Cb,V2), P==V2,
    C3 is C+3, nth0(C3,Board,Cc), L3 is L-3, nth0(L3,Cc,V3), P==V3.

winnerDiagonaleBH(L, C, Board, P) :-
    nth0(C,Board,C0), nth0(L,C0,P), nonvar(P),
    C1 is C+1, nth0(C1,Board,Ca), L1 is L+1, nth0(L1,Ca,V1), P==V1,
    C2 is C+2, nth0(C2,Board,Cb), L2 is L+2, nth0(L2,Cb,V2), P==V2,
    C3 is C+3, nth0(C3,Board,Cc), L3 is L+3, nth0(L3,Cc,V3), P==V3.

winner(Board, P) :- member(Col, Board), winnerColonne(Col, P).
winner(Board, P) :- between(0, 5, L), winnerLigne(L, Board, P).
winner(Board, P) :- between(3, 5, L), between(0, 3, C), winnerDiagonaleHB(L, C, Board, P).
winner(Board, P) :- between(0, 2, L), between(0, 3, C), winnerDiagonaleBH(L, C, Board, P).

isBoardFull([]).
isBoardFull([Col|Rest]) :-
    maplist(nonvar, Col),
    isBoardFull(Rest).
