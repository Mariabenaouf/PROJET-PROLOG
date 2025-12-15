:- module(game, [
    play/1,
    play2/3
]).
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* Main game loop */
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
play(_) :- gameover(Winner), !, write('Game is Over. Winner: '), writeln(Winner), displayBoard.
play(Player):-write('New turn for:'), writeln(Player),
        board(Board), % instanciate the board from the knowledge base
        displayBoard, % print it
        ia2(Board, Col, ElemIndex, Player), % ask the AI for a move
        playMove(Board, Col, ElemIndex, NewBoard, Player), % Play the move
        applyIt(Board, NewBoard), % update board
        changePlayer(Player,NextPlayer), % Change the player
        play(NextPlayer). % next turn!



selectIA(random, Board, Col, ElemIndex, Player) :-
    ia2(Board, Col, ElemIndex, Player).

selectIA(minimax, Board, Col, ElemIndex, Player) :-
    ia_minimax(Board, Col, ElemIndex, Player).

ia_minimax(Board, ColIndex, ElemIndex, Player) :-
    ia_player(Player),
    minimax(0, Board, Player, ColIndex, _Utility),
    firstFreeIndexColonne(Board, ColIndex, ElemIndex).

%%%Pour faire s'affronter deux IA

play2(_, _, _) :- gameover(Winner), !,
    write('Game Over. Winner: '), writeln(Winner),
    displayBoard.

play2(Player, IAType, NextIAType) :-
    write('New turn for: '), writeln(Player), write('Using IA type: '), writeln(IAType),
    board(Board),
    displayBoard,
    selectIA(IAType, Board, Col, ElemIndex, Player),
    playMove(Board, Col, ElemIndex, NewBoard, Player),
    applyIt(Board, NewBoard),
    changePlayer(Player, NextPlayer),
    play2(NextPlayer, NextIAType, IAType).  % switch IA type for next turn
