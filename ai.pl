
firstFreeIndexColonne(Board, ColIndex, Index):- 
    nth0(ColIndex, Board, Colonne), 
    between(0, 5, Index), 
    nth0(Index, Colonne, Elem), 
    var(Elem), !. % cherche le premier indice libre dans la colonne, s'arrête au premier trouvé
firstFreeIndexColonne(_, _, 6):- !. % si on n'a pas trouvé d'indice libre, on renvoie 7 (colonne pleine)

% Basic IA that plays randomly in a non-full column
ia(Board, RandCol, ElemIndex, _):-
    repeat, random(0,7,RandCol), firstFreeIndexColonne(Board, RandCol, ElemIndex), ElemIndex\==6, !.

% Savoir si un joueur peut gagner au prochain coup en jouant dans une colonne
gagnableColonne(Colonne, P) :- Colonne = [P,Q,R,S,_,_], P==Q, Q==R, var(S), nonvar(P).
gagnableColonne(Colonne, P) :- Colonne = [_,P,Q,R,S,_], P==Q, Q==R, var(S), nonvar(P).
gagnableColonne(Colonne, P) :- Colonne = [_,_,P,Q,R,S], P==Q, Q==R, var(S), nonvar(P).

%Le premier élément est vide
gagnableLigne(Ligne, Board, P, ColonneAJouer) :- 
    nth0(0,Board,C0), firstFreeIndexColonne(Board,C0,IndexLibre), Ligne==IndexLibre,
    nth0(1,Board,C1), nth0(Ligne,C1,P), nonvar(P),
    nth0(2,Board,C2), nth0(Ligne,C2,V2), P==V2,
    nth0(3,Board,C3), nth0(Ligne,C3,V3), P==V3,
    ColonneAJouer=C0.
gagnableLigne(Ligne, Board, P, ColonneAJouer) :-
    nth0(1,Board,C1), firstFreeIndexColonne(Board,C1,IndexLibre), Ligne==IndexLibre,
    nth0(2,Board,C2), nth0(Ligne,C2,P), nonvar(P),
    nth0(3,Board,C3), nth0(Ligne,C3,V3), P==V3,
    nth0(4,Board,C4), nth0(Ligne,C4,V4), P==V4,
    ColonneAJouer=C1.
gagnableLigne(Ligne, Board, P, ColonneAJouer) :- 
    nth0(2,Board,C2), firstFreeIndexColonne(Board,C2,IndexLibre), Ligne==IndexLibre,
    nth0(3,Board,C3), nth0(Ligne,C3,P), nonvar(P),
    nth0(4,Board,C4), nth0(Ligne,C4,V4), P==V4,
    nth0(5,Board,C5), nth0(Ligne,C5,V5), P==V5,
    ColonneAJouer=C2.
gagnableLigne(Ligne, Board, P, ColonneAJouer) :- 
    nth0(3,Board,C3), firstFreeIndexColonne(Board,C3,IndexLibre), Ligne==IndexLibre,
    nth0(4,Board,C4), nth0(Ligne,C4,P), nonvar(P),
    nth0(5,Board,C5), nth0(Ligne,C5,V5), P==V5,
    nth0(6,Board,C6), nth0(Ligne,C6,V6), P==V6,
    ColonneAJouer=C3.

%Le deuxième élément est vide

gagnableLigne(Ligne, Board, P,ColonneAJouer) :- 
    nth0(0,Board,C0), nth0(Ligne,C0,P), nonvar(P),
    nth0(1,Board,C1), firstFreeIndexColonne(Board,C1,IndexLibre), Ligne==IndexLibre,
    nth0(2,Board,C2), nth0(Ligne,C2,V2), P==V2,
    nth0(3,Board,C3), nth0(Ligne,C3,V3), P==V3,
    ColonneAJouer=C1.
gagnableLigne(Ligne, Board, P,ColonneAJouer) :- 
    nth0(1,Board,C1), nth0(Ligne,C1,P), nonvar(P),
    nth0(2,Board,C2), firstFreeIndexColonne(Board,C2,IndexLibre), Ligne==IndexLibre,
    nth0(3,Board,C3), nth0(Ligne,C3,V3), P==V3,
    nth0(4,Board,C4), nth0(Ligne,C4,V4), P==V4,
    ColonneAJouer=C2.
gagnableLigne(Ligne, Board, P,ColonneAJouer) :- 
    nth0(2,Board,C2), nth0(Ligne,C2,P), nonvar(P),
    nth0(3,Board,C3), firstFreeIndexColonne(Board,C3,IndexLibre), Ligne==IndexLibre,
    nth0(4,Board,C4), nth0(Ligne,C4,V4), P==V4,
    nth0(5,Board,C5), nth0(Ligne,C5,V5), P==V5,
    ColonneAJouer=C3.
gagnableLigne(Ligne, Board, P,ColonneAJouer) :- 
    nth0(3,Board,C3), nth0(Ligne,C3,P), nonvar(P),
    nth0(4,Board,C4), firstFreeIndexColonne(Board,C4,IndexLibre), Ligne==IndexLibre,
    nth0(5,Board,C5), nth0(Ligne,C5,V5), P==V5,
    nth0(6,Board,C6), nth0(Ligne,C6,V6), P==V6,
    ColonneAJouer=C4.

