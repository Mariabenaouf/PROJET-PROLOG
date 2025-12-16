:- module(ai, [
    ia1/4,
    ia2/4,
    gagnable/3
]).
:- use_module(rules).
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* Classic AI rules */
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/

otherPlayer('x', 'o').
otherPlayer('o', 'x').

% Savoir si un joueur peut gagner au prochain coup en jouant dans une colonne
gagnableColonne(Board, ColIndex, ColonneAJouer, P) :- nth0(ColIndex,Board,Colonne), Colonne = [P,Q,R,S,_,_], P==Q, Q==R, var(S), nonvar(P), ColonneAJouer is ColIndex.
gagnableColonne(Board, ColIndex, ColonneAJouer, P) :- nth0(ColIndex,Board,Colonne), Colonne = [_,P,Q,R,S,_], P==Q, Q==R, var(S), nonvar(P), ColonneAJouer is ColIndex.
gagnableColonne(Board, ColIndex, ColonneAJouer, P) :- nth0(ColIndex,Board,Colonne), Colonne = [_,_,P,Q,R,S], P==Q, Q==R, var(S), nonvar(P), ColonneAJouer is ColIndex.

%Le premier élément est vide
gagnableLigne(Ligne, Board, P, ColonneAJouer) :- 
    firstFreeIndexColonne(Board,0,IndexLibre), Ligne==IndexLibre,
    nth0(1,Board,C1), nth0(Ligne,C1,V1), nonvar(V1), V1==P,
    nth0(2,Board,C2), nth0(Ligne,C2,V2), nonvar(V2), V2==P,
    nth0(3,Board,C3), nth0(Ligne,C3,V3), nonvar(V3), V3==P,
    ColonneAJouer=0.
gagnableLigne(Ligne, Board, P, ColonneAJouer) :-
    firstFreeIndexColonne(Board,1,IndexLibre), Ligne==IndexLibre,
    nth0(2,Board,C2), nth0(Ligne,C2,V2), nonvar(V2), V2==P,
    nth0(3,Board,C3), nth0(Ligne,C3,V3), nonvar(V3), V3==P,
    nth0(4,Board,C4), nth0(Ligne,C4,V4), nonvar(V4), V4==P,
    ColonneAJouer=1.
gagnableLigne(Ligne, Board, P, ColonneAJouer) :- 
    firstFreeIndexColonne(Board,2,IndexLibre), Ligne==IndexLibre,
    nth0(3,Board,C3), nth0(Ligne,C3,V3), nonvar(V3), V3==P,
    nth0(4,Board,C4), nth0(Ligne,C4,V4), nonvar(V4), V4==P,
    nth0(5,Board,C5), nth0(Ligne,C5,V5), nonvar(V5), V5==P,
    ColonneAJouer=2.
gagnableLigne(Ligne, Board, P, ColonneAJouer) :- 
    firstFreeIndexColonne(Board,3,IndexLibre), Ligne==IndexLibre,
    nth0(4,Board,C4), nth0(Ligne,C4,V4), nonvar(V4), V4==P,
    nth0(5,Board,C5), nth0(Ligne,C5,V5), nonvar(V5), V5==P,
    nth0(6,Board,C6), nth0(Ligne,C6,V6), nonvar(V6), V6==P,
    ColonneAJouer=3.

%Le deuxième élément est vide
gagnableLigne(Ligne, Board, P,ColonneAJouer) :- 
    nth0(0,Board,C0), nth0(Ligne,C0,V0), nonvar(V0), V0==P,
    firstFreeIndexColonne(Board,1,IndexLibre), Ligne==IndexLibre,
    nth0(2,Board,C2), nth0(Ligne,C2,V2), nonvar(V2), V2==P,
    nth0(3,Board,C3), nth0(Ligne,C3,V3), nonvar(V3), V3==P,
    ColonneAJouer=1.
gagnableLigne(Ligne, Board, P,ColonneAJouer) :- 
    nth0(1,Board,C1), nth0(Ligne,C1,V1), nonvar(V1), V1==P,
    firstFreeIndexColonne(Board,2,IndexLibre), Ligne==IndexLibre,
    nth0(3,Board,C3), nth0(Ligne,C3,V3), nonvar(V3), V3==P,
    nth0(4,Board,C4), nth0(Ligne,C4,V4), nonvar(V4), V4==P,
    ColonneAJouer=2.
