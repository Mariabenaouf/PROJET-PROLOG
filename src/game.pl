/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* Main game loop */
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
play(_) :- gameover(Winner), !, write('Game is Over. Winner: '), writeln(Winner), displayBoard.
play(Player):-write('New turn for:'), writeln(Player),
        board(Board), % instanciate the board from the knowledge base
        displayBoard, % print it
        ia(Board, RandCol, ElemIndex, Player), % ask the AI for a move
        playMove(Board, RandCol, ElemIndex, NewBoard, Player), % Play the move
        applyIt(Board, NewBoard), % update board
        changePlayer(Player,NextPlayer), % Change the player
        play(NextPlayer). % next turn!
