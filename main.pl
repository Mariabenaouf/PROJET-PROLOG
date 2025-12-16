:- use_module(src/game).
:- use_module(src/board).
:- use_module(src/display).
:- use_module(src/rules).
:- use_module(src/winner).
:- use_module(src/ai).
:- use_module(src/minimax).
:- use_module(src/interface).

%%%%% Start the game!
:- initialization(ui:start_interface).