gagnableLigne(Ligne, Board, P,ColonneAJouer) :- 
    nth0(2,Board,C2), nth0(Ligne,C2,V2), nonvar(V2), V2==P,
    firstFreeIndexColonne(Board,3,IndexLibre), Ligne==IndexLibre,
    nth0(4,Board,C4), nth0(Ligne,C4,V4), nonvar(V4), V4==P,
    nth0(5,Board,C5), nth0(Ligne,C5,V5), nonvar(V5), V5==P,
    ColonneAJouer=3.
gagnableLigne(Ligne, Board, P,ColonneAJouer) :- 
    nth0(3,Board,C3), nth0(Ligne,C3,V3), nonvar(V3), V3==P,
    firstFreeIndexColonne(Board,4,IndexLibre), Ligne==IndexLibre,
    nth0(5,Board,C5), nth0(Ligne,C5,V5), nonvar(V5), V5==P,
    nth0(6,Board,C6), nth0(Ligne,C6,V6), nonvar(V6), V6==P,
    ColonneAJouer=4.

%Le troisième élément est vide
gagnableLigne(Ligne, Board, P,ColonneAJouer) :- 
    nth0(0,Board,C0), nth0(Ligne,C0,V0), nonvar(V0), V0==P,
    nth0(1,Board,C1), nth0(Ligne,C1,V1), nonvar(V1), V1==P,
    firstFreeIndexColonne(Board,2,IndexLibre), Ligne==IndexLibre,
    nth0(3,Board,C3), nth0(Ligne,C3,V3), nonvar(V3), V3==P,
    ColonneAJouer=2.
gagnableLigne(Ligne, Board, P,ColonneAJouer) :- 
    nth0(1,Board,C1), nth0(Ligne,C1,V1), nonvar(V1), V1==P,
    nth0(2,Board,C2), nth0(Ligne,C2,V2), nonvar(V2), V2==P,
    firstFreeIndexColonne(Board,3,IndexLibre), Ligne==IndexLibre,
    nth0(4,Board,C4), nth0(Ligne,C4,V4), nonvar(V4), V4==P,
    ColonneAJouer=3.
gagnableLigne(Ligne, Board, P,ColonneAJouer) :- 
    nth0(2,Board,C2), nth0(Ligne,C2,V2), nonvar(V2), V2==P,
    nth0(3,Board,C3), nth0(Ligne,C3,V3), nonvar(V3), V3==P,
    firstFreeIndexColonne(Board,4,IndexLibre), Ligne==IndexLibre,
    nth0(5,Board,C5), nth0(Ligne,C5,V5), nonvar(V5), V5==P,
    ColonneAJouer=4.
gagnableLigne(Ligne, Board, P,ColonneAJouer) :- 
    nth0(3,Board,C3), nth0(Ligne,C3,V3), nonvar(V3), V3==P,
    nth0(4,Board,C4), nth0(Ligne,C4,V4), nonvar(V4), V4==P,
    firstFreeIndexColonne(Board,5,IndexLibre), Ligne==IndexLibre,
    nth0(6,Board,C6), nth0(Ligne,C6,V6), nonvar(V6), V6==P,
    ColonneAJouer=5.

% Le dernier élément est vide et jouable
gagnableLigne(Ligne, Board, P,ColonneAJouer) :- 
    nth0(0,Board,C0), nth0(Ligne,C0,V0), nonvar(V0), V0==P,
    nth0(1,Board,C1), nth0(Ligne,C1,V1), nonvar(V1), V1==P,
    nth0(2,Board,C2), nth0(Ligne,C2,V2), nonvar(V2), V2==P,
    firstFreeIndexColonne(Board,3,IndexLibre), Ligne==IndexLibre,
    ColonneAJouer=3.
gagnableLigne(Ligne, Board, P,ColonneAJouer) :- 
    nth0(1,Board,C1), nth0(Ligne,C1,V1), nonvar(V1), V1==P,
    nth0(2,Board,C2), nth0(Ligne,C2,V2), nonvar(V2), V2==P,
    nth0(3,Board,C3), nth0(Ligne,C3,V3), nonvar(V3), V3==P,
    firstFreeIndexColonne(Board,4,IndexLibre), Ligne==IndexLibre,
    ColonneAJouer=4.
gagnableLigne(Ligne, Board, P,ColonneAJouer) :- 
    nth0(2,Board,C2), nth0(Ligne,C2,V2), nonvar(V2), V2==P,
    nth0(3,Board,C3), nth0(Ligne,C3,V3), nonvar(V3), V3==P,
    nth0(4,Board,C4), nth0(Ligne,C4,V4), nonvar(V4), V4==P,
    firstFreeIndexColonne(Board,5,IndexLibre), Ligne==IndexLibre,
    ColonneAJouer=5.
