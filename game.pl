:- dynamic mode/1.
% Le mode de jeu est stocké dynamiquement :
%  - human_ai : Humain contre IA
%  - ai_ai    : IA contre IA


start :-
    init,   % Initialisation du plateau de jeu
    write('Mode de jeu ? (1: Humain vs IA, 2: IA vs IA) : '),
    read(Choice),          % Lecture du choix de l'utilisateur
    set_mode(Choice),      % Enregistrement du mode choisi
    play(ai).              % L’IA commence toujours la partie


% Mode 1 : Humain contre IA
set_mode(1) :-
    retractall(mode(_)),   % On nettoie l’ancien mode s’il existe
    assert(mode(human_ai)).

% Mode 2 : IA contre IA
set_mode(2) :-
    retractall(mode(_)),
    assert(mode(ai_ai)).

% Cas d’erreur : choix invalide
set_mode(_) :-
    writeln('Choix invalide.'),
    start.                 % On redemande le choix à l’utilisateur


% Cas d’arrêt : la partie est terminée (victoire ou match nul)
play(_) :-
    gameover(Winner), !,
    write('Game is Over. Winner: '),
    writeln(Winner),
    displayBoard.


/*----------------------- Tour Humain ---------------------------*/

% Le tour humain (existe dans le mode Humain vs IA)
play(human) :-
    mode(human_ai),
    write('New turn for: human'), nl,
    board(Board),
    displayBoard,
    askHumanMove(Board, Col, ElemIndex),   
    playMove(Board, Col, ElemIndex, NewBoard, 'x'),
    applyIt(Board, NewBoard),              
    play(ai).                              % Passage au tour de l’IA


/*------------------------- Tour IA ------------------------------*/

play(ai) :-
    write('New turn for: AI'), nl,
    board(Board),
    displayBoard,
    ia(Board, Col, ElemIndex, 'o'),         % Calcul du coup de l’IA
    playMove(Board, Col, ElemIndex, NewBoard, 'o'),
    applyIt(Board, NewBoard),
    next_after_ai.                          % Décide qui joue ensuite

/* Gestion du tour suivant après une IA */
% En mode Humain vs IA, l’IA laisse la main à l’humain
next_after_ai :-
    mode(human_ai), !,
    play(human).

% En mode IA vs IA, l’IA rejoue directement
next_after_ai :-
    mode(ai_ai),
    play(ai).
