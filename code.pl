:- module(_, _, [assertions, regtypes]).
author_data('Corrales', 'Falco', 'Daniel', 'B190410').

%Define a binary digit type.
bind(0).
bind(1).
%Define a binary byte as a list of 8 binary digits.
binary_byte([bind(B7)],[bind(B6)],[bind(B5)],[bind(B4)],[bind(B3)],[bind(B2)],[bind(B1)],[bind(B0)]):-
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

%Predicado 1 -> byte_list/1
/*
    Lo que queremos es comprobar si los elementos de una lista dada son de tipo byte, por lo que una funcion
    recursiva es una buena opcion, ya que asi, lo que puedo hacer es comprobar cada elemento de manera individual 
    llamando a mi predicado byte/1 
*/
byte_list([]).
byte_list([B|L]):-
    byte(B),
    byte_list(L).

%Predicado 2 -> byte_conversion/2
