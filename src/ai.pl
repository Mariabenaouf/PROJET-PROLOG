firstFreeIndexColonne(Board, ColIndex, Index):- 
    nth0(ColIndex, Board, Colonne), 
    between(0, 5, Index), 
    nth0(Index, Colonne, Elem), 
    var(Elem), !. % cherche le premier indice libre dans la colonne, s'arrête au premier trouvé
firstFreeIndexColonne(_, _, 6):- !. % si on n'a pas trouvé d'indice libre, on renvoie 7 (colonne pleine)

otherPlayer('x', 'o').
otherPlayer('o', 'x').

% Savoir si un joueur peut gagner au prochain coup en jouant dans une colonne
gagnableColonne(Board, ColIndex, ColonneAJouer, P) :- nth0(ColIndex,Board,Colonne), Colonne = [P,Q,R,S,_,_], P==Q, Q==R, var(S), nonvar(P), ColonneAJouer is ColIndex.
gagnableColonne(Board, ColIndex, ColonneAJouer, P) :- nth0(ColIndex,Board,Colonne), Colonne = [_,P,Q,R,S,_], P==Q, Q==R, var(S), nonvar(P), ColonneAJouer is ColIndex.
gagnableColonne(Board, ColIndex, ColonneAJouer, P) :- nth0(ColIndex,Board,Colonne), Colonne = [_,_,P,Q,R,S], P==Q, Q==R, var(S), nonvar(P), ColonneAJouer is ColIndex.

%Le premier élément est vide
gagnableLigne(Ligne, Board, P, ColonneAJouer) :- 
    firstFreeIndexColonne(Board,0,IndexLibre), Ligne==IndexLibre,
    nth0(1,Board,C1), nth0(Ligne,C1,P), nonvar(P),
    nth0(2,Board,C2), nth0(Ligne,C2,V2), P==V2,
    nth0(3,Board,C3), nth0(Ligne,C3,V3), P==V3,
    ColonneAJouer=0.
gagnableLigne(Ligne, Board, P, ColonneAJouer) :-
    firstFreeIndexColonne(Board,1,IndexLibre), Ligne==IndexLibre,
    nth0(2,Board,C2), nth0(Ligne,C2,P), nonvar(P),
    nth0(3,Board,C3), nth0(Ligne,C3,V3), P==V3,
    nth0(4,Board,C4), nth0(Ligne,C4,V4), P==V4,
    ColonneAJouer=1.
gagnableLigne(Ligne, Board, P, ColonneAJouer) :- 
    firstFreeIndexColonne(Board,2,IndexLibre), Ligne==IndexLibre,
    nth0(3,Board,C3), nth0(Ligne,C3,P), nonvar(P),
    nth0(4,Board,C4), nth0(Ligne,C4,V4), P==V4,
    nth0(5,Board,C5), nth0(Ligne,C5,V5), P==V5,
    ColonneAJouer=2.
gagnableLigne(Ligne, Board, P, ColonneAJouer) :- 
    firstFreeIndexColonne(Board,3,IndexLibre), Ligne==IndexLibre,
    nth0(4,Board,C4), nth0(Ligne,C4,P), nonvar(P),
    nth0(5,Board,C5), nth0(Ligne,C5,V5), P==V5,
    nth0(6,Board,C6), nth0(Ligne,C6,V6), P==V6,
    ColonneAJouer=3.

%Le deuxième élément est vide
gagnableLigne(Ligne, Board, P,ColonneAJouer) :- 
    nth0(0,Board,C0), nth0(Ligne,C0,P), nonvar(P),
    firstFreeIndexColonne(Board,1,IndexLibre), Ligne==IndexLibre,
    nth0(2,Board,C2), nth0(Ligne,C2,V2), P==V2,
    nth0(3,Board,C3), nth0(Ligne,C3,V3), P==V3,
    ColonneAJouer=1.
