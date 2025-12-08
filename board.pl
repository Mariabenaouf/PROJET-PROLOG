:- dynamic board/1. % permet l'assertion et le retrait de faits board/1

applyIt(Board,NewBoard):-retract(board(Board)), assert(board(NewBoard)).

%%%%% Start the game!
init :-
    retractall(board(_)),
    length(Col1,6),
    length(Col2,6),
    length(Col3,6),
    length(Col4,6),
    length(Col5,6),
    length(Col6,6),
    length(Col7,6),
    Board = [Col1,Col2,Col3,Col4,Col5,Col6,Col7],
    assert(board(Board)),
    play('x'), !.