gagnableLigne(Ligne, Board, P,ColonneAJouer) :- 
    nth0(3,Board,C3), nth0(Ligne,C3,V3), nonvar(V3), V3==P,
    nth0(4,Board,C4), nth0(Ligne,C4,V4), nonvar(V4), V4==P,
    nth0(5,Board,C5), nth0(Ligne,C5,V5), nonvar(V5), V5==P,
    firstFreeIndexColonne(Board,6,IndexLibre), Ligne==IndexLibre,
    ColonneAJouer=6.




% Pour les diagonales il y a deux directions (de gauche à droite): de haut en bas et de bas en haut
% De G à D : On prend la case de départ (on itère sur les lignes 3 à 5 et les colonnes 0 à 3) et on regarde les 3 cases suivantes en diagonale en augmentant C et diminuant L
gagnableDiagonaleHB(L, C, Board, P, ColonneAJouer) :-
    firstFreeIndexColonne(Board, C, IndexLibre), IndexLibre==L,
    C1 is C+1, nth0(C1,Board,Ca), L1 is L-1, nth0(L1,Ca,V1), nonvar(V1), V1==P,
    C2 is C+2, nth0(C2,Board,Cb), L2 is L-2, nth0(L2,Cb,V2), nonvar(V2), V2==P,
    C3 is C+3, nth0(C3,Board,Cc), L3 is L-3, nth0(L3,Cc,V3), nonvar(V3), V3==P,
    ColonneAJouer = C.
gagnableDiagonaleHB(L, C, Board, P, ColonneAJouer) :-
    nth0(C,Board,C0), nth0(L,C0,V0), nonvar(V0), V0==P,
    C1 is C+1, L1 is L-1, firstFreeIndexColonne(Board, C1, IndexLibre), IndexLibre==L1,
    C2 is C+2, nth0(C2,Board,Cb), L2 is L-2, nth0(L2,Cb,V2), nonvar(V2), V2==P,
    C3 is C+3, nth0(C3,Board,Cc), L3 is L-3, nth0(L3,Cc,V3), nonvar(V3), V3==P,
    ColonneAJouer = C1.
gagnableDiagonaleHB(L, C, Board, P, ColonneAJouer) :-
    nth0(C,Board,C0), nth0(L,C0,V0), nonvar(V0), V0==P,
    C1 is C+1, nth0(C1,Board,Ca), L1 is L-1, nth0(L1,Ca,V1), nonvar(V1), V1==P,
    C2 is C+2, L2 is L-2, firstFreeIndexColonne(Board, C2, IndexLibre), IndexLibre==L2,
    C3 is C+3, nth0(C3,Board,Cc), L3 is L-3, nth0(L3,Cc,V3), nonvar(V3), V3==P,
    ColonneAJouer = C2.
gagnableDiagonaleHB(L, C, Board, P, ColonneAJouer) :-
    nth0(C,Board,C0), nth0(L,C0,V0), nonvar(V0), V0==P,
    C1 is C+1, nth0(C1,Board,Ca), L1 is L-1, nth0(L1,Ca,V1), nonvar(V1), V1==P,
    C2 is C+2, nth0(C2,Board,Cb), L2 is L-2, nth0(L2,Cb,V2), nonvar(V2), V2==P,
    C3 is C+3, L3 is L-3, firstFreeIndexColonne(Board, C3, IndexLibre), IndexLibre==L3,
    ColonneAJouer = C3.

% De D à G : On prend la case de départ (on itère sur les lignes 0 à 2 et les colonnes 0 à 3) et on regarde les 3 cases suivantes en diagonale en augmentant C et L
gagnableDiagonaleBH(L, C, Board, P, ColonneAJouer) :-
    firstFreeIndexColonne(Board, C, IndexLibre), IndexLibre==L,
    C1 is C+1, nth0(C1,Board,Ca), L1 is L+1, nth0(L1,Ca,V1), nonvar(V1), V1==P,
    C2 is C+2, nth0(C2,Board,Cb), L2 is L+2, nth0(L2,Cb,V2), nonvar(V2), V2==P,
    C3 is C+3, nth0(C3,Board,Cc), L3 is L+3, nth0(L3,Cc,V3), var(V3),
    ColonneAJouer = C.
gagnableDiagonaleBH(L, C, Board, P, ColonneAJouer) :-
    nth0(C,Board,C0), nth0(L,C0,V0), nonvar(V0), V0==P,
    C1 is C+1, L1 is L+1, firstFreeIndexColonne(Board, C1, IndexLibre), IndexLibre==L1,
    C2 is C+2, nth0(C2,Board,Cb), L2 is L+2, nth0(L2,Cb,V2), nonvar(V2), V2==P,
    C3 is C+3, nth0(C3,Board,Cc), L3 is L+3, nth0(L3,Cc,V3), var(V3),
    ColonneAJouer = C1.
