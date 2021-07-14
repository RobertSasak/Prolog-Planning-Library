% Debugging and testing file
% Ideas for a-star:
% The \+ member test in next_node seems to always pass. Is it on the right form?

% The \+ my_ord_member test in next_node seems to scale linearly, when it could be logarithmic / constant (hashmap)

% Make the visited nodes update properly

% Visited should be a hashmap

% Nodes that gets popped should not be in Visited, and should not be added twice to visited.
      
% I Dont think this is right:
% It may be that as soon as a solution is found, the algorithm cterminates. However, it should wait until the
% solution is popped, rather than discovered (highly speculative, I do not know yet). 
% Why does h_diff always add 1 to the value?

  

% Prints Queue (List of nodes)
print_queue(H) :- 
                print('Printing Queue: '), nl, my_print_queue(H, 0).

my_print_queue([], _) :- nl, !.
my_print_queue([H|T], Count) :-
%                print('    '),
                H = K-State,
                print_node(State, Count, K), nl,
                Count1 is Count + 1,
                my_print_queue(T, Count1), !.
my_print_queue(_, _) :- print('Queue not on right format'), nl.

% Prints the information of a node in the heap
print_node(N) :- print('Printing Node :'), nl, print_node(N, 0, 'Unknown').

%print_node([], _, _) :- !.                    
print_node([S, PS, A, D], Counter, K) :-
%                print('__________'), nl,
                print('    '), print('Number in list : '), print(Counter), nl,
                print('    '), print('State: '), print_state(S), nl,
                print('    '), print('Previous State: '), print_state(PS), nl,
                print('    '), print('Action: '), print(A), nl,
                print('    '), print('Deep: '), print(D), nl,
                print('    '), print('A-star value: '), print(K), nl, !.
print_node(_, _, _) :-
                print('Node on wrong format'), nl.
% Prints a PDDL state, with the information I am intersted in (non-static predicates). 
print_state([]) :- !.
print_state([H|T]) :-
%                print('    '),
%                print(H),
                print_pred(H),
                print_state(T).

% Prints the predicates from the PDDL file im interested in, the non-static ones
print_pred(smaller(_, _)).
print_pred(clear(_)).
print_pred(X) :- 
                \+ X = smaller(_, _),
%                \+ X = on(_, _),
                \+ X = clear(_),
                print('    '), 
                print(X).

output_nodes :-
                findall(X, my_nodes(X), L),
                print_list_of_nodes(L, 0).

% Prints a list of nodes, with help from print_node and print_state
print_list_of_nodes(L) :- print_list_of_nodes(L, 0). 

print_list_of_nodes([], _) :- !.
print_list_of_nodes([H|T], Counter) :- 
                print_node(H, Counter, 'Unknown'), Counter1 is Counter + 1, print_list_of_nodes(T, Counter1).
    
% Printing list in a nice way for problems and domains
print_list([]) :- !.
print_list([H|T]) :- print('        '), print(H), nl, print_list(T).

% Prints the domain with all the variables, some being not so interesting.
my_print(domain(N, R, T, C, P, F, C, S)) :- 
                print('N (name): '), print(N), nl,
                print('R (requirements): '), print(R), nl,
                print('T (types): '), print(T), nl,
                print('C (constants): '), print(C), nl,
                print('P (predicates): '), print(P), nl,
                print('F (functions): '), print(F), nl,
                print('C (constraints): '), print(C), nl,
                print('S (structure): '), print(S), nl.

% Printing domain in a nice way, only the variables I am interested in
print_domain(domain(N, _, _, _, P, _, _, S)):-
                print('N (name): '), print(N), nl,
                print('P (predicates): '), print(P), nl,
                print('S (structure): '), nl, print_list(S), nl.

% Printing problem in a nice way
print_problem(problem(Name, Domain, _R, OD, I, G, _Unknown, _MS, _LS)) :-
                print('Name: '), print(Name), nl,
                print('Domain: '), print(Domain), nl,
%                print('R: '), print(R), nl,
                print('Object Declaration: '), print(OD), nl,
                print('Init: '), print(I), nl,
                print('Goal: '), print(G), nl.
%                print('Unkown: '), print(Unknown), nl,
%                print('MS: '), print(MS), nl,
%                print('LS: '), print(LS), nl.

% Debugging function
new_next_node(SR, Q, V, _E, _NewSR):- 
                state_record(S, _, _, _D, SR),
                step(S, _A, NewS),
                state_record(NewS, _, _, _, Temp),
                \+ my_ord_member(NewS, V),
                heap_to_list(Q, PQL),
                member(Temp, PQL),
                print('!!!!!!!!!!!!!!!!'),
                print('Temp: '), print(Temp), nl, 
                print('PQL:  '), print(PQL), nl.
