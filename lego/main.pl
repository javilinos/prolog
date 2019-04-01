menor_o_igual_que(s(0),X) :- X\=0.		% min(0,X) = X
menor_o_igual_que(s(X),s(Y)) :-
	menor_o_igual_que(X,Y).

mayor_o_igual_que(X,s(0)) :- X\=0.		% min(0,X) = X
mayor_o_igual_que(s(X),s(Y)) :-
	mayor_o_igual_que(X,Y).


% suma(X,Y,Z)/3 --> Z = X+Y
suma(0,X,X).  			% 0+X = X
suma(s(X),Y,Z) :-	% x+1+y=z+1
	suma(X,s(Y),Z).


% multiplicar(X,Y,Z)/3 --> Z=X*Y
multiplicar(0,X,0) :- nat(X).          % 0*X=0
multiplicar(s(X),Y,Z) :-               % (X+1)*Y=(X*Y)+Y
	multiplicar(X,Y,A),
	suma(A,Y,Z).


% par
par(0).
par(s(s(X))) :-
    par(X).

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
    esPieza(ANCHURA2,ALTURA2,PROFUNDIDAD2,COLOR2),
    menor_o_igual_que(ANCHURA1,ANCHURA2),
    menor_o_igual_que(PROFUNDIDAD1,PROFUNDIDAD2).

% Separa la lista en dos partes.
% H(head), primer elemento
% T(tail), el resto de elementos
p([H|T], H, T).

esTorre([pieza(ANCHURA,ALTURA,PROFUNDIDAD,COLOR) | []]) :-
    esPieza(ANCHURA,ALTURA,PROFUNDIDAD,COLOR).

esTorre([PIEZA1, PIEZA2 | X]) :-
    format('~s ~s ~s ~n', [PIEZA1, PIEZA2, X]),
    puede_estar_encima_de(PIEZA1,PIEZA2),
    esTorre([PIEZA2,X]).


%% ALTURA TORRE %%
esCero(0).

alturaTorre(P,N) :-
    nat(N),
    alturaTorreRecursivo(P,N).

alturaTorreRecursivo(P,s(N)) :-
    p(P,_,PP),
    alturaTorreRecursivo(PP,N).

alturaTorreRecursivo([],N) :-
    esCero(N).
%% FIN ALTURA TORRE %%


%% COLORES TORRE %%
%coloresTorre(CONTRUCCION,COLORES) :-
%    esTorre(CONTRUCCION).

%esColor([X  ]) :-

%% FIN COLORES TORRE %%


%%%%%%%%%%%%%%%%%%%%%%%%%% ES EDIFICIO PAR %%%%%%%%%%%%%%%%%%%%%%%%%%
esEdificioPar(CONSTRUCCION) :-
    esEdificioParRecursivo(CONSTRUCCION).

% RECURSION FILAS
esEdificioParRecursivo([H|T]) :-
    % Le pasamos la primera fila (que tambien es una lista)
    contarClavos(H,0),

    % Volvemos a ejecutar esta lista sin el primer elemento
    esEdificioParRecursivo(T).

% Caso base para la recursion de filas
esEdificioParRecursivo([]). 


% RECURSION COLUMNAS
contarClavos([b|T],N) :-
    contarClavos(T,N).

contarClavos([_|T],N) :-
    contarClavos(T,s(N)).
    
% Caso base para la recursion de columnas
contarClavos([],N) :-
    % Comprobamos si es par
    par(N).

%%%%%%%%%%%%%%%%%%%%%%%% FIN ES EDIFICIO PAR %%%%%%%%%%%%%%%%%%%%%%%%


