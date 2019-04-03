not(Var):- Var,!,fail.
not(Var).

% Version: v1
% Fecha: 2/4/19
% Autor: Maximo Garcia
% Añadir pruebas en: https://docs.google.com/document/d/1gCsyNYJ_Y2-m_SbsstWfKhFrNxrIFtevwOgXRBAAHeY/edit?usp=sharing

% ATENCION: testColoresIncluidos() NO ESTA COMPROBADA. ES POSIBLE QUE EXISTAN ERRORES
% EL RESTO DE testing CREO QUE ESTA BIEN

% EJECUCION
% 1. Seguir los pasos de PREPARACION
% 2. En la consola de prolog ejecutar:
%       [main],[test],test(_).
% *Consideraciones:
%   - Cambiar el nombre de main al nombre de programa.
%       Por ejemplo, si el archivo se llama practica.pl; cambiar [main]. => [practica].
%   - Guardar este mismo archivo con cualquier nombre. Tener en cuenta que si yo lo llamo
%     test.pl, tendre que ejecutar [test] para compilar.
%   - Al compilar este archivo, salen WARNINGS. No pasa nada, se puede obviar.
%     Esto se debe a que busca el nombre de la funcion esTorre,coloresIncluidos... en este
%     mismo archivo pero no lo encuentra. Por eso compilamos nuestro programa principal antes.

% PREPARACION
% 1. Comentar aquellos test que no se quieran aplicar. Se comenta poniendo un % delante
test(_) :-
    testNat(_),
    testMenorIgualQue(_),
    testSuma(_),
    testResta(_),
    testPar(_),
    testColor(_),
    testEsTorre(_),
    testAlturaTorre(_),
    testColoresTorre(_),
    testColoresIncluidos(_),
    format('TODO OK! ~n').


assert(D,C) :-
    format('   |  Test ~w',[D]),
    C,
    format('             |  OK                    |~n',[]).

tNat(A) :- nat(A).
testNat(_) :-
    format('~n   ------------------ TEST NAT ------------------~n',[]),
    assert(1,tNat(0)),             
    assert(2,tNat(s(0))),
    assert(3,tNat(s(s(s(s(0)))))),
    assert(4,not(tNat(t))),
    format('   ------------------------------------------------~n',[]).


tMenorIgualQue(A,B) :- menorIgualQue(A,B).
testMenorIgualQue(_) :-
    format('~n   --------------TEST MENOR IGUAL QUE--------------~n',[]),
    assert(1,tMenorIgualQue(s(0),s(0))),             
    assert(2,tMenorIgualQue(s(s(0)),s(s(0)))),
    assert(3,tMenorIgualQue(s(0),s(s(0)))),
    assert(4,tMenorIgualQue(s(0),s(s(s(0))))),
    assert(5,not(tMenorIgualQue(s(s(0)),s(0)))),
    assert(6,not(tMenorIgualQue(s(s(s(0))), s(0)))),
    assert(7,not(tMenorIgualQue(t,0))),
    assert(8,not(tMenorIgualQue(0,t))),
    assert(9,not(tMenorIgualQue(t,t))),
    format('   ------------------------------------------------~n',[]).

tSuma(A,B,C) :- suma(A,B,C).
testSuma(_) :-
    format('~n   ------------------TEST SUMA ------------------~n',[]),
    assert(1,tSuma(0,0,0)),             
    assert(2,tSuma(s(0),0,s(0))),             
    assert(3,tSuma(0,s(0),s(0))),             
    assert(4,tSuma(s(0),s(0),s(s(0)))),             
    assert(5,tSuma(s(0),s(s(0)),s(s(s(0))))),
    assert(6,tSuma(s(s(0)),s(0),s(s(s(0))))),
    assert(7,tSuma(s(s(0)),s(s(0)), s(s(s(s(0)))))),
    assert(8,tSuma(s(s(0)),s(s(s(s(0)))), s(s(s(s(s(s(0)))))))),
    assert(9,not(tSuma(0,0,s(0)))),
    assert(10,not(tSuma(s(0),0,s(s(0))))),
    assert(11,not(tSuma(0,s(0),s(s(s(0)))))),
    assert(12,not(tSuma(s(0),s(0),s(s(s(s(0))))))),     
    assert(13,not(tSuma(s(0),s(s(0)),s(0)))),
    assert(14,not(tSuma(s(s(0)),s(0),s(s(0))))),
    assert(15,not(tSuma(s(s(0)),s(s(0)), s(0)))),
    assert(16,not(tSuma(s(s(0)),s(s(s(s(0)))), s(s(s(s(0))))))),
    assert(17,not(tSuma(s(s(0)),s(0),0))),
    assert(18,not(tSuma(s(s(s(0))),0,s(0)))),
    assert(19,not(tSuma(t,0,0))),
    assert(20,not(tSuma(0,t,s(0)))),
    assert(21,not(tSuma(t,t,0))),
    assert(22,not(tSuma(s(0),0,t))),             
    assert(23,not(tSuma(s(0),t,t))),
    format('   ------------------------------------------------~n',[]).

