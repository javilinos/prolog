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
p_suma(0,X,X).
p_suma(s(X),Y,Z) :-
	p_suma(X,s(Y),Z).
suma(X,Y,Z) :-
    nat(X),
    nat(Y),
    nat(Z),
    p_suma(X,Y,Z).


% Se comprueba que X > Y. y se llama a p_resta (resta funcion privada)
p_resta(X,0,X).
p_resta(s(X),s(Y),Z) :-
	p_resta(X,Y,Z).
resta(X,Y,Z) :-
    nat(X),
    nat(Y),
    p_menorIgualQue(Y,X),
    nat(Z),
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


% IGUAL QUE
igualQue(N1,N2) :- 
    nat(N1),
    nat(N2),
    N1=N2.


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
esCero(X) :- X=0.
alturaTorre(P,N) :-
    esTorre(P),
    nat(N),
    alturaTorreRecursivo(P,N).

alturaTorreRecursivo([],0).
alturaTorreRecursivo([],_) :- 0\=0.
alturaTorreRecursivo(_,0) :- 0\=0.
alturaTorreRecursivo([pieza(_,ALT,_,_)|P],N) :-
    format('~n~n JAJA ~w ~w ~n KKK ~w ~n',[N, ALT, P]),
    resta(N,ALT,NTOTAL),
    format('LOL ~w ~w ~n',[NTOTAL, P]),
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




%%%%%%%%%%%%%%%%%%% CONTAR ANCHO SIN ESPACIOS %%%%%%%%%%%%%%%%%
contarCeldasSinBlanco([], N1, N2) :- suma(N1,0,N2).
contarCeldasSinBlanco([b|CONSTRUCCION],N, _):-    
    contarCeldasSinBlanco(CONSTRUCCION,N, _).
contarCeldasSinBlanco([_|CONSTRUCCION], N, _):-
    contarCeldasSinBlanco(CONSTRUCCION, s(N), _).
%%%%%%%%%%%%%%%%%% FIN CONTAR ANCHO SIN ESPACIOS %%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%% CONTAR ANCHO CON ESPACIOS %%%%%%%%%%%%%%%%%
contarCeldasConBlanco([], N1, N2) :- suma(N1,0,N2).
contarCeldasConBlanco([_|CONSTRUCCION], N, _):-
    contarCeldasConBlanco(CONSTRUCCION, s(N), _).
%%%%%%%%%%%%%%%%%% FIN CONTAR ANCHO CON ESPACIOS %%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%% ES EDIFICIO %%%%%%%%%%%%%%%%%%%%%%%%%%
esEdificioRecursividad([FILA | []],N1) :-
    contarCeldasConBlanco(FILA,0,N2),
    igualQue(N1,N2).
esEdificioRecursividad([FILA | CONSTRUCCION],N1) :-
    contarCeldasConBlanco(FILA,0,N2),
    igualQue(N1,N2),
    esEdificioRecursividad(CONSTRUCCION,N1).
    
esEdificio([FILA | CONSTRUCCION]) :-
    contarCeldasConBlanco(FILA,0,N),
    esEdificioRecursividad(CONSTRUCCION,N).
%%%%%%%%%%%%%%%%%%%%%%%% FIN ES EDIFICIO %%%%%%%%%%%%%%%%%%%%%%%%




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
    contarCeldasSinBlanco(FILA,0,N),
    esEdificioPiramideRecursivo(CONSTRUCCION, N).

esEdificioPiramideRecursivo(FILA, N1) :- 
    contarCeldasSinBlanco(FILA,0,N2),
    menorIgualQue(N1,N2).

esEdificioPiramideRecursivo([FILA|CONSTRUCCION], N1) :-
    contarCeldasSinBlanco(FILA,0,N2),
    menorIgualQue(N1,N2),
    esEdificioPiramideRecursivo(CONSTRUCCION,N2).
%%%%%%%%%%%%%%%%%%%%%% FIN ES EDIFICIO PIRAMIDE %%%%%%%%%%%%%%%%%%%%%