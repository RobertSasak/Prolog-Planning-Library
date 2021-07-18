
% Demonstration of the initial bugs in the planning-code
% This is a documentation of how I found the bugs in Robert Sasaks planning code.
% The a-star algorithm with h_0 (no heuristic) was not returning optimal solutions for
% hanoi problem, which it should (since it is equivelant to dijkstra). I here explain
% how the bug is found and fixed. 
% See "running_times" for comparrison of how the algorithm works before and after.

:-['extra_tobias.pl'].
:-[readFile, parseProblem, parseDomain, common].
:- ['a-star', forward, h_0].

% TL;DR: The bug is caused by the "Visited-Nodes" not being updated correctly.
% When a node in a-star gets discovered again, the path which corresponds to the
% shortest path should overwrite. However, both of the nodes are added. 
% This results in 2 problems: 1. If two similar nodes with different paths/costs are added,
% a node with a longer path might get explored after the one with the shortest path/cost,
% which is very unecessary and makes the computation more expensive (we will se that more
% than double as many nodes will be visited in some cases, and running 2-5 times as slow). 
% 2. When a goal is found, the algorithm backtracks to print out the solution. If a node
% in the solutions has multiple paths to it, the path will be chosen arbritrarely rather 
% than optimally. This can lead to the solution printed not being optimal, although the optimal
% solutions technically was explored in the algorithm. 
      
% This document is written by Tobias Opsahl, tobiasop@gmail.com, tobiasao@uio.no.                   
                                                                                                                        
% Step 1: The solution for Hanoi3 is not optimal, even though it should.
% a-star with h_0 (h_0 is no heuristic) should run as Dijkstra, which should always
% return an optimal shortest path. However, look at the first two moves of the solution.
% Disc 1 is put at peg2 then peg3, when it could be put directly at peg3, saving a move. 
% (One more move is also superfluous)
% Check that (approximately) line 34 in a-star uses "solution" and not "solution2". 
% Check that (approximately) line 25 and 37 uses "get_from_heap", and not "my_pop".

:- solve_files('test/hanoi/domain-hanoi.pddl', 'test/hanoi/hanoi3.pddl').
   
% Step 2: To get an overview over the domain and problem, I tried printing it. 
% However, there is much repeated information (like static preticates) that are noisy.
% This is the structure made by the parsers (with some information omitted):

solve_test(DomainFile, ProblemFile):-
                parseDomain(DomainFile, DD, _),
                parseProblem(ProblemFile, PP, _),
                term_to_ord_term(DD, D),
                print_domain(D),
                term_to_ord_term(PP, P),
                print_problem(P).
                                
%:- solve_test('test/hanoi/domain-hanoi.pddl', 'test/hanoi/hanoi3.pddl').  

% Step 3: To make the problem easier, I tried finding a "minimal non-optimal" problem.
% By removing disc3 and having the only goal as "disc2 on peg2", the optimal solution should
% be "disc1 to peg3", "disc2 to peg2", but the algorithm still returned 3 (same manners as last time).
% Now there are much fewer actions and a little bit fewer predicates. 

%:- solve_test('test/hanoi/domain-hanoi.pddl', 'test/hanoi/hanoi_test2.pddl').    
%:- solve_files('test/hanoi/domain-hanoi.pddl', 'test/hanoi/hanoi_test2.pddl').
                                           
% Step 4: To get an overview of how the algorithm runs, we have to print it in a readable way.
% We can accurately determine the state with only the "on" predicate, so the predicate 
% print_state/1 prints only this information. I also made print_node/1 to print more information
% about the node, and print_list_of_nodes/1 to print a list of nodes on this format. 
% These predicates allowed for much easier debugging.
% Try uncommenting the printing in a-star, about line 30-32, before running the line below. 

%:- solve_files('test/hanoi/domain-hanoi.pddl', 'test/hanoi/hanoi_test2.pddl').

% Step 5: The algorithm actually finds the optimal solution correctly for this problem,
% finds an non-optimal path on the way back. The predicate solutions/3 backtracks the path
% to the goal. To see how we got to node "i", it finds a visteded node "j" that has an
% action that leads to "i". However, when multiple visited nodes leads to "i", then the 
% node is chosen arbitraley rather than optimally (the first node among them gets chosen,
% and there is no options for the remaining since it cuts and does not backtrack). 
% In our example, it chose the node that was visited non-optimally. 
% Try commenting in the lines in solution/3 in common.pl, about line 280, and notice
% that the first edge has two possible nodes to be chosen from, and the first, which
% gets chose, has a higher cost ("Deep").
                                                  
%:- solve_files('test/hanoi/domain-hanoi.pddl', 'test/hanoi/hanoi_test2.pddl').
                                     
% Step 6: A quick fix is given by solution2, which looks at all of the previous "j"
% nodes and choses the one with the minimal Deep, rather than chosen arbitrarely. 
% However, this is not a good fix, since the multiple nodes are still added to the
% queue. This slows down the explorations, and might cause other bugs (?). Instead,
% the Visisted datastructure should overwrite a node if and only if a shorter path 
% to it gets discovered. Try changing solution to solution2 in a-star, approximately
% line 38, and notice that both problems under now are optimal. 

%:- solve_files('test/hanoi/domain-hanoi.pddl', 'test/hanoi/hanoi_test2.pddl').     
%:- solve_files('test/hanoi/domain-hanoi.pddl', 'test/hanoi/hanoi3.pddl').                                                
%:- solve_files('test/hanoi/domain-hanoi.pddl', 'test/hanoi/hanoi6.pddl').

% Step 7 (final step): Now lets fix the bug in a way that actually improves the
% computations. Here is how the bug is fixed: Instead of directly popping nodes
% of the queue-heap in the first part of each iteration, we will implement another 
% predicate. I called this predicate "my_pop", and it will get nodes from heap until
% it gets a node that is _not_ already visited, then it will return that (return 
% the first unvisited minimal node). In this implementation, nodes with multiple 
% paths will still be added multiple times to the queue, but they will only be 
% explored if they are not visisted, which is revealed when it is popped. 
% Change the "get_from_heap" predicate (comment it out) to "my_pop" (comment it in)
% in the a_star predicate (about line 25 _AND_ 37) and run the code, and see
% that it is still optimal, but runs faster. See "running_times.txt" for a table
% of running times and explored nodes.
        
%:- solve_files('test/hanoi/domain-hanoi.pddl', 'test/hanoi/hanoi_test2.pddl').     
%:- solve_files('test/hanoi/domain-hanoi.pddl', 'test/hanoi/hanoi3.pddl').                                                
%:- solve_files('test/hanoi/domain-hanoi.pddl', 'test/hanoi/hanoi6.pddl').                    

% Some additional notes: I think the code with "my_pop" will work both with the solution
% and solution2 predicate. The algorithm can also be run with the heuristics h_diff,
% h_add and h_max, but not that (I think) these are not complete, and will therefore
% not always yield the optimal solution. 

% This document is written by Tobias Opsahl, tobiasop@gmail.com, tobiasao@uio.no. 

% Table for amount of moves in the solution. The solution2 yeilds the optimal path.
% See "running_times.txt" for more tests and information. 
%         solution | solution2
% Hanoi3:     9    |  2^3-1 = 7
% Hanoi4:    18    |  2^4-1 = 15
% Hanoi5:    37    |  2^5-1 = 31
% Hanoi6:    76    |  2^6-1 = 63
% Hanoi7:   151    |  2^7-1 = 127