/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* Display the board */
/*--------------------------------------------------------------------------------------------------------------------------------------------------------*/

% Print the value of the board at index N (?, x or o) 
printVal(C, N) :- 
    board(B), nth0(C,B,Colonne), nth0(N,Colonne,Val),   % récupère l'élément à l'indice C,N
    var(Val), write('?'), write(' '), !.                % si c'est pas instancié, affiche '?' et ne fais pas la clause suivante

printVal(C, N) :- board(B), nth0(C,B,Colonne), nth0(N,Colonne,Val), write(Val), write(' '). %  récupère l'élément à l'indice C,N et l'affiche
   
printLigne(N) :- printVal(0,N), printVal(1,N), printVal(2,N), printVal(3,N), printVal(4,N), printVal(5,N), printVal(6,N), writeln('').

% Display the board
displayBoard :- 
    writeln('*---------------------*'),
    printLigne(5), printLigne(4), printLigne(3), printLigne(2), printLigne(1), printLigne(0), % affiche dans le sens inverse
    writeln('*---------------------*').
