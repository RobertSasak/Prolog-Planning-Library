% This file contains more predicates used in various testing and solvers.

% This predicate does almost the same as solve_files, but it returns the 
% amount of states the solution has, and does not display the statistics.
% This is used for testing, in testing.pl.
% get_solution(+Domainfile, ProblemFile, -LengthOfSoltuion)
get_solution(DomainFile, ProblemFile, L) :- 
                parseDomain(DomainFile, DD, _),
                parseProblem(ProblemFile, PP, _),
                term_to_ord_term(DD, D),
                term_to_ord_term(PP, P),
                reset_statistic,
                !,
                time_out(solve(D, P, S), 3000, _Result), % time limit for a planner
                length(S, L),
                !.

% The following are a number of printing predicates. These are really handy 
% for debugging. 

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
                print_pred(H),
                print_state(T).

% Prints the predicates from the PDDL file im interested in, the non-static ones
% This is currently specifically designed for the hanoi problem, but it can be
% easily modified to work with other predicates. Just change the first predicates
% to the predicates you do not want printed, and the predicates in the rules to the
% ones you want printed out. 
print_pred(smaller(_, _)).
print_pred(clear(_)).
print_pred(X) :- 
                \+ X = smaller(_, _),
%                \+ X = on(_, _),
                \+ X = clear(_),
                print('    '), 
                print(X).

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

