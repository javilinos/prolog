%% MENOR O IGUAL
menorIgualQue(s(0),X) :- X\=0.
menorIgualQue(s(X),s(Y)) :-
	menorIgualQue(X,Y).

%% SUMA
suma(0,X,X).  			
suma(s(X),Y,Z) :-
	suma(X,s(Y),Z).
1

%% MULTIPLICAR
multiplicar(0,X,0) :- nat(X).
multiplicar(s(X),Y,Z) :-
	multiplicar(X,Y,A),
	suma(A,Y,Z).


%% PAR
par(0).
par(s(s(X))) :-
    par(X).


%% COLORES VALIDOS
color(a).
color(am).
color(r).
color(v).


%% NATURAL
nat(0).
nat(s(X)) :- nat(X).




%%%%%%%%%%%%%%%%%%%%%%%%%% ES TORRE %%%%%%%%%%%%%%%%%%%%%%%%%%
esPieza(ANCHURA,ALTURA,PROFUNDIDAD,COLOR) :-
    nat(ANCHURA),
    nat(ALTURA),
    nat(PROFUNDIDAD),
    color(COLOR).

puede_estar_encima_de(pieza(ANC1,ALT1,PRO1,C1), pieza(ANC2,ALT2,PRO2,C2)) :-
    esPieza(ANC1,ALT1,PRO1,C1),
    esPieza(ANC2,ALT2,PRO2,C2),
    menorIgualQue(ANC1,ANC2),
    menorIgualQue(PRO1,PRO2).

esTorre([pieza(ANC,ALT,PRO,C) | []]) :- esPieza(ANC,ALT,PRO,C).
esTorre([PIEZA1, PIEZA2 | X]) :-
    puede_estar_encima_de(PIEZA1,PIEZA2),
    esTorre([PIEZA2,X]).
%%%%%%%%%%%%%%%%%%%%%%%% FIN ES TORRE %%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%% ALTURA TORRE %%%%%%%%%%%%%%%%%%%%%%%%
esCero(0).

alturaTorre(P,N) :-
    nat(N),
    alturaTorreRecursivo(P,N).

alturaTorreRecursivo([],N) :- esCero(N).
alturaTorreRecursivo([_|P],s(N)) :-
    alturaTorreRecursivo(P,N).
%%%%%%%%%%%%%%%%%%%%%% FIN ALTURA TORRE %%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%% COLORES TORRE %%%%%%%%%%%%%%%%%%%%%%%
% TODO: Comprobar que ambas listas tengan la misma longitud
coloresTorre(TORRE,COLORES) :-
    esTorre(TORRE),
    comprobarListaColores(COLORES),
    coloresTorreRecursivo(TORRE,COLORES).

comprobarListaColores([COLOR|[]]) :- color(COLOR).
comprobarListaColores([COLOR|COLORES]) :-
    color(COLOR),
    comprobarListaColores(COLORES).

coloresTorreRecursivo([pieza(_,_,_,COLOR1)|[]],[COLOR2|[]]) :- COLOR1 = COLOR2.
coloresTorreRecursivo([pieza(_,_,_,COLOR1)|COLORES_TORRE],[COLOR2|COLORES]) :-
    COLOR1 = COLOR2,
    coloresTorreRecursivo(COLORES_TORRE,COLORES).
%%%%%%%%%%%%%%%%%%%%%% FIN COLORES TORRE %%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%% FIN COLORES INCLUIDOS %%%%%%%%%%%%%%%%%%%
% TODO: Comprobar que ambas listas tengan la misma longitud
coloresIncluidos(TORRE1,TORRE2) :-
    esTorre(TORRE1),
    esTorre(TORRE2),
    coloresIncluidosRecursivo(TORRE1,TORRE2).

% Recorremos todos los elementos de TORRE1 y comprobamos por cada elemento si el color se encuentra en la lista llamada TORRE2
coloresIncluidosRecursivo([pieza(_,_,_,COLOR)|[]],TORRE2) :- colorEstaEnLista(COLOR,TORRE2).
coloresIncluidosRecursivo([pieza(_,_,_,COLOR)|TORRE1],TORRE2) :-
    colorEstaEnLista(COLOR,TORRE2),
    coloresIncluidosRecursivo(TORRE1,TORRE2).

% Devuelve si COLOR1 se encuentra en la lista TORRE
colorEstaEnLista(COLOR1,[COLOR2|[]]) :- COLOR1 = COLOR2.
colorEstaEnLista(COLOR1,[COLOR2|TORRE]) :-
    COLOR1 = COLOR2,
    colorEstaEnLista(COLOR1,TORRE).
%%%%%%%%%%%%%%%%%%%% FIN COLORES INCLUIDOS %%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%% ES EDIFICIO PAR %%%%%%%%%%%%%%%%%%%%%%%%%%
% Llamada principal
esEdificioPar(CONSTRUCCION) :-
    esEdificioParRecursivo(CONSTRUCCION).

% Recursion filas
esEdificioParRecursivo([]). 
esEdificioParRecursivo([H|T]) :-
    contarClavos(H,0),
    esEdificioParRecursivo(T).

% Recursion columnas
contarClavos([],N) :- par(N).
contarClavos([b|T],N) :-
    contarClavos(T,N).
contarClavos([_|T],N) :-
    contarClavos(T,s(N)).

%%%%%%%%%%%%%%%%%%%%%%%% FIN ES EDIFICIO PAR %%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%% ES EDIFICIO PIRAMIDE %%%%%%%%%%%%%%%%%%%%%%%
%esEdificioPiramide/1 (esEdificioPiramide(Construccion): predicado que
%verifica si Construccion es un edificio que cumple que cada nivel tiene
%ancho estrictamente mayor que el nivel de arriba.
esEdificioPiramide([H|CONSTRUCCION]) :-
    contarAncho(H,N),
    esEdificioPiramideRecursivo(CONSTRUCCION, N).
esEdificioPiramideRecursivo([FILA|CONSTRUCCION], N_ANTERIOR) :- contarAncho(FILA,_,N_ANTERIOR).
esEdificioPiramideRecursivo([FILA|CONSTRUCCION], N_ANTERIOR) :-
    contarAncho(FILA,N_ACTUAL,N_ANTERIOR),
    esEdificioPiramideRecursivo(CONSTRUCCION,N2).

contarAncho([_|[]], N1, N2) :- menorIgualQue(N1,N2).
%contarAncho([b|CONSTRUCCION],N1, N2):-      <-- si se tiene en cuenta b de vacio
%    contarAncho(CONSTRUCCION,N1, N2).       <-- "     "        "            "
contarAncho([_|CONSTRUCCION], N1, N2):-
    contarAncho(CONSTRUCCION, s(N1), N2).
%%%%%%%%%%%%%%%%%%%%%% FIN ES EDIFICIO PIRAMIDE %%%%%%%%%%%%%%%%%%%%%