tResta(A,B,C) :- resta(A,B,C).
testResta(_) :-
    format('~n   ---------------- TEST RESTA ------------------~n',[]),
    assert(1,tSuma(0,0,0)),             
    assert(2,tResta(s(0),0,s(0))),             
    assert(4,tResta(s(0),s(0),0)),             
    assert(4,tResta(s(s(s(s(0)))),s(s(s(s(0)))),0)),             
    assert(5,tResta(s(s(0)),s(0),s(0))),
    assert(7,tResta(s(s(s(s(0)))),s(s(0)),s(s(0)))),
    assert(8,tResta(s(s(s(s(s(s(0)))))),s(s(0)),s(s(s(s(0)))))),
    assert(6,not(tResta(s(s(0)),s(0),s(s(s(0)))))),
    assert(3,not(tResta(0,s(0),s(0)))),        
    assert(9,not(tResta(0,0,s(0)))),
    assert(10,not(tResta(s(0),0,s(s(0))))),
    assert(11,not(tResta(0,s(0),s(s(s(0)))))),
    assert(12,not(tResta(s(0),s(0),s(s(s(s(0))))))),     
    assert(13,not(tResta(s(0),s(s(0)),s(0)))),
    assert(14,not(tResta(s(s(0)),s(0),s(s(0))))),
    assert(15,not(tResta(s(s(0)),s(s(0)), s(0)))),
    assert(16,not(tResta(s(s(0)),s(s(s(s(0)))), s(s(s(s(0))))))),
    assert(17,not(tResta(s(s(0)),s(0),0))),
    assert(18,not(tResta(s(s(s(0))),0,s(0)))),
    assert(19,not(tResta(t,0,0))),
    assert(20,not(tResta(0,t,s(0)))),
    assert(21,not(tResta(t,t,0))),
    assert(22,not(tResta(s(0),0,t))),             
    assert(23,not(tResta(s(0),t,t))),
    format('   ------------------------------------------------~n',[]).

tPar(A) :- par(A).
testPar(_) :-
    format('~n   ------------------ TEST PAR ------------------~n',[]),
    assert(1,tPar(      0)),             
    assert(2,tPar(      s(s(0)))),
    assert(3,tPar(      s(s(s(s(0)))))),
    assert(4,not(tPar(  s(0)))),
    assert(5,not(tPar(  s(s(s(0)))))),
    assert(6,not(tPar(  s(s(s(s(s(0)))))))),
    assert(6,not(tPar(  t))),
    assert(6,not(tPar([]))),
    assert(6,not(tPar([s(0)]))),
    assert(6,not(tPar([s(0),0,s(s(0))]))),
    format('   ------------------------------------------------~n',[]).

tColor(A) :- color(A).
testColor(_) :-
    format('~n   ------------------ TEST COLOR ------------------~n',[]),
    assert(1,tColor(r)),
    assert(2,tColor(v)),
    assert(3,tColor(am)),
    assert(4,tColor(a)),
    assert(5,not(tColor(t))),
    assert(6,not(tColor(0))),
    assert(7,not(tColor(s(0)))),
    assert(7,not(tColor([]))),
    assert(7,not(tColor([s(0),0,s(s(0))]))),
    format('   ------------------------------------------------~n',[]).

