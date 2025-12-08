/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* Main game loop */
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/

% Cas : fin du jeu
play(_) :-
    gameover(Winner), !,
    write('Game is Over. Winner: '), writeln(Winner),
    displayBoard.

% --- Tour du joueur humain ---
play(human) :-
    write('New turn for: human'), nl,
    board(Board),
    displayBoard,
    askHumanMove(Board, Col, ElemIndex),            % <<< NOUVEAU
    playMove(Board, Col, ElemIndex, NewBoard, 'x'), % humain joue 'x'
    applyIt(Board, NewBoard),
    play(ai).                                       % tour IA

% --- Tour IA ---
play(ai) :-
    write('New turn for: AI'), nl,
    board(Board),
    displayBoard,
    ia(Board, RandCol, ElemIndex, 'o'),             % IA joue 'o'
    playMove(Board, RandCol, ElemIndex, NewBoard, 'o'),
    applyIt(Board, NewBoard),
    play(human).                                     % retour à l'humain
