:- module(_, _, [assertions, regtypes]).
author_data('Corrales', 'Falco', 'Daniel', 'B190410').

%Define a binary digit type.
bind(0).
bind(1).
%Define a binary byte as a list of 8 binary digits.
binary_byte([bind(B7),bind(B6),bind(B5),bind(B4),bind(B3),bind(B2),bind(B1),bind(B0)]):-
    bind(B7),
    bind(B6),
    bind(B5),
    bind(B4),
    bind(B3),
    bind(B2),
    bind(B1),
    bind(B0).

%Define a hex (nibble) type.
hexd(0).
hexd(1).
hexd(2).
hexd(3).
hexd(4).
hexd(5).
hexd(6).
hexd(7).
hexd(8).
hexd(9).
hexd(a).
hexd(b).
hexd(c).
hexd(d).
hexd(e).
hexd(f).

%Define a hex byte as a list of two hex nibbles
hex_byte([hexd(H1),hexd(H0)]):-
    hexd(H1),
    hexd(H0).

%Define a byte type either as a binary byte or as a hex type.
byte(BB):-
    binary_byte(BB).

byte(HB):-
    hex_byte(HB).


%   PREDICADOS AUXILIARES

/*
    Para el Predicado 2 voy a necesitar una base de hechos, ya que mi intencion y objetivo es comparar si un hexadecimal
    y un binario dados son equivalentes, para lo cual he de saber por que serie de 
    binds que forman un bit representan un nibble hexadecimal.
*/

hex_to_bin_byte([hexd(0)], [bind(0),bind(0),bind(0),bind(0)]). %el 0
hex_to_bin_byte([hexd(1)], [bind(0),bind(0),bind(0),bind(1)]). %el 1
hex_to_bin_byte([hexd(2)], [bind(0),bind(0),bind(1),bind(0)]). %el 2
hex_to_bin_byte([hexd(3)], [bind(0),bind(0),bind(1),bind(1)]). %el 3
hex_to_bin_byte([hexd(4)], [bind(0),bind(1),bind(0),bind(0)]). %el 4
hex_to_bin_byte([hexd(5)], [bind(0),bind(1),bind(0),bind(1)]). %el 5
hex_to_bin_byte([hexd(6)], [bind(0),bind(1),bind(1),bind(0)]). %el 6
hex_to_bin_byte([hexd(7)], [bind(0),bind(1),bind(1),bind(1)]). %el 7
hex_to_bin_byte([hexd(8)], [bind(1),bind(0),bind(0),bind(0)]). %el 8
hex_to_bin_byte([hexd(9)], [bind(1),bind(0),bind(0),bind(1)]). %el 9
hex_to_bin_byte([hexd(a)], [bind(1),bind(0),bind(1),bind(0)]). %el 10
hex_to_bin_byte([hexd(b)], [bind(1),bind(0),bind(1),bind(1)]). %el 11
hex_to_bin_byte([hexd(c)], [bind(1),bind(1),bind(0),bind(0)]). %el 12
hex_to_bin_byte([hexd(d)], [bind(1),bind(1),bind(0),bind(1)]). %el 13
hex_to_bin_byte([hexd(e)], [bind(1),bind(1),bind(1),bind(0)]). %el 14
hex_to_bin_byte([hexd(f)], [bind(1),bind(1),bind(1),bind(1)]). %el 15


/*
    Para el predicado 4 voy a necesitar invertir la lista para poder poner el byte menos significativo de la lista de bytes
    a la izqueirda y no a la derecha para poder ir sacando la cabeza y comprobar si es un digito binario
*/
reverse([],[]).
reverse([X|Xs],Ys):-
    reverse(Xs,Zs),
    append(Zs,[X],Ys).

/*
    Para el predicado 7 voy a necesitar saber la tabla de XOR para poder saber los resultados de las operaciones
    seguramente esté mal y haya que borrarlo
*/
xor([bind(1)],bind(1),bind(0)).
xor([bind(1)],bind(0),bind(1)).
xor([bind(0)],bind(1),bind(1)).
xor([bind(0)],bind(0),bind(0)).

%PREDICADOS!

%Predicado 1 -> byte_list/1
/*
    Lo que queremos es comprobar si los elementos de una lista dada son de tipo byte, por lo que una funcion
    recursiva es una buena opcion, ya que asi, lo que puedo hacer es comprobar cada elemento de manera individual 
    llamando a mi predicado byte/1 
*/
byte_list([]).                                  %caso base
byte_list([B|L]):-
    byte(B),
    byte_list(L).

%Predicado 2 -> byte_conversion/2
/*
    En este predicado, mi objetivo es comprobar si un hexadecimal y un binario dados representan el mismo numero
    para esto lo que voy a hacer es comprobar si el primer nibble del byte esta represetnado por los primeros 4 bind
    de la cadena de 8 bits y el segundo nibble con los otros 4 siguientes. Esto gracias a la base de hechos que he conformado
    mas arriba
*/
byte_conversion([H1,H0], [B7,B6,B5,B4,B3,B2,B1,B0]):-
    hex_byte([H1,H0]),                          %compruebo si H1-H0 representan un byte hexadecimal
    binary_byte([B7,B6,B5,B4,B3,B2,B1,B0]),     %compruebo si B7-B0 representan un byte binario
    hex_to_bin_byte([H1],[B7,B6,B5,B4]),        %compruebo si son equivalentes las respectivas mitades
    hex_to_bin_byte([H0],[B3,B2,B1,B0]).

%Predicado 3 -> byte_list_conversion/2
/*
    En este predicado, mi objetivo es comparar si dos listas de bytes, una hex y otra bin, representan lo mismo
    este predicado hara uso del predicado 1 ya que este lo que hace es compararme un hex y un bin,
    las llamadas al mismo se realizaran con los primeros elementos de cada lista. Ademas este predicado 
    sera recursivo para asi poder ir vaciando las listas dadas y así poder comprobar todos los elementos.
*/
byte_list_conversion([],[]).                    %caso base
byte_list_conversion([H|Hn],[B|Bn]):-
    byte_conversion(H,B),
    byte_list_conversion(Hn,Bn).

%Predicado 4 -> get_nth_bit_from_byte/3
get_nth_bit_from_byte(0, [Bn|_],Bn).
get_nth_bit_from_byte(N, Hb, BN):-
    hex_byte(Hb),
    byte_conversion(Hb, Bb),%no se si necesario
    reverse(Bb, RH),


get_nth_bit_from_byte(N, Bb, BN):-
    binary_byte(Bb),
    reverse(Bb,RB).
%Predicado 5 -> byte_list_clsh/2


%Predicado 6 -> byte_list_crsh/2


%Predicado 7 -> byte_xor/3
byte_xor().