new_next_node(SR, Q, V, E, NewSR):-
                state_record(S, _, _, D, SR),
                step(S, A, NewS),
                state_record(NewS, _, _, _, _Temp),
                \+ my_ord_member(NewS, V), % Would this run faster with a HashMap?
                heap_to_list(Q, PQL),
%               print('Temp: '), print(Temp), nl, 
%               print('PQL:  '), print(PQL), nl,
%               \+ member(Temp, PQL), % Does this work? It seems like it always passes
                h(S, H),
%               print(E),
                E is H+D,
                ND is D+1,
                print('ND1: '), print(ND), nl,
                new_not_member(ND-NewS, PQL),
%               my_func(Temp, PQL), % Debug
                
                
                state_record(NewS, S, A, ND, NewSR),
%               print(NewSR),
                asserta(my_nodes(NewSR)). % debug 

% An attempt to test of the node is already in the heap. 
new_not_member(_, []) :- print('Not Equal'), nl, !.
new_not_member(ND-NewS, [H|_]) :-
                atomic(ND),
                H = C-State,
                State = [S, _, _, _], 
                print('ND2: '), print(ND), nl,
                print('New State: '), print_state(NewS), nl,
                print('Old State: '), print_state(S), nl,
%               S = NewS,ø
                print('Success'), print(C), nl, !,
                ND >= C, fail.
new_not_member(_NewS, [_|T]) :-
                new_not_member(_, T), !.
%               PQL = [_-State],
%               print('PQL: '), print(State), nl.

% WARNING: This does not work
% Updates the Key-Datum pairs from List to OldHeap, creating NewHeap. 
% The Datums are replaced rather than just added, see predicate below
% update_heap(+OldHeap, +List, -NewHeap)
update_heap(OH, [], OH).
update_heap(OH, [K-D|T], NH) :-
                replace_heap(OH, K-D, H),
                update_heap(H, T, NH).

% Adds K-D pair to OH if the State to D is not already in the Heap. If it is already
% in the heap, it updates it if Key is smaller. 
% replace_heap(+OldHeap, +Key-Datum, NewHeap)
replace_heap(OH, K-D, NH) :- % State is already in heap, but has higher key. It is replaced. 
                state_record(S, _, _, _, D),
%               print_state(S), nl,
%               state_record(S, _, _, _, OldNode),
%               heap_to_list(OH, Queue),
%               print_queue(Queue),
%               add_to_heap(OH, K, D, Test),
%               delete_from_heap(Test, TestK, D, _TestHeap),
%               print_node(TestK), 
                delete_from_heap(OH, OldKey, [S, _, _, _], CurrentHeap),
%               print('_______________________________________'), nl, 
                K < OldKey,
                add_to_heap(CurrentHeap, K, D, NH),
                print('replace_heap1'). 
% This one is unecessairy, mainly for debugging 
replace_heap(OH, K-D, OH) :- % State is already in heap, but has smaller key. Nothing happens. 
                state_record(S, _, _, _, D),
                state_record(S, _, _, _, OldNode),
                delete_from_heap(OH, OldKey, OldNode, _),
                K >= OldKey,
                print('replace_heap2'). 
replace_heap(OH, K-D, NH) :- % State is not in heap, simply add it. 
                add_to_heap(OH, K, D, NH).

% solution h_0
%hanoi_test2 0.000 4 18677312 3 
%hanoi3 0.000 39 18677312 9 
%hanoi4 0.016 135 18677312 18 
%hanoi5 0.344 501 18677312 37 
%hanoi6 3.048 1437 23723584 76
%hanoi7 35.843 4612 158072384 151
%
% solution h_diff
%hanoi_test2 0.000 4 158072384 3
%hanoi3 0.000 24 158072384 8 
%hanoi4 0.016 85 158072384 17 
%hanoi5 0.125 294 158072384 35 
%hanoi6 1.766 1014 158072384 72 
%hanoi7 19.078 3229 158072384 149
%
% solution2 h_0
%hanoi_test2 0.000 4 66715200 2 
%hanoi3 0.000 39 66715200 7 
%hanoi4 0.032 135 66715200 15 
%hanoi5 0.328 501 66715200 31 
%hanoi6 2.906 1437 66715200 63
%hanoi7 34.920 4612 158072384 127 
%                           
% solution2 h_diff
%hanoi_test2 0.000 4 66715200 2
%hanoi3 0.000 24 66715200 7 
%hanoi4 0.000 85 66715200 15 
%hanoi5 0.109 294 66715200 31 
%hanoi6 1.812 1014 66715200 63 
%hanoi7 18.578 3229 66715200 127