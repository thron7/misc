%

match(Syntax_tree, Schema_tree) :-
    match_node(Syntax_tree, Schema_tree),
    match_children(Syntax_tree, Schema_tree).


match_children(Syntax_tree, Schema_tree) :-
    get_children(Syntax_tree, TChildren),
    [C|CS] = TChildren,
    get_schema_entry(C, Schema_tree, SNode),
    match(C, SNode),
    match_children(CS, Schema_tree).

match_node(T, S) :-
    match_type(T,S).


match_type(T,S) :-
    type(T, Tt),
    type(S, St),
    Tt = St.


type(g1,4).
type(g2,5).
type(g3,4).

% vim: ts=4 sw=4
