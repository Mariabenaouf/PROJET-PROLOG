:- use_module(library(pce)).

:- dynamic current_player/1.
:- dynamic game_window/1.

% Démarre l'interface
start_interface :-
    init_board,                             % Initialise le plateau
    retractall(current_player(_)),          % Supprime tout ancien joueur actif
    assert(current_player('x')),            % joueur 'x' commence
    new(Window, dialog('PUISSANCE 4')),     % Création de la fenêtre
    send(Window, size, size(500,400)),      % Taille de la fenêtre
    retractall(game_window(_)),             
    assert(game_window(Window)),            % Garde la fenêtre créée en mémoire
    draw_board(Window),                     % Dessine le plateau initial dans la fenêtre
    send(Window, open).                     % Affiche la fenêtre

% Initialise le plateau
init_board :-
    retractall(board(_)),
    length(Col1,6), length(Col2,6), length(Col3,6),
    length(Col4,6), length(Col5,6), length(Col6,6), length(Col7,6),
    Board = [Col1,Col2,Col3,Col4,Col5,Col6,Col7],
    assert(board(Board)).                   % Stocke le plateau

% Dessine le plateau
draw_board(Window) :-
    board(Board),
    send(Window, size, size(600, 505)),       % largeur x hauteur
    send(Window, position, point(200, 200)),  % position écran
    send(Window, background, colour('#0044FF')), % couleur de fond
    forall(between(0,6,Col),
        draw_column(Window, Col, Board)
    ).

draw_column(Window, ColIndex, Board) :-
    nth0(ColIndex, Board, Col),
    forall(between(0,5,Row),
        (
            nth0(Row, Col, Elem),
            X is ColIndex*85 + 30,
            Y is (5-Row)*85 + 30,
            ( var(Elem) -> 
                Color = white
            ; Elem == x ->
                Color = red
            ; Elem == o ->
                Color = yellow
            ),
            new(Circle, ellipse(70,70)),       % cercle de 50x50 pixels
            send(Circle, fill_pattern, colour(Color)),
            send(Window, display, Circle, point(X-25,Y-25)), % -25 pour centrer
            send(Circle, recogniser, click_gesture(left, '', single,
                        message(@prolog, cell_clicked, ColIndex)))
        )
    ).

% Gestion du clic d'un joueur
cell_clicked(ColIndex) :-
    board(Board),
    firstFreeIndexColonne(Board, ColIndex, RowIndex),
    RowIndex \= 6,                         % colonne non pleine
    current_player(Player),
    playMove(Board, ColIndex, RowIndex, NewBoard, Player),
    applyIt(Board, NewBoard),
    ( gameover(Winner) ->
        write('Game over! Winner: '), writeln(Winner)
    ;
        % changer de joueur
        changePlayer(Player, NextPlayer),
        retractall(current_player(_)),
        assert(current_player(NextPlayer)),
        draw_board_game,                  % redraw
        % si c'est le tour de l'IA
        (NextPlayer == 'o' -> ia_turn ; true)
    ).

% Redessine le plateau
draw_board_game :-
    game_window(Window),
    draw_board(Window).

% Tour de l'IA (ici 'o')
ia_turn :-
    board(Board),
    selectIA(random, Board, Col, RowIndex, 'o'),   % ou minimax
    playMove(Board, Col, RowIndex, NewBoard, 'o'),
    applyIt(Board, NewBoard),
    ( gameover(Winner) ->
        write('Game over! Winner: '), writeln(Winner)
    ;
        % retour au joueur humain
        retractall(current_player(_)),
        assert(current_player('x')),
        draw_board_game
    ).
