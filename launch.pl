% Thisisacoveient way of running the files without shellscript. Just comment in the 
% algorithm you want to use and the problem you want to solve, and compile. 
% I used this file for testing and debugging. 


:-[readFile, parseProblem, parseDomain, common, extra].
:- ['a-star', forward, h_0].
%:-['a-star', forward, h_add].
%:-['a-star', forward, h_diff].
%:- ['a-star', forward, h_max].
%:-['dfs', 'forward', h_0].
%:-['wa-star', forward, h_add].

:- solve_files('test/elevators/domain-elevators.pddl', 'test/elevators/elevators-01-0.pddl').
%:- solve_files('test/elevators/domain-elevators.pddl', 'test/elevators/elevators-01-1.pddl').
%:- solve_files('test/elevators/domain-elevators.pddl', 'test/elevators/elevators-01-2.pddl').
%:- solve_files('test/elevators/domain-elevators.pddl', 'test/elevators/elevators-01-3.pddl').
%:- solve_files('test/elevators/domain-elevators.pddl', 'test/elevators/elevators-01-4.pddl').
%:- solve_files('test/elevators/domain-elevators.pddl', 'test/elevators/elevators-02-0.pddl').
%:- solve_files('test/elevators/domain-elevators.pddl', 'test/elevators/elevators-02-1.pddl').
%:- solve_files('test/elevators/domain-elevators.pddl', 'test/elevators/elevators-02-2.pddl').
%:- solve_files('test/elevators/domain-elevators.pddl', 'test/elevators/elevators-02-3.pddl').
%:- solve_files('test/elevators/domain-elevators.pddl', 'test/elevators/elevators-02-4.pddl').
%:- solve_files('test/elevators/domain-elevators.pddl', 'test/elevators/elevators-03-0.pddl').
%:- solve_files('test/elevators/domain-elevators.pddl', 'test/elevators/elevators-03-1.pddl').
%:- solve_files('test/elevators/domain-elevators.pddl', 'test/elevators/elevators-03-2.pddl').
%:- solve_files('test/elevators/domain-elevators.pddl', 'test/elevators/elevators-03-3.pddl').
%:- solve_files('test/elevators/domain-elevators.pddl', 'test/elevators/elevators-03-4.pddl').
%:- solve_files('test/elevators/domain-elevators.pddl', 'test/elevators/elevators-04-0.pddl').
%:- solve_files('test/elevators/domain-elevators.pddl', 'test/elevators/elevators-04-1.pddl').
%:- solve_files('test/elevators/domain-elevators.pddl', 'test/elevators/elevators-04-2.pddl').
%:- solve_files('test/elevators/domain-elevators.pddl', 'test/elevators/elevators-04-3.pddl').
%:- solve_files('test/elevators/domain-elevators.pddl', 'test/elevators/elevators-04-4.pddl').
%:- solve_files('test/elevators/domain-elevators.pddl', 'test/elevators/elevators-02-0.pddl').
%:- solve_files('test/elevators/domain-elevators.pddl', 'test/elevators/elevators-02-4.pddl').
%:- solve_files('test/elevators/domain-elevators.pddl', 'test/elevators/elevators-03-0.pddl').
%:- solve_files('test/elevators/domain-elevators.pddl', 'test/elevators/elevators-03-4.pddl').
%:- solve_files('test/elevators/domain-elevators.pddl', 'test/elevators/elevators-04-0.pddl').
%:- solve_files('test/elevators/domain-elevators.pddl', 'test/elevators/elevators-04-4.pddl').
%:- solve_files('test/elevators/domain-elevators.pddl', 'test/elevators/elevators-05-0.pddl').
%:- solve_files('test/elevators/domain-elevators.pddl', 'test/elevators/elevators-05-4.pddl').

%:- solve_files('test/blocks/domain-blocks.pddl', 'test/blocks/blocks-03-0.pddl').
%:- solve_files('test/blocks/domain-blocks.pddl', 'test/blocks/blocks-04-0.pddl').
%:- solve_files('test/blocks/domain-blocks.pddl', 'test/blocks/blocks-04-1.pddl').
%:- solve_files('test/blocks/domain-blocks.pddl', 'test/blocks/blocks-04-2.pddl').
%:- solve_files('test/blocks/domain-blocks.pddl', 'test/blocks/blocks-05-0.pddl').
%:- solve_files('test/blocks/domain-blocks.pddl', 'test/blocks/blocks-05-1.pddl').
%:- solve_files('test/blocks/domain-blocks.pddl', 'test/blocks/blocks-05-2.pddl').
%:- solve_files('test/blocks/domain-blocks.pddl', 'test/blocks/blocks-06-0.pddl').

%:- solve_files('test/Sliding_Puzzle/sliding_domain.pddl', 'test/Sliding_Puzzle/sliding3x3.pddl').
%:- solve_files('test/Sliding_Puzzle/sliding_domain.pddl', 'test/Sliding_Puzzle/sliding4x4.pddl').
%:- solve_files('test/gripper/domain-gripper.pddl', 'test/gripper/gripper2.pddl').
%:- solve_files('test/gripper/domain-gripper.pddl', 'test/gripper/gripper4.pddl').
%:- solve_files('test/gripper/domain-gripper.pddl', 'test/gripper/gripper6.pddl').
%:- solve_files('test/gripper/domain-gripper.pddl', 'test/gripper/gripper8.pddl').

%:- solve_files('test/blocks/domain-blocks.pddl', 'test/blocks/blocks-06-1.pddl').
%:- solve_files('test/klotski/klotski_domain.pddl', 'test/klotski/klotski_big_problem.pddl').
 %:- solve_files('test/rover/domain-rover.pddl', 'test/rover/rover1.pddl').

%% 'Minimal' Non optimal solution for a-star, forward, h_0. (or h_diff).
%:- get_solution('test/hanoi/domain-hanoi.pddl', 'test/hanoi/hanoi_test2.pddl', 3).
%:- solve_files('test/hanoi/domain-hanoi.pddl', 'test/hanoi/hanoi_test2.pddl').  
%:- solve_files('test/hanoi/domain-hanoi.pddl', 'test/hanoi/hanoi3.pddl').
%:- solve_files('test/hanoi/domain-hanoi.pddl', 'test/hanoi/hanoi4.pddl').
%:- solve_files('test/hanoi/domain-hanoi.pddl', 'test/hanoi/hanoi5.pddl').
%:- solve_files('test/hanoi/domain-hanoi.pddl', 'test/hanoi/hanoi6.pddl').
%:- solve_files('test/hanoi/domain-hanoi.pddl', 'test/hanoi/hanoi7.pddl').
%:- solve_files('test/hanoi/domain-hanoi.pddl', 'test/hanoi/hanoi8.pddl').

solve_test(DomainFile, ProblemFile):-
                parseDomain(DomainFile, DD, _),
                parseProblem(ProblemFile, PP, _),
                term_to_ord_term(DD, D),
                print_domain(D),
                term_to_ord_term(PP, P),
                print_problem(P).
%                reset_statistic,
%                !,
%                time_out(solve(D, P, S), 500000, _Result), % time limit for a planner
%                show_statistic(P, S),
%                !.