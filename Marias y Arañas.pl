:-module(_,_,[classic,assertions,regtypes]).
author_data('Corrales','Falco','Daniel','b190410').

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PREDICADOS AUXILIARES%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Parte 1

            %1.1
%llenado de la lista
pots_aux(M,N,Ps,PsAux,I):-
    M1 is M*I,
    M1 =< N, 
    pots_aux(M1,N,Ps,[M1|PsAux],I).

%condicion de parada
pots_aux(M,N,Ps,PsAux,I):-
    M1 is M*I,
    M1 > N, 
    Ps = PsAux.

            %1.2
mpart_aux(A,N,L) :-
     member(X,A),
     R is (N-X),
     R = 0,
     L = [X].
          
mpart_aux(A,N,L) :-
     member(X,A),
     R is (N-X),
     R > 0,
     mpart_aux(A,R,L1),
     L = [X | L1].
          
          
ordenada([]).
ordenada([_]).
ordenada(Ps) :-
     Ps = [A,B | Z],
     A >= B,
     ordenada([B|Z]).


%Parte 2
            %2.1
guardar_grafo_aux([]).
guardar_grafo_aux([X|G]):-
    assert(X),
    guardar_grafo_aux(G).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%PREDICADOS PRINCIPALES%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Parte 1


                %1.1 -- Predicado pots
pots(0,_,[0]).
pots(1,_,[1]).
pots(_,0,[]).
pots(_,1,[1]).
pots(M,N,Ps):-
    1=<N,
    pots_aux(1,N,Ps,[1],M).

                %1.2 -- Predicado mpart(M,N,P)
          
mpart(M,N,P):-
     pots(M,N,Ps),
     mpart_aux(Ps,N,P), 
     ordenada(P).

                %1.3 -- Predicado maria(M,N,NPart)
maria(M,N,NPart).

%segunda parte

                %2.1 -- Predicado guardar_grafo
:-dynamic(arista/2).

guardar_grafo(G):-
    abolish(arista/2),
    guardar_grafo_aux(G).

    
                %2.2 -- Predicado aranya
aranya.
%FIN
