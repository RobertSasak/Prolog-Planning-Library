%h(State, EstimatedValue)
% Estimated distance to achive Goal.
:-use_module(library(sets)).

h(S, E):-
		bb_get(fictiveGoal, G),
		relax(S, G, E).
%    write(G-S-E),nl.

relax(_, [], 0):-!.
relax(S, G, E):-
%		print('E'),
    		subtract(G, S, Delta),
%		print(Delta), nl,
		setof(P1, (relax_step(S, P), sort(P, P1)), RS),
		sort(S, S1), sort(RS, RS1),
		ord_union([S1|RS1], NS),
%		print(RS), nl,
%		print(NS), nl, nl,
    		relax(NS, Delta, NE),
		length(Delta, LD),
		E is LD+NE,
		print(E), nl.

relax_step(State, PE):-
%		print('e'),
		get_action(A),	get_precondition(A, P),
		mysubset(P, State), %print_state(State),
		get_positiv_effect(A, PE).
%		print('a').