tEsTorre(A) :- esTorre(A).
testEsTorre(_):-
    format('~n   --------------- TEST ES TORRE ----------------~n',[]),
    assert(1,tEsTorre([pieza(s(0),s(s(0)),s(0),r)])),
    assert(1,tEsTorre([pieza(s(0),s(s(0)),s(0),r),pieza(s(0),s(0),s(0),a)])),
    assert(2,tEsTorre([pieza(s(0),s(0),s(s(0)),r),pieza(s(0),s(0),s(s(s(0))),a)])),
    assert(3,tEsTorre([pieza(s(0),s(0),s(s(0)),r),pieza(s(0),s(0),s(s(0)),a),pieza(s(0),s(0),s(s(s(0))),a)])),
    assert(4,tEsTorre([pieza(s(0),s(s(0)),s(0),am)])),
    assert(5,tEsTorre([pieza(s(0),s(s(0)),s(0),v)])),
    assert(6,tEsTorre([pieza(s(0),s(0),s(0),r),pieza(s(0),s(s(s(0))),s(0),a)])),
    assert(7,tEsTorre([pieza(s(0),s(0),s(0),r),pieza(s(0),s(s(0)),s(0),r),pieza(s(0),s(s(s(0))),s(0),r)])),
    assert(8,tEsTorre([pieza(s(0),s(0),s(0),r),pieza(s(0),s(s(0)),s(0),r),pieza(s(s(0)),s(s(0)),s(s(0)),v),pieza(s(s(s(0))),s(s(s(0))),s(s(s(0))),am)])),
    assert(9,tEsTorre([pieza(s(s(s(0))),s(s(s(0))),s(s(s(0))),am),pieza(s(s(s(0))),s(s(s(0))),s(s(s(0))),r),pieza(s(s(s(0))),s(s(s(0))),s(s(s(0))),v)])),
    assert(10,tEsTorre([pieza(s(0),s(0),s(0),am),pieza(s(0),s(s(0)),s(0),v),pieza(s(0),s(s(0)),s(s(0)),v),pieza(s(s(s(0))),s(s(s(0))),s(s(s(0))),am)])),
    assert(11,not(tEsTorre([pieza(s(s(0)),s(0),s(0),r),pieza(s(0),s(0),s(0),a)]))),
    assert(12,not(tEsTorre([pieza(s(0),s(0),s(s(0)),v),pieza(s(0),s(0),s(0),am)]))),
    assert(13,not(tEsTorre([pieza(s(0),s(0),s(s(0)),r),pieza(s(0),s(0),s(0),a)]))),
    assert(14,not(tEsTorre([pieza(s(s(0)),s(s(0)),s(s(0)),r),pieza(s(0),s(0),s(0),a)]))),
    assert(15,not(tEsTorre([s(s(s(s(0)))),pieza(s(0),s(0),r),pieza(s(0),s(0),s(0),a)]))),
    assert(16,not(tEsTorre([pieza(t,s(0),s(0),r),pieza(s(0),s(0),s(0),a)]))),
    assert(17,not(tEsTorre([pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),t,a)]))),
    assert(18,not(tEsTorre([pieza(s(s(s(0))),s(s(s(0))),s(s(s(0))),am),pieza(s(0),s(0),s(0),am),pieza(s(0),s(s(0)),s(0),v),pieza(s(0),s(s(0)),s(s(0)),v)]))),
    assert(19,not(tEsTorre([pieza(s(0),s(0),s(0),am),pieza(s(0),s(s(0)),s(0),v),pieza(s(s(s(0))),s(s(s(0))),s(s(s(0))),am),pieza(s(0),s(s(0)),s(s(0)),v)]))),
    assert(20,not(tEsTorre([pieza(s(0),s(0),s(0),t),pieza(s(0),s(0),s(0),a)]))),
    assert(21,not(tEsTorre([pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),t)]))),
    assert(22,not(tEsTorre([pieza(s(0),s(0),s(0),t)]))),
    format('   ------------------------------------------------~n',[]).

