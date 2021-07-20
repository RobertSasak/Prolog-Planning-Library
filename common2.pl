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