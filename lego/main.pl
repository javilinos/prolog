% menor_o_igual_que(X,Y) --> X > Y
menor_o_igual_que(s(0),X) :- X\=0.		% min(0,X) = X
menor_o_igual_que(s(X),s(Y)) :-
	menor_o_igual_que(X,Y).
% Fin menor_o_igual_que

% Colores validos
color(a).
color(am).
color(r).
color(v).


% Comprueba si el numero es natual
nat(0).
nat(s(X)) :- nat(X).

esPieza(ANCHURA,ALTURA,PROFUNDIDAD,COLOR) :-
    nat(ANCHURA),
    nat(ALTURA),
    nat(PROFUNDIDAD),
    color(COLOR).


puede_estar_encima_de(pieza(ANCHURA1,ALTURA1,PROFUNDIDAD1,COLOR1), pieza(ANCHURA2,ALTURA2,PROFUNDIDAD2,COLOR2)) :-
    esPieza(ANCHURA1,ALTURA1,PROFUNDIDAD1,COLOR1),
    esPieza(ANCHURA1,ALTURA1,PROFUNDIDAD2,COLOR2),
    menor_o_igual_que(ANCHURA1,ANCHURA2),
    menor_o_igual_que(PROFUNDIDAD1,PROFUNDIDAD2).

% Separa la lista en dos partes.
% H(head), primer elemento
% T(tail), el resto de elementos
p([H|T], H, T).

esTorre([pieza(ANCHURA,ALTURA,PROFUNDIDAD,COLOR) | []]) :-
    esPieza(ANCHURA,ALTURA,PROFUNDIDAD,COLOR).

esTorre([PIEZA1 | X]) :-
    p(X,PIEZA2,_),
    puede_estar_encima_de(PIEZA1,PIEZA2),
    esTorre(X).