%Le troisième élément est vide
gagnableLigne(Ligne, Board, P) :- 
    nth0(0,Board,C0), nth0(Ligne,C0,P), nonvar(P),
    nth0(1,Board,C1), nth0(Ligne,C1,V1), P==V1,
    nth0(2,Board,C2), firstFreeIndexColonne(Board,C2,IndexLibre), Ligne==IndexLibre,
    nth0(3,Board,C3), nth0(Ligne,C3,V3), P==V3,
    ColonneAJouer=C2.
gagnableLigne(Ligne, Board, P) :- 
    nth0(1,Board,C1), nth0(Ligne,C1,P), nonvar(P),
    nth0(2,Board,C2), nth0(Ligne,C2,V2), P==V2,
    nth0(3,Board,C3), firstFreeIndexColonne(Board,C3,IndexLibre), Ligne==IndexLibre,
    nth0(4,Board,C4), nth0(Ligne,C4,V4), P==V4,
    ColonneAJouer=C3.
gagnableLigne(Ligne, Board, P) :- 
    nth0(2,Board,C2), nth0(Ligne,C2,P), nonvar(P),
    nth0(3,Board,C3), nth0(Ligne,C3,V3), P==V3,
    nth0(4,Board,C4), firstFreeIndexColonne(Board,C4,IndexLibre), Ligne==IndexLibre,
    nth0(5,Board,C5), nth0(Ligne,C5,V5), P==V5,
    ColonneAJouer=C4.
gagnableLigne(Ligne, Board, P) :- 
    nth0(3,Board,C3), nth0(Ligne,C3,P), nonvar(P),
    nth0(4,Board,C4), nth0(Ligne,C4,V4), P==V4,
    nth0(5,Board,C5), firstFreeIndexColonne(Board,C5,IndexLibre), Ligne==IndexLibre,
    nth0(6,Board,C6), nth0(Ligne,C6,V6), P==V6,
    ColonneAJouer=C5.

% Le dernier élément est vide et jouable
gagnableLigne(Ligne, Board, P,ColonneAJouer) :- 
    nth0(0,Board,C0), nth0(Ligne,C0,P), nonvar(P),
    nth0(1,Board,C1), nth0(Ligne,C1,V1), P==V1,
    nth0(2,Board,C2), nth0(Ligne,C2,V2), P==V2,
    nth0(3,Board,C3), firstFreeIndexColonne(Board,C3,IndexLibre), Ligne==IndexLibre,
    ColonneAJouer=C3.
gagnableLigne(Ligne, Board, P,ColonneAJouer) :- 
    nth0(1,Board,C1), nth0(Ligne,C1,P), nonvar(P),
    nth0(2,Board,C2), nth0(Ligne,C2,V2), P==V2,
    nth0(3,Board,C3), nth0(Ligne,C3,V3), P==V3,
    nth0(4,Board,C4), firstFreeIndexColonne(Board,C4,IndexLibre), Ligne==IndexLibre,
    ColonneAJouer=C4.
gagnableLigne(Ligne, Board, P,ColonneAJouer) :- 
    nth0(2,Board,C2), nth0(Ligne,C2,P), nonvar(P),
    nth0(3,Board,C3), nth0(Ligne,C3,V3), P==V3,
    nth0(4,Board,C4), nth0(Ligne,C4,V4), P==V4,
    nth0(5,Board,C5), firstFreeIndexColonne(Board,C5,IndexLibre), Ligne==IndexLibre,
    ColonneAJouer=C5.
gagnableLigne(Ligne, Board, P,ColonneAJouer) :- 
    nth0(3,Board,C3), nth0(Ligne,C3,P), nonvar(P),
    nth0(4,Board,C4), nth0(Ligne,C4,V4), P==V4,
    nth0(5,Board,C5), nth0(Ligne,C5,V5), P==V5,
    nth0(6,Board,C6), firstFreeIndexColonne(Board,C6,IndexLibre), Ligne==IndexLibre,
    ColonneAJouer=C6.




gagnableDiagonaleHB(L, C, Board, P) :-
    nth0(C,Board,C0), nth0(L,C0,P), nonvar(P),
    C1 is C+1, nth0(C1,Board,Ca), L1 is L-1, nth0(L1,Ca,V1), P==V1,
    C2 is C+2, nth0(C2,Board,Cb), L2 is L-2, nth0(L2,Cb,V2), P==V2,
    C3 is C+3, nth0(C3,Board,Cc), L3 is L-3, nth0(L3,Cc,V3), var(V3).

gagnableDiagonaleBH(L, C, Board, P) :-
    nth0(C,Board,C0), nth0(L,C0,P), nonvar(P),
    C1 is C+1, nth0(C1,Board,Ca), L1 is L+1, nth0(L1,Ca,V1), P==V1,
    C2 is C+2, nth0(C2,Board,Cb), L2 is L+2, nth0(L2,Cb,V2), P==V2,
    C3 is C+3, nth0(C3,Board,Cc), L3 is L+3, nth0(L3,Cc,V3), var(V3).

gagnable(Board, P) :- member(Col, Board), gagnableColonne(Col, P).
gagnable(Board, P) :- between(0, 5, L), gagnableLigne(L, Board, P).
gagnable(Board, P) :- between(3, 5, L), between(0, 3, C), gagnableDiagonaleHB(L, C, Board, P).
gagnable(Board, P) :- between(0, 2, L), between(0, 3, C), gagnableDiagonaleBH(L, C, Board, P).
