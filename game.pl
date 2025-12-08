play(_) :-
    gameover(Winner), !,
    write('Game is Over. Winner: '), writeln(Winner),
    displayBoard.

play(Player) :-
    write('New turn for:'), writeln(Player),
    board(Board),
    displayBoard,
    ia(Board, RandCol, ElemIndex, Player),
    playMove(Board, RandCol, ElemIndex, NewBoard, Player),
    applyIt(Board, NewBoard),
    changePlayer(Player,NextPlayer),
    play(NextPlayer).
