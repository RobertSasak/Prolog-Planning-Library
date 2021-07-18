% Does not check non-member test in my_pop
% Fail, 13 fail, 11 pass
           
:-use_module(library(ordsets)).
:-use_module(library(heaps)).

%search(InitState, GoalState, -Solution)
search(I, _, Solution):-
                a_star(I, Solution, _).
                
                
%bfs(+InitState, -Actions, -Cost).
a_star(S, A, C):-
                state_record(S, nil, nil, 0, SR),
                list_to_heap([0-SR], PQ),
                a_star(PQ, [], A, C).

%a_star(+Queue, +Visited, -Solution, -Cost)
a_star(PQ, _, 'NO SOLUTION', _):-
                empty_heap(PQ),!.
a_star(PQ, V, Solution, C):-
                my_pop(PQ, C, SR, _, V),
%               get_from_heap(PQ, C, SR, _),
                state_record(S, _, _, _, SR),
                is_goal(S),
%               
                % Step 4 of the demonstration.pl
%               nl, print('Raw printing of goal node: '), nl, print(SR), nl, nl,
%               print('Formated printing of goal node: '), nl, print_node(SR), nl,

                solution2(SR, V, Solution).

a_star(PQ, V, Solution, C):-
                my_pop(PQ, _K, SR, RPQ, V), 
%               get_from_heap(PQ, _K, SR, RPQ),
                
                ord_add_element(V, SR, NV),
                (bagof(K-NS, next_node(SR, PQ, NV, K, NS), NextNodes) ; NextNodes=[]),
                add_list_to_heap(RPQ, NextNodes, NPQ), 
%               update_heap(RPQ, NextNodes, NPQ),
                stat_node,
                a_star(NPQ, NV, Solution, C).

%next_node(+StateRecord, +Queue, +Visited, -EstimateDeep, -NewStateRecord)
next_node(SR, Q, V, E, NewSR):-
                state_record(S, _, _, D, SR),
                step(S, A, NewS),
                state_record(NewS, _, _, _, Temp),
                
                \+ my_ord_member(NewS, V),
                heap_to_list(Q, PQL),
%               new_not_member(Temp, PQL), 
                \+ member(Temp, PQL), % Is this working?
                h(S, H),
                E is 1*H+D,
                ND is D+1,
%               print('D: '), print(D), print('H: '), print(H), nl,
                state_record(NewS, S, A, ND, NewSR).

%add_list_to_heap(+OldHeap, List, NewHeap)
add_list_to_heap(OH, [], OH).
add_list_to_heap(OH, [K-D|T], NH):-
                add_to_heap(OH, K, D, H),
                add_list_to_heap(H, T, NH).


my_ord_member(S, [SR|_]):-
                state_record(S2, _, _, _,SR),
                repeating(S, S2),
                !.
my_ord_member(S, [_|T]):-
                my_ord_member(S, T).


% Pops from heap, until an unvisited node is found.
% my_pop(OldHeap, Visited, Datum, NewHeap)
my_pop(OH, K, D, NH, _V) :-
                get_from_heap(OH, K, D, NH),
                D = [_S, _, _, _], 
%                \+ my_ord_member(S, V), 
                !.
my_pop(OH, K, D, NH, V) :-
                get_from_heap(OH, _, _, CurrentHeap), 
                my_pop(CurrentHeap, K, D, NH, V).
                