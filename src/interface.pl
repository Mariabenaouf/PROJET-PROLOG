:- module(ui, [start_menu/0, ia_turn_auto/1]).

:- use_module(library(pce)).

:- use_module(board).
:- use_module(game).
:- use_module(ai).
:- use_module(minimax).

:- dynamic current_player/1.
:- dynamic game_window/1.
:- dynamic game_mode/1.
:- dynamic ia_types/2.

/* Menu principal */
start_menu :-
    new(MenuWindow, dialog('PUISSANCE 4 - Menu')),
    send(MenuWindow, size, size(600, 505)),
    
    new(Btn1, button('Humain vs IA', 
                     message(@prolog, start_mode, 1, MenuWindow))),
    send(MenuWindow, append, Btn1),
    
    /*new(Btn2, button('IA Random vs IA Random', 
                     message(@prolog, start_mode, 2, MenuWindow))),
    send(MenuWindow, append, Btn2),
    
    new(Btn3, button('IA Random vs IA Minimax', 
                     message(@prolog, start_mode, 3, MenuWindow))),
    send(MenuWindow, append, Btn3),*/

    new(Btn5, button('Humain vs Humain', 
                     message(@prolog, start_mode, 2, MenuWindow))),
    send(MenuWindow, append, Btn5),

    
    send(MenuWindow, open_centered).

/* Démarrage selon le mode */
start_mode(1, MenuWindow) :-
    send(MenuWindow, destroy),
    retractall(game_mode(_)),
    assert(game_mode(human_vs_ia)),
    start_interface.

/*start_mode(2, MenuWindow) :-
    send(MenuWindow, destroy),
    retractall(game_mode(_)),
    retractall(ia_types(_, _)),
    assert(game_mode(ia_vs_ia)),
    assert(ia_types(random, random)),
    start_interface_ia_vs_ia.

start_mode(3, MenuWindow) :-
    send(MenuWindow, destroy),
    retractall(game_mode(_)),
    retractall(ia_types(_, _)),
    assert(game_mode(ia_vs_ia)),
    assert(ia_types(random, minimax)),
    start_interface_ia_vs_ia.*/

start_mode(2, MenuWindow) :-
    send(MenuWindow, destroy),
    retractall(game_mode(_)),
    assert(game_mode(human_vs_human)),
    start_interface_human_vs_human.

/* Démarre l'interface Humain vs IA */
start_interface :-
    board:init,
    retractall(current_player(_)),
    assert(current_player('x')),
    new(Window, dialog('PUISSANCE 4 - Humain vs IA')),
    send(Window, size, size(600, 505)),
    send(Window, background, colour('#0044FF')),
    retractall(game_window(_)),
    assert(game_window(Window)),
    draw_board(Window),
    send(Window, open).

/* Démarre l'interface IA vs IA */
start_interface_ia_vs_ia :-
    board:init,
    retractall(current_player(_)),
    assert(current_player('x')),
    new(Window, dialog('PUISSANCE 4 - IA vs IA')),
    send(Window, size, size(600, 505)),
    send(Window, background, colour('#0044FF')),
    retractall(game_window(_)),
    assert(game_window(Window)),
    draw_board(Window),
    send(Window, open),
    ia_turn_auto('x').

/* Démarre l'interface Humain vs Humain */
start_interface_human_vs_human :-
    board:init,
    retractall(current_player(_)),
    assert(current_player('x')),
    new(Window, dialog('PUISSANCE 4 - Humain vs Humain')),
    send(Window, size, size(600, 505)),
    send(Window, background, colour('#0044FF')),
    retractall(game_window(_)),
    assert(game_window(Window)),
    draw_board(Window),
    send(Window, open).

winner_window(Winner) :-
    new(WinDialog, dialog('Game Over')),
    (   Winner == x ->
        WinnerColor = 'Rouge'
    ;   Winner == o ->
        WinnerColor = 'Jaune'
    ;   WinnerColor = 'Aucun' % égalité
    ),
    format(string(Msg), 'Le gagnant est : ~w', [WinnerColor]),
    send(WinDialog, append, label(winner_label, Msg)),
    send(WinDialog, append, button(ok, message(WinDialog, destroy))),
    send(WinDialog, open_centered).


/* Dessine le plateau */
draw_board(Window) :-
    board:board(Board),
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
            % Ajouter le clic seulement en mode Humain vs IA
            ( ((game_mode(human_vs_ia)) ; (game_mode(human_vs_human))) ->
                send(Circle, recogniser,
                    click_gesture(left, '', single,
                        message(@prolog, cell_clicked, ColIndex)))
            ; true )
        )
    ).

cell_clicked(_) :-
    game:gameover(_), !.

/* Gestion du clic (Humain vs IA) */
cell_clicked(ColIndex) :-
    board:board(Board),
    board:firstFreeIndexColonne(Board, ColIndex, RowIndex),
    RowIndex \= 6,
    current_player(Player),
    game:playMove(Board, ColIndex, RowIndex, NewBoard, Player),
    board:applyIt(Board, NewBoard),
    draw_board_game,
    ( game:gameover(Winner) ->
        winner_window(Winner),
        format('Game over! Winner: ~w~n', [Winner]), !
    ;
        changePlayer(Player, NextPlayer),
        retractall(current_player(_)),
        assert(current_player(NextPlayer)),
        ( game_mode(human_vs_ia), NextPlayer == 'o' ->
            ia_turn
        ; true )

    ).

/* Redessine le plateau */
draw_board_game :-
    game_window(Window),
    send(Window, clear),
    draw_board(Window).

/* Tour de l'IA (Humain vs IA) */
ia_turn :-
    game:gameover(_), !.

ia_turn :-
    sleep(1),
    board:board(Board),
    game:selectIA(minimax, Board, Col, RowIndex, 'o'),
    game:playMove(Board, Col, RowIndex, NewBoard, 'o'),
    board:applyIt(Board, NewBoard),
    draw_board_game,
    ( game:gameover(Winner) ->
        format('Game over! Winner: ~w~n', [Winner]),
        winner_window(Winner), !
    ;
        retractall(current_player(_)),
        assert(current_player('x'))
    ).

/* Tour automatique (IA vs IA) */
ia_turn_auto(_) :-
    game:gameover(Winner), !,
    winner_window(Winner),
    format('Game over! Winner: ~w~n', [Winner]).

ia_turn_auto(Player) :-
    board:board(Board),
    ia_types(IA1, IA2),
    ( Player == 'x' -> IAType = IA1 ; IAType = IA2 ),
    game:selectIA(IAType, Board, Col, RowIndex, Player),
    game:playMove(Board, Col, RowIndex, NewBoard, Player),
    board:applyIt(Board, NewBoard),
    draw_board_game,
    changePlayer(Player, NextPlayer),
    retractall(current_player(_)),
    assert(current_player(NextPlayer)),
    
    ( game:gameover(_) ->
        true % Ne pas planifier de nouveau coup si la partie est terminée
    ;
        new(Timer, timer(0.5, message(@prolog, ia_turn_auto, NextPlayer))),
        send(Timer, start)
    ).


/* Changement de joueur */
changePlayer('x', 'o').
changePlayer('o', 'x').