gagnableLigne(Ligne, Board, P,ColonneAJouer) :- 
    nth0(1,Board,C1), nth0(Ligne,C1,P), nonvar(P),
    firstFreeIndexColonne(Board,2,IndexLibre), Ligne==IndexLibre,
    nth0(3,Board,C3), nth0(Ligne,C3,V3), P==V3,
    nth0(4,Board,C4), nth0(Ligne,C4,V4), P==V4,
    ColonneAJouer=2.
gagnableLigne(Ligne, Board, P,ColonneAJouer) :- 
    nth0(2,Board,C2), nth0(Ligne,C2,P), nonvar(P),
    firstFreeIndexColonne(Board,3,IndexLibre), Ligne==IndexLibre,
    nth0(4,Board,C4), nth0(Ligne,C4,V4), P==V4,
    nth0(5,Board,C5), nth0(Ligne,C5,V5), P==V5,
    ColonneAJouer=3.
gagnableLigne(Ligne, Board, P,ColonneAJouer) :- 
    nth0(3,Board,C3), nth0(Ligne,C3,P), nonvar(P),
    firstFreeIndexColonne(Board,4,IndexLibre), Ligne==IndexLibre,
    nth0(5,Board,C5), nth0(Ligne,C5,V5), P==V5,
    nth0(6,Board,C6), nth0(Ligne,C6,V6), P==V6,
    ColonneAJouer=4.

%Le troisième élément est vide
gagnableLigne(Ligne, Board, P,ColonneAJouer) :- 
    nth0(0,Board,C0), nth0(Ligne,C0,P), nonvar(P),
    nth0(1,Board,C1), nth0(Ligne,C1,V1), P==V1,
    firstFreeIndexColonne(Board,2,IndexLibre), Ligne==IndexLibre,
    nth0(3,Board,C3), nth0(Ligne,C3,V3), P==V3,
    ColonneAJouer=2.
gagnableLigne(Ligne, Board, P,ColonneAJouer) :- 
    nth0(1,Board,C1), nth0(Ligne,C1,P), nonvar(P),
    nth0(2,Board,C2), nth0(Ligne,C2,V2), P==V2,
    firstFreeIndexColonne(Board,3,IndexLibre), Ligne==IndexLibre,
    nth0(4,Board,C4), nth0(Ligne,C4,V4), P==V4,
    ColonneAJouer=3.
gagnableLigne(Ligne, Board, P,ColonneAJouer) :- 
    nth0(2,Board,C2), nth0(Ligne,C2,P), nonvar(P),
    nth0(3,Board,C3), nth0(Ligne,C3,V3), P==V3,
    firstFreeIndexColonne(Board,4,IndexLibre), Ligne==IndexLibre,
    nth0(5,Board,C5), nth0(Ligne,C5,V5), P==V5,
    ColonneAJouer=4.
gagnableLigne(Ligne, Board, P,ColonneAJouer) :- 
    nth0(3,Board,C3), nth0(Ligne,C3,P), nonvar(P),
    nth0(4,Board,C4), nth0(Ligne,C4,V4), P==V4,
    firstFreeIndexColonne(Board,5,IndexLibre), Ligne==IndexLibre,
    nth0(6,Board,C6), nth0(Ligne,C6,V6), P==V6,
    ColonneAJouer=5.

% Le dernier élément est vide et jouable
gagnableLigne(Ligne, Board, P,ColonneAJouer) :- 
    nth0(0,Board,C0), nth0(Ligne,C0,P), nonvar(P),
    nth0(1,Board,C1), nth0(Ligne,C1,V1), P==V1,
    nth0(2,Board,C2), nth0(Ligne,C2,V2), P==V2,
    firstFreeIndexColonne(Board,3,IndexLibre), Ligne==IndexLibre,
    ColonneAJouer=3.
gagnableLigne(Ligne, Board, P,ColonneAJouer) :- 
    nth0(1,Board,C1), nth0(Ligne,C1,P), nonvar(P),
    nth0(2,Board,C2), nth0(Ligne,C2,V2), P==V2,
    nth0(3,Board,C3), nth0(Ligne,C3,V3), P==V3,
    firstFreeIndexColonne(Board,4,IndexLibre), Ligne==IndexLibre,
    ColonneAJouer=4.
