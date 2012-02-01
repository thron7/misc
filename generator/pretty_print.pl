:- use_module(library(pairs)).

% pairs helper

pairs_get(K, P, V) :-
    keysort(P, P1),
    group_pairs_by_key(P1, J),
    pairs_get_joined(K, J, V).

pairs_get_joined(K, [K-V|_], V) :- !.
pairs_get_joined(K, [_|J], V) :-
    pairs_get_joined(K, J, V).
    

% Attr being a pairs array
attrib_get(K, Attr, V) :-
    pairs_get(K, Attr, [V|_]).

pretty_open(node_block, _, '{').
pretty_close(node_block, _, '}').
pretty_open(node_text, Attr, V) :- attrib_get(value, Attr, V).
pretty_close(node_text, _, '').

% :- X=[[node_text, [value-'FooManChu'], []]], [[N,A,_]|R] = X,pretty_open(N,A,V).

% some test trees
forest(f1, [[node_text, [value-'FooManChu'], []]]).
forest(f2, [[node_block, [], [[node_text, [value-'FooManChu'], []]]]]).


% pretty_print(+List_of_trees, -List_of_strings)
pretty_print([], ['']) :- !.
pretty_print([[Node, Attribs, Children]|N], L) :-
    pretty_open(Node, Attribs, SOpen),
    pretty_close(Node, Attribs, SClose),
    pretty_print(Children, SChildren),
    pretty_print(N, SN),
    append([[SOpen], SChildren, [SClose], SN], L).


% some AST-related predicates

ast(node_if, [node_if_cond, node_then, node_else]).  % 'if-then-else'

% vim: ts=4 sw=4
