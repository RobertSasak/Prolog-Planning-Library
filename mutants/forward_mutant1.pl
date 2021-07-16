% Does not check the negative preconditions in Step
% Fails, 19 Fail, 5 Pass

:-use_module(library(ordsets)).

make_init_state(I):-
                get_init(I),
                get_goal(G),
                bb_put(fictiveGoal, G).


make_solution(S, S).
                
step(State, ActionDef, NewState):-
                get_action(A, ActionDef),
                get_precondition(A, P),    mysubset(P, State),  % choose suitable action
%                get_negativ_effect(A, NE), ord_subtract(State, NE, State2),  
                get_positiv_effect(A, PE), ord_union(State, PE, NewState).

is_goal(S):-
                get_goal(G),
                ord_subset(G, S).

repeating(S1, S2):-
                S1 =  S2.
                