tAlturaTorre(A,B) :- alturaTorre(A,B).
testAlturaTorre(_):-
    format('~n   ------------- TEST ALTURA TORRE --------------~n',[]),
    assert(1,tAlturaTorre([pieza(s(0),s(0),s(0),r)],s(0))),
    assert(2,tAlturaTorre([pieza(s(0),s(s(0)),s(s(0)),r)],s(s(0)))),
    assert(3,tAlturaTorre([pieza(s(0),s(s(s(0))),s(0),r)],s(s(s(0))))),
    assert(4,tAlturaTorre([pieza(s(s(0)),s(0),s(0),r),pieza(s(s(0)),s(0),s(0),a)],s(s(0)))),
    assert(5,tAlturaTorre([pieza(s(0),s(0),s(0),r),pieza(s(s(0)),s(s(0)),s(0),a)],s(s(s(0))))),
    assert(6,tAlturaTorre([pieza(s(0),s(s(0)),s(0),r),pieza(s(s(0)),s(s(0)),s(0),a)],s(s(s(s(0)))))),
    assert(7,tAlturaTorre([pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),r)],s(s(s(0))))),
    assert(8,tAlturaTorre([pieza(s(0),s(0),s(0),r),pieza(s(0),s(s(0)),s(0),r),pieza(s(0),s(s(s(0))),s(0),r)],s(s(s(s(s(s(0)))))))),
    assert(9,tAlturaTorre([pieza(s(0),s(s(0)),s(0),r),pieza(s(0),s(s(0)),s(0),r),pieza(s(0),s(s(s(0))),s(0),r)],s(s(s(s(s(s(s(0))))))))),
    assert(10,not(tAlturaTorre([pieza(s(0),s(s(0)),s(0),r)],s(0)))),
    assert(11,not(tAlturaTorre([pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),a)],s(0)))),
    assert(12,not(tAlturaTorre([pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),a)],s(s(s(0)))))),
    assert(13,not(tAlturaTorre([pieza(s(0),s(0),s(0),t)],s(0)))),
    assert(14,not(tAlturaTorre([pieza(s(s(0)),s(0),s(0),r),pieza(s(0),s(0),s(0),a),pieza(s(s(0)),s(0),s(0),r),pieza(s(0),s(0),s(0),a)],s(s(0))))),
    assert(15,not(tAlturaTorre([pieza(s(s(0)),s(0),s(0),r),pieza(s(0),s(0),s(0),a),pieza(s(s(0)),s(0),s(0),r),pieza(s(0),s(0),s(0),a)],s(s(s(0)))))),
    assert(16,not(tAlturaTorre([pieza(s(s(0)),s(0),s(0),r),pieza(s(0),s(0),s(0),a),pieza(s(s(0)),s(0),s(0),r),pieza(s(0),s(0),s(0),a)],s(s(s(s(0))))))),
    assert(17,not(tAlturaTorre([pieza(s(0),s(0),s(0),r),pieza(s(0),s(s(0)),s(0),r),pieza(s(0),s(s(s(0))),s(0),r)],s(s(0))))),
    format('   ------------------------------------------------~n',[]).

tColoresTorre(A,B) :- coloresTorre(A,B).
testColoresTorre(_) :-
    format('~n   ------------- TEST COLORES TORRE -------------~n',[]),
    assert(1,tColoresTorre([pieza(s(0),s(0),s(0),r)],[r])),
    assert(2,tColoresTorre([pieza(s(0),s(0),s(0),r),pieza(s(0),s(s(0)),s(0),a)],[r,a])),
    assert(3,tColoresTorre([pieza(s(0),s(s(0)),s(0),am),pieza(s(0),s(0),s(0),r),pieza(s(0),s(s(0)),s(0),a)],[am,r,a])),
    assert(4,tColoresTorre([pieza(s(0),s(s(s(0))),s(s(0)),am),pieza(s(0),s(s(0)),s(s(0)),v),pieza(s(0),s(s(0)),s(s(0)),r),pieza(s(0),s(s(0)),s(s(s(0))),a)],[am,v,r,a])),
    assert(5,tColoresTorre([pieza(s(0),s(s(0)),s(0),am),pieza(s(0),s(s(0)),s(0),am),pieza(s(0),s(0),s(0),am),pieza(s(0),s(s(0)),s(0),am)],[am,am,am,am])),
    assert(6,not(tColoresTorre([pieza(s(s(0)),s(0),s(0),r),pieza(s(0),s(s(0)),s(0),r)],[r,r]))),
    assert(7,not(tColoresTorre([pieza(s(0),s(0),s(0),r),pieza(s(0),s(s(0)),s(0),t)],[r,t]))),
    assert(8,not(tColoresTorre([pieza(s(0),s(0),s(0),r),pieza(s(0),s(s(0)),s(0),t)],[r,t]))),
    assert(9,not(tColoresTorre([pieza(s(0),s(0),s(0),t),pieza(s(0),s(s(0)),s(0),t)],[r,t]))),
    assert(10,not(tColoresTorre([pieza(s(0),s(0),s(0),r),pieza(s(0),s(s(0)),s(0),t)],[r,r]))),
    assert(11,not(tColoresTorre([pieza(s(0),s(s(s(0))),s(s(0)),am),pieza(s(0),s(s(0)),s(s(0)),v),pieza(s(0),s(0),s(s(0)),r),pieza(s(0),s(s(0)),s(s(s(0))),a)],[a,r,am,v]))),
    assert(12,not(tColoresTorre([pieza(s(0),s(s(0)),s(0),am),pieza(s(0),s(s(0)),s(0),am),pieza(s(0),s(0),s(0),am),pieza(s(0),s(s(0)),s(0),am)],[am,r,am,am]))),
    assert(13,not(tColoresTorre([pieza(s(0),s(s(0)),s(0),am),pieza(s(0),s(s(0)),s(0),am),pieza(s(0),s(0),s(0),am),pieza(s(0),s(s(0)),s(0),am)],[am,t,am,am]))),
    assert(14,not(tColoresTorre([pieza(s(0),s(s(0)),s(0),am),pieza(s(0),s(s(0)),s(0),a),pieza(s(0),s(0),s(0),v),pieza(s(0),s(s(0)),s(0),r)],[am,t,r,am]))),
    assert(15,not(tColoresTorre([pieza(s(0),s(s(0)),s(0),v),pieza(s(0),s(s(0)),s(0),am),pieza(s(0),s(0),s(0),a),pieza(s(0),s(s(0)),s(0),am)],[am]))),
    assert(16,not(tColoresTorre([pieza(s(0),s(s(0)),s(0),v)],[]))),
    format('   ------------------------------------------------~n',[]).

