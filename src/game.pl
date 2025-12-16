:- module(game, [
    start/0,
    play/1,
    play2/3, 
    selectIA/5
]).

:- dynamic mode/1.

:- use_module(board).
:- use_module(display).
:- use_module(rules).
:- use_module(ai).
:- use_module(winner).
:- use_module(minimax).
start :-
    init,
    writeln('Choisissez le mode de jeu :'),
    writeln('1 - Humain vs IA'),
    writeln('2 - IA vs IA (IA Random)'),
    writeln('3 - IA vs IA (minimax vs random)'),
    read(Choice),
    start_mode(Choice).

start_mode(1) :-
    writeln('Mode : Humain vs IA'),
    play_human_ai.

start_mode(2) :-
    writeln('Mode : IA vs IA (IA Random)'),
    play('x').   % leur play/1 original

start_mode(3) :-
    writeln('Mode : IA vs IA (minimax vs random) '),
    play2('x', minimax, random).  % exemple, modifiable

start_mode(_) :-
    writeln('Choix invalide.'),
    start.
/* Humain VS IA*/
play_human_ai :-
    play_human_ai('x').

play_human_ai(_) :-
    gameover(Winner), !,
    write('Game Over. Winner: '), writeln(Winner),
    displayBoard.

play_human_ai('x') :-
    write('New turn for: human'), nl,
    board(Board),
    displayBoard,
    askHumanMove(Board, Col, ElemIndex),
    playMove(Board, Col, ElemIndex, NewBoard, 'x'),
    applyIt(Board, NewBoard),
    play_human_ai('o').

play_human_ai('o') :-
    write('New turn for: AI'), nl,
    board(Board),
    displayBoard,
    ia1(Board, Col, ElemIndex, 'o'),
    playMove(Board, Col, ElemIndex, NewBoard, 'o'),
    applyIt(Board, NewBoard),
    play_human_ai('x').
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
    ia1(Board, Col, ElemIndex, Player).

selectIA(minimax, Board, Col, ElemIndex, Player) :-
    ia_minimax(Board, Col, ElemIndex, Player).

ia_minimax(Board, ColIndex, ElemIndex, Player) :-
    ia_player(Player),
    minimax(0, Board, Player, ColIndex, _Utility),
    firstFreeIndexColonne(Board, ColIndex, ElemIndex).

/*Pour faire s'affronter deux IA*/

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
