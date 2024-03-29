%h(State, EstimatedValue)
% Estimated distance to achive Goal.
h(S, E):-
		relax(S, E).

relax(S, 0):-
		bb_get(fictiveGoal, G),
		sort(S, S1),
		ord_subset(G, S1), !.
relax(S, ND):-
		setof(P, relax_step(S, P), RS),
		ord_union([S|RS], NS),
		relax(NS, D),
		ND is D+1.

relax_step(State, PE):-
		get_action(A),	get_precondition(A, P),
		mysubset(P, State),
		get_positiv_effect(A, PE1), sort(PE1, PE).