tColoresIncluidos(A,B) :- coloresIncluidos(A,B).
testColoresIncluidos(_):-
    format('~n   ---------- TEST COLORES INCLUIDOS -----------~n',[]),
    assert(1,tColoresIncluidos([pieza(s(0),s(0),s(0),r)],[pieza(s(0),s(0),s(0),r)])),
    assert(2,tColoresIncluidos([pieza(s(0),s(0),s(0),r)],[pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),v),pieza(s(0),s(0),s(0),a)])),
    assert(3,tColoresIncluidos([pieza(s(0),s(0),s(0),r),pieza(s(s(0)),s(0),s(0),a)],[pieza(s(0),s(0),s(0),a),pieza(s(0),s(0),s(0),r)])),
    assert(4,tColoresIncluidos([pieza(s(0),s(0),s(0),a),pieza(s(0),s(0),s(0),a)],[pieza(s(s(0)),s(0),s(s(0)),a)])),
    assert(5,tColoresIncluidos([pieza(s(0),s(0),s(0),a),pieza(s(0),s(0),s(0),a),pieza(s(0),s(0),s(0),am)],[pieza(s(0),s(0),s(0),a),pieza(s(0),s(0),s(0),am)])),
    assert(6,tColoresIncluidos([pieza(s(0),s(0),s(0),a),pieza(s(0),s(0),s(0),v),pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),am)],[pieza(s(0),s(0),s(0),am),pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),v),pieza(s(0),s(0),s(0),a)])),
    assert(7,tColoresIncluidos([pieza(s(s(0)),s(0),s(0),r)],[pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),v),pieza(s(0),s(0),s(0),a)])),
    assert(8,not(tColoresIncluidos([pieza(s(s(0)),s(0),s(0),r),pieza(s(0),s(0),s(0),r)],[pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),v),pieza(s(0),s(0),s(0),a)]))),
    assert(9,not(tColoresIncluidos([pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),r)],[pieza(s(s(0)),s(0),s(0),r),pieza(s(0),s(0),s(0),v),pieza(s(0),s(0),s(0),a)]))), 
    assert(10,not(tColoresIncluidos([pieza(s(s(0)),s(0),s(0),r),pieza(s(0),s(0),s(0),r)],[pieza(s(s(0)),s(0),s(0),r),pieza(s(0),s(0),s(0),v),pieza(s(0),s(0),s(0),a)]))),
    assert(11,not(tColoresIncluidos([pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),r)],[pieza(s(0),s(0),s(0),v)]))),
    assert(12,not(tColoresIncluidos([pieza(s(0),s(0),s(0),a),pieza(s(0),s(0),s(0),v),pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),am)],[pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),v),pieza(s(0),s(0),s(0),a)]))),
    assert(13,not(tColoresIncluidos([pieza(s(0),s(0),s(0),a),pieza(s(0),s(0),s(0),v),pieza(s(0),s(0),s(0),r),pieza(s(0),s(0),s(0),am)],[pieza(s(0),s(0),s(0),r)]))),
    format('   ------------------------------------------------~n',[]).
