%% NATURAL
nat(0).
nat(s(X)) :- nat(X).


%% MENOR O IGUAL
p_menorIgualQue(0,X) :- s(X)\=0.
p_menorIgualQue(s(X),s(Y)) :-
	p_menorIgualQue(X,Y).
menorIgualQue(X,Y) :-
    nat(X),
    nat(Y),
    p_menorIgualQue(X,Y).


% Actualmente no se usa suma. Se tendria que borrar
suma(0,X,X).
suma(s(X),Y,Z) :-
	suma(X,s(Y),Z).

% Se comprueba que X > Y. y se llama a p_resta (resta funcion privada)
p_resta(X,0,X).
p_resta(s(X),s(Y),Z) :-
	p_resta(X,Y,Z).
resta(X,Y,Z) :-
    nat(X),
    nat(Y),
    p_menorIgualQue(Y,X),
    p_resta(X,Y,Z).

%% PAR
par(0).
par(s(s(X))) :-
    par(X).


%% COLORES VALIDOS
color(a).
color(am).
color(r).
color(v).




%%%%%%%%%%%%%%%%%%%%%%%%%% ES TORRE %%%%%%%%%%%%%%%%%%%%%%%%%%
esPieza(ANCH,ALT,PROF,C) :-
    nat(ANCH),
    nat(ALT),
    nat(PROF),
    color(C).

puede_estar_encima_de(pieza(ANCH1,ALT1,PROF1,C1), pieza(ANCH2,ALT2,PROF2,C2)) :-
    esPieza(ANCH1,ALT1,PROF1,C1),
    esPieza(ANCH2,ALT2,PROF2,C2),
    menorIgualQue(ANCH1,ANCH2),
    menorIgualQue(PROF1,PROF2).

esTorre([pieza(ANC,ALT,PRO,C) | []]) :- esPieza(ANC,ALT,PRO,C).
esTorre([PIEZA1, PIEZA2 | X]) :-
    puede_estar_encima_de(PIEZA1,PIEZA2),
    esTorre([PIEZA2|X]).
%%%%%%%%%%%%%%%%%%%%%%%% FIN ES TORRE %%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%% ALTURA TORRE %%%%%%%%%%%%%%%%%%%%%%%%
esCero(0).

alturaTorre(P,N) :-
    nat(N),
    esTorre(P),
    alturaTorreRecursivo(P,N).

alturaTorreRecursivo([],N) :- esCero(N).
alturaTorreRecursivo([pieza(_,ALT,_,_)|P],N) :-
    resta(N,ALT,NTOTAL),
    alturaTorreRecursivo(P,NTOTAL).
%%%%%%%%%%%%%%%%%%%%%% FIN ALTURA TORRE %%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%% COLORES TORRE %%%%%%%%%%%%%%%%%%%%%%%
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




%%%%%%%%%%%%%%%%%%%% COLORES INCLUIDOS %%%%%%%%%%%%%%%%%%%
% TODO: Comprobar que ambas listas tengan la misma longitud
coloresIncluidos(TORRE1,TORRE2) :-
    esTorre(TORRE1),
    esTorre(TORRE2),
    coloresIncluidosRecursivo(TORRE1,TORRE2).

% Recorremos todos los elementos de TORRE1 y comprobamos por cada elemento si el color se encuentra en la lista llamada TORRE2
coloresIncluidosRecursivo([pieza(_,_,_,COLOR)|[]],TORRE2) :- colorEstaEnLista(COLOR,TORRE2).
coloresIncluidosRecursivo([pieza(_,_,_,COLOR)|TORRE1],TORRE2) :-
    format('~nCOLOR IN- ~w~n',[COLOR]),
    colorEstaEnLista(COLOR,TORRE2),
    coloresIncluidosRecursivo(TORRE1,TORRE2).

% Devuelve si COLOR1 se encuentra en la lista TORRE
% TODO comprobar que cuando COLOR1 sea igual a COLOR2, se pare la recursion
colorEstaEnLista(COLOR1,[COLOR2|[]]) :- COLOR1 \= COLOR2.
colorEstaEnLista(COLOR1,[pieza(_,_,_,COLOR2)|TORRE]) :-
    format('~nCOLORES- ~w -- ~w~n',[COLOR1,COLOR2]),
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
% TODO comprobar que es color valido
esEdificioPiramide([FILA|CONSTRUCCION]) :-
    contarAncho(FILA,0,N),
    esEdificioPiramideRecursivo(CONSTRUCCION, N).

esEdificioPiramideRecursivo(FILA, N1) :- 
    contarAncho(FILA,0,N2),
    menorIgualQue(N1,N2).

esEdificioPiramideRecursivo([FILA|CONSTRUCCION], N1) :-
    contarAncho(FILA,0,N2),
    menorIgualQue(N1,N2),
    esEdificioPiramideRecursivo(CONSTRUCCION,N2).

contarAncho([], N1, N2) :- contarAncho([],_,N1), N2. % SUMA
contarAncho([b|CONSTRUCCION],N, _):-    
    contarAncho(CONSTRUCCION,N, _).
contarAncho([_|CONSTRUCCION], N, _):-
    contarAncho(CONSTRUCCION, s(N), _).
%%%%%%%%%%%%%%%%%%%%%% FIN ES EDIFICIO PIRAMIDE %%%%%%%%%%%%%%%%%%%%%