gagnableDiagonaleBH(L, C, Board, P, ColonneAJouer) :-
    nth0(C,Board,C0), nth0(L,C0,V0), nonvar(V0), V0==P,
    C1 is C+1, nth0(C1,Board,Ca), L1 is L+1, nth0(L1,Ca,V1), nonvar(V1), V1==P,
    C2 is C+2, L2 is L+2, firstFreeIndexColonne(Board, C2, IndexLibre), IndexLibre==L2,
    C3 is C+3, nth0(C3,Board,Cc), L3 is L+3, nth0(L3,Cc,V3), var(V3),
    ColonneAJouer = C2.
gagnableDiagonaleBH(L, C, Board, P, ColonneAJouer) :-
    nth0(C,Board,C0), nth0(L,C0,V0), nonvar(V0), V0==P,
    C1 is C+1, nth0(C1,Board,Ca), L1 is L+1, nth0(L1,Ca,V1), nonvar(V1), V1==P,
    C2 is C+2, nth0(C2,Board,Cb), L2 is L+2, nth0(L2,Cb,V2), nonvar(V2), V2==P,
    C3 is C+3, L3 is L+3, firstFreeIndexColonne(Board, C3, IndexLibre), IndexLibre==L3,
    ColonneAJouer = C3.

gagnable(Board, P, ColonneAJouer) :- between(0, 6, C), gagnableColonne(Board, C, ColonneAJouer, P).
gagnable(Board, P, ColonneAJouer) :- between(0, 5, L), gagnableLigne(L, Board, P, ColonneAJouer).
gagnable(Board, P, ColonneAJouer) :- between(3, 5, L), between(0, 3, C), gagnableDiagonaleHB(L, C, Board, P, ColonneAJouer).
gagnable(Board, P, ColonneAJouer) :- between(0, 2, L), between(0, 3, C), gagnableDiagonaleBH(L, C, Board, P, ColonneAJouer).



% Basic IA that plays randomly in a non-full column
ia1(Board, RandCol, ElemIndex, _):-
    repeat, random(0,7,RandCol), firstFreeIndexColonne(Board, RandCol, ElemIndex), ElemIndex\==6, !.

ia2(Board, ColIndex, ElemIndex, Player):-
    copy_term(Board, BoardCopy),
    gagnable(BoardCopy, Player, ColIndex), % check if the AI can win in the next move
    firstFreeIndexColonne(Board, ColIndex, ElemIndex), ElemIndex\==6, !.

ia2(Board, ColIndex, ElemIndex, Player):-
    changePlayer(Player, Opponent),
    copy_term(Board, BoardCopy),
    gagnable(BoardCopy, Opponent, ColIndex), % check if the AI can block the opponent in the next move
    firstFreeIndexColonne(Board, ColIndex, ElemIndex), ElemIndex\==6, !.

% Basic IA that plays randomly in a non-full column and avoids allowing the opponent to win on their next turn
/*
% This works but if all moves allow the opponent to win, it will create an infinite loop.
ia2(Board, RandCol, ElemIndex, Player) :-
    repeat,
        random_between(0,6, RandCol), firstFreeIndexColonne(Board, RandCol, ElemIndex), ElemIndex \== 6,

        % appliqué le coup
        copy_term(Board, BoardCopy), playMove(BoardCopy, RandCol, ElemIndex, BoardAfterMove, Player),

        % vérifie si l'adversaire ne peut pas gagner au prochain tour
        changePlayer(Player, Opponent), \+ gagnable(BoardAfterMove, Opponent, _), 
    !.
*/
ia2(Board, RandCol, ElemIndex, Player) :-
    findall(C-I, % check each possible move (each colonne)
        ( % check that the colomn is not full and that the opponent doesnt win on their next turn if the move is played
            between(0,6,C),
            firstFreeIndexColonne(Board, C, I),
            I \== 6,
            copy_term(Board, Bcopy),
            playMove(Bcopy, C, I, Bafter, Player),
            otherPlayer(Player, Opponent),
            \+ gagnable(Bafter, Opponent, _)
        ), SafeMoves), % List all the move in a non-full column that avoids allowing the opponent to win on their next turn
    SafeMoves \= [],
    random_member(RandCol-ElemIndex, SafeMoves). % choose randomly among those
