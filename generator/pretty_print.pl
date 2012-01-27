:- use_module(library(pairs)).

% pairs helper

pairs_get(K, P, V) :-
    keysort(P, P1),
    group_pairs_by_key(P1, J),
    pairs_get_joined(K, J, V).

pairs_get_joined(K, [K-V|_], V) :- !.
pairs_get_joined(K, [_|J], V) :-
    pairs_get_joined(K, J, V).
    

pretty_open(node_block, '{').
pretty_close(node_block, '}').
pretty_open(node_text, '').


pretty_print([[Node, Attribs, Children]|N], S) :-
    pretty_open(Node, SOpen),
    pretty_close(Node, SClose),
    pretty_print(Children, SChildren),
    pretty_print(N, SN),
    append([[SOpen], SChildren, [SClose], SN], S).


% vim: ts=4 sw=4