gagnableLigne(Ligne, Board, P,ColonneAJouer) :- 
    nth0(2,Board,C2), nth0(Ligne,C2,P), nonvar(P),
    nth0(3,Board,C3), nth0(Ligne,C3,V3), P==V3,
    nth0(4,Board,C4), nth0(Ligne,C4,V4), P==V4,
    firstFreeIndexColonne(Board,5,IndexLibre), Ligne==IndexLibre,
    ColonneAJouer=5.
gagnableLigne(Ligne, Board, P,ColonneAJouer) :- 
    nth0(3,Board,C3), nth0(Ligne,C3,P), nonvar(P),
    nth0(4,Board,C4), nth0(Ligne,C4,V4), P==V4,
    nth0(5,Board,C5), nth0(Ligne,C5,V5), P==V5,
    firstFreeIndexColonne(Board,6,IndexLibre), Ligne==IndexLibre,
    ColonneAJouer=6.




% Pour les diagonales il y a deux directions (de gauche à droite): de haut en bas et de bas en haut
% De G à D : On prend la case de départ (on itère sur les lignes 3 à 5 et les colonnes 0 à 3) et on regarde les 3 cases suivantes en diagonale en augmentant C et diminuant L
gagnableDiagonaleHB(L, C, Board, P, ColonneAJouer) :-
    firstFreeIndexColonne(Board, C, IndexLibre), IndexLibre==L,
    C1 is C+1, nth0(C1,Board,Ca), L1 is L-1, nth0(L1,Ca,P), nonvar(P),
    C2 is C+2, nth0(C2,Board,Cb), L2 is L-2, nth0(L2,Cb,V2), P==V2,
    C3 is C+3, nth0(C3,Board,Cc), L3 is L-3, nth0(L3,Cc,V3), P==V3,
    ColonneAJouer = C.
gagnableDiagonaleHB(L, C, Board, P, ColonneAJouer) :-
    nth0(C,Board,C0), nth0(L,C0,P), nonvar(P),
    C1 is C+1, L1 is L-1, firstFreeIndexColonne(Board, C1, IndexLibre), IndexLibre==L1,
    C2 is C+2, nth0(C2,Board,Cb), L2 is L-2, nth0(L2,Cb,V2), P==V2,
    C3 is C+3, nth0(C3,Board,Cc), L3 is L-3, nth0(L3,Cc,V3), P==V3,
    ColonneAJouer = C1.
gagnableDiagonaleHB(L, C, Board, P, ColonneAJouer) :-
    nth0(C,Board,C0), nth0(L,C0,P), nonvar(P),
    C1 is C+1, nth0(C1,Board,Ca), L1 is L-1, nth0(L1,Ca,V1), P==V1,
    C2 is C+2, L2 is L-2, firstFreeIndexColonne(Board, C2, IndexLibre), IndexLibre==L2,
    C3 is C+3, nth0(C3,Board,Cc), L3 is L-3, nth0(L3,Cc,V3), P==V3,
    ColonneAJouer = C2.
gagnableDiagonaleHB(L, C, Board, P, ColonneAJouer) :-
    nth0(C,Board,C0), nth0(L,C0,P), nonvar(P),
    C1 is C+1, nth0(C1,Board,Ca), L1 is L-1, nth0(L1,Ca,V1), P==V1,
    C2 is C+2, nth0(C2,Board,Cb), L2 is L-2, nth0(L2,Cb,V2), P==V2,
    C3 is C+3, L3 is L-3, firstFreeIndexColonne(Board, C3, IndexLibre), IndexLibre==L3,
    ColonneAJouer = C3.

