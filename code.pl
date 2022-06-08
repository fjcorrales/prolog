:-module(_,_,[classic,assertions,regtypes]).
author_data('Corrales','Falco','Daniel','b190410').

%primera parte


                %1.1 -- Predicado pots
pots(0,_,[0]).
pots(1,_,[1]).
pots(_,0,[]).
pots(_,1,[1]).
pots(M,N,Ps):-
    1=<N,
    pots_aux(1,N,Ps,[1],M).

%llenado de la lista
pots_aux(M,N,Ps,PsAux,I):-
    M1 is M*I,
    M1 =< N, 
    pots_aux(M1,N,Ps,[M1|PsAux],I).

%condicion de parada
pots_aux(M,N,Ps,PsAux,I):-
    M1 is M*I,
    M1 >N, 
    Ps = PsAux.

                %1.2 -- Predicado mpart(M,N,P)




                %1.3 -- Predicado maria(M,N,NPart)


%segunda parte

                %2.1 -- Predicado guardar_grafo
:-dynamic(arista/2).

guardar_grafo(G):-
    abolish(arista/2),
    guardar_grafo_aux(G).

guardar_grafo_aux([]).
guardar_grafo_aux([X|G]):-
    assert(X),
    guardar_grafo_aux(G).
    
                %2.2 -- Predicado aranya
%aranya.