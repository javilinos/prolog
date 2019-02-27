% 1
elimina(corleone, solozzo) :-
    controla(corleone, manhattan),
    controla(corleone, brooklyn).

% 2
elimina(solozzo, corleone) :-
    controla(solozzo, droga),
    apoya(roth, solozzo).

	     
elimina(corleone, solozzo) :-
    controla(corleone, manhattan),
    controla(corleone, brooklyn).

% 2
elimina(solozzo, corleone) :-
    controla(solozzo, droga),
    apoya(roth, solozzo).

% 4
apoya(roth, P) :-
    garantiza(P, roth).

% 4
apoya(roth, P) :-
    garantiza(P, roth).

% 3
controla(solozzo, bronx) :-
	apoya(roth, solozzo).

% 3
controla(solozzo, bronx) :-
    apoya(roth, solozzo).

controla(solozzo, harlme) :-
    apoya(roth, solozzo).

controla(corleone,manhattan) :-
    apoya(roth, corleone).

controla(corleone, brooklyn) :-
    apoya(roth, corleone).

% 6
controla(P, policia) :-
    controla(P, juego).

% 5
controla(solozzo, droga).

% 5
controla(corleone, juego).



controla(solozzo, harlme) :-
    apoya(roth, solozzo).

controla(corleone,manhattan) :-
    apoya(roth, corleone).

controla(corleone, brooklyn) :-
    apoya(roth, corleone).

% 5
controla(solozzo, droga).

% 5
controla(corleone, juego).

% 6
controla(P, policia) :-
    controla(P, juego).



% 7
garantiza(X, _) :-
    controla(X, policia).

% 7
% como Y no se usa, se puede poner garantiza(X, _) :-
garantiza(X, _) :-
    controla(X, policia).

% Preguntar quien elimina a quien: elimina(X, Y).