% De D à G : On prend la case de départ (on itère sur les lignes 0 à 2 et les colonnes 0 à 3) et on regarde les 3 cases suivantes en diagonale en augmentant C et L
gagnableDiagonaleBH(L, C, Board, P, ColonneAJouer) :-
    firstFreeIndexColonne(Board, C, IndexLibre), IndexLibre==L,
    C1 is C+1, nth0(C1,Board,Ca), L1 is L+1, nth0(L1,Ca,P), nonvar(P),
    C2 is C+2, nth0(C2,Board,Cb), L2 is L+2, nth0(L2,Cb,V2), P==V2,
    C3 is C+3, nth0(C3,Board,Cc), L3 is L+3, nth0(L3,Cc,V3), var(V3),
    ColonneAJouer = C.
gagnableDiagonaleBH(L, C, Board, P, ColonneAJouer) :-
    nth0(C,Board,C0), nth0(L,C0,P), nonvar(P),
    C1 is C+1, L1 is L+1, firstFreeIndexColonne(Board, C1, IndexLibre), IndexLibre==L1,
    C2 is C+2, nth0(C2,Board,Cb), L2 is L+2, nth0(L2,Cb,V2), P==V2,
    C3 is C+3, nth0(C3,Board,Cc), L3 is L+3, nth0(L3,Cc,V3), var(V3),
    ColonneAJouer = C1.
gagnableDiagonaleBH(L, C, Board, P, ColonneAJouer) :-
    nth0(C,Board,C0), nth0(L,C0,P), nonvar(P),
    C1 is C+1, nth0(C1,Board,Ca), L1 is L+1, nth0(L1,Ca,V1), P==V1,
    C2 is C+2, L2 is L+2, firstFreeIndexColonne(Board, C2, IndexLibre), IndexLibre==L2,
    C3 is C+3, nth0(C3,Board,Cc), L3 is L+3, nth0(L3,Cc,V3), var(V3),
    ColonneAJouer = C2.
gagnableDiagonaleBH(L, C, Board, P, ColonneAJouer) :-
    nth0(C,Board,C0), nth0(L,C0,P), nonvar(P),
    C1 is C+1, nth0(C1,Board,Ca), L1 is L+1, nth0(L1,Ca,V1), P==V1,
    C2 is C+2, nth0(C2,Board,Cb), L2 is L+2, nth0(L2,Cb,V2), P==V2,
    C3 is C+3, L3 is L+3, firstFreeIndexColonne(Board, C3, IndexLibre), IndexLibre==L3,
    ColonneAJouer = C3.

gagnable(Board, P, ColonneAJouer) :- between(0, 6, C), gagnableColonne(Board, C, ColonneAJouer, P).
gagnable(Board, P, ColonneAJouer) :- between(0, 5, L), gagnableLigne(L, Board, P, ColonneAJouer).
gagnable(Board, P, ColonneAJouer) :- between(3, 5, L), between(0, 3, C), gagnableDiagonaleHB(L, C, Board, P, ColonneAJouer).
gagnable(Board, P, ColonneAJouer) :- between(0, 2, L), between(0, 3, C), gagnableDiagonaleBH(L, C, Board, P, ColonneAJouer).


ia(Board, ColIndex, ElemIndex, Player):-
    copy_term(Board, BoardCopy),
    gagnable(BoardCopy, Player, ColIndex), % check if the AI can win in the next move
    firstFreeIndexColonne(Board, ColIndex, ElemIndex), ElemIndex\==6, !.

ia(Board, ColIndex, ElemIndex, Player):-
    changePlayer(Player, Opponent),
    copy_term(Board, BoardCopy),
    gagnable(BoardCopy, Opponent, ColIndex), % check if the AI can block the opponent in the next move
    firstFreeIndexColonne(Board, ColIndex, ElemIndex), ElemIndex\==6, !.

% Basic IA that plays randomly in a non-full column
ia(Board, RandCol, ElemIndex, _):-
    repeat, random(0,7,RandCol), firstFreeIndexColonne(Board, RandCol, ElemIndex), ElemIndex\==6, !.