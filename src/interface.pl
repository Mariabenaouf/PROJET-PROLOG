:- module(ui, [start_interface/0, cell_clicked/1]).

:- use_module(library(pce)).

:- use_module(board).
:- use_module(game).
:- use_module(ai).

:- dynamic current_player/1.
:- dynamic game_window/1.

/* Démarre l'interface */
start_interface :-
    board:init,                       % Initialise le plateau via module board
    retractall(current_player(_)),
    assert(current_player('x')),            % joueur 'x' commence
    new(Window, dialog('PUISSANCE 4')),
    send(Window, size, size(600, 505)),
    retractall(game_window(_)),
    assert(game_window(Window)),
    draw_board(Window),
    send(Window, open).

/* Dessine le plateau */
draw_board(Window) :-
    board:board(Board),
    send(Window, background, colour('#0044FF')),
    forall(between(0,6,Col),
        draw_column(Window, Col, Board)
    ).

draw_column(Window, ColIndex, Board) :-
    nth0(ColIndex, Board, Col),
    forall(
        between(0,5,Row),
        (
            nth0(Row, Col, Elem),
            X is ColIndex*85 + 30,
            Y is (5-Row)*85 + 30,
            ( var(Elem) -> Color = white
            ; Elem == x -> Color = red
            ; Elem == o -> Color = yellow
            ),
            new(Circle, ellipse(70,70)),
            send(Circle, fill_pattern, colour(Color)),
            send(Window, display, Circle, point(X-25,Y-25)),
            send(Circle, recogniser,
                click_gesture(left, '', single,
                    message(@prolog, cell_clicked,ColIndex)))

        )
    ).

cell_clicked(_) :-
    game:gameover(_), !.

/* Gestion du clic d'un joueur */
cell_clicked(ColIndex) :-
    board:board(Board),
    board:firstFreeIndexColonne(Board, ColIndex, RowIndex),
    RowIndex \= 6,
    current_player(Player),
    game:playMove(Board, ColIndex, RowIndex, NewBoard, Player),
    board:applyIt(Board, NewBoard),
    draw_board_game,
    ( game:gameover(Winner) ->
        format('Game over! Winner: ~w~n', [Winner]), !
    ;
        % changer de joueur
        changePlayer(Player, NextPlayer),
        retractall(current_player(_)),
        assert(current_player(NextPlayer)),
        (NextPlayer == 'o' -> ia_turn ; true)
    ).

% Redessine le plateau
draw_board_game :-
    game_window(Window),
    draw_board(Window).

/* Tour de l'IA */
ia_turn :-
    board:board(Board),
    ai:selectIA(random, Board, Col, RowIndex, 'o'),
    game:playMove(Board, Col, RowIndex, NewBoard, 'o'),
    board:applyIt(Board, NewBoard),
    ( game:gameover(Winner) ->
        format('Game over! Winner: ~w~n', [Winner])
    ;
        retractall(current_player(_)),
        assert(current_player('x')),
        draw_board_game
    ).

% Changement de joueur
changePlayer('x', 'o').
changePlayer('o', 'x').

