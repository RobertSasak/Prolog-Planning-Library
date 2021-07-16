Sparse branch containts just the files neseccary to explain and fix the bugs, master branch
contains the same, but also with all of Robert Sasaks other files. 

Here is an overview of the changes done to the original files of Robert Sasak. 
There were some bugs in the code that I have tried to fix. I also made a testing
file, and some mutants of the code to see how well the tests work.

Here is a brief overview of the new files, followed by a brief explanation of what
is done in them (the files should be pretty well documented themselves): 

demonstration.pl: An elaborate overview of the initial bug, and how it was found and fixed.

demonstration_drawing.pdf: A supplement drawing to display the bug. 

launch.pl: An easy way of running the algorithms on the problems. 

testing.pl: A testing suite to check if a file and algorithm returns an optimal solution. 

extra.pl: Predicates used for debugging, mostly ways of printing nodes and 
lists in a nice way.

running_times_hanoi.txt: Compares how a-star and its heuristics runs on hanoi, 
before and after fixing the initial bug. Does not test the second bug. 

mutant_overview.txt: An overview of the mutants I made, and how they get tested.

running_times_all.txt: An overview of how a-star and its heuristics (h_0, h_diff, 
h_add and h_max) run on the problems (time and length of solution).

I the tests folder, a sliding puzzle and klotski puzzle domain and problems are added.
They correspond to "8 puzzle / 15 puzzle / 16 puzzle", and the klotski sliding puzzle. 


Description of project: Robert Sasak had implemented a parser for planning problems (PDDL),
and some algorithms to solve them. However, it was observed that a-star with h_0 (no heuristic,
equivelant of dijkstra) did not run optimal on hanoi, which it should. I tried to find the bug
and fix it, see demonstration.pl.
The bug was that visited nodes got added to the queue, and when they got popped they got re-visited. 
When the solution was found, the path found by backtracking could therefore have multiple options,
and an option was chosen arbitrarily rather than optimally. By using the new predicate "my_pop" instead
of "get_from_heap" directly, this got fixed. This also substantially improved the running times. 
There was later found another minor bug. For non-monotone admissible heuristics, nodes may need to be
re-visited (with lower cost the second time). Therefore, "weighted_member" was implemented instead of
"my_ord_member". Note that this predicate increases the running time, but makes h_max a complete heuristic. 

Mutants verifies how well a testing program works, by adding small changes to the files, and sees
if those changes are detected in the testing. The testing.pl has many tests implemented. The mutant files
have intentionally implemented bugs in them. There are brief explanations of them in the files, see the
mutant_overview.txt for more information. 

Why non-monotone heuristic may need to revisit nodes:
https://cs.stackexchange.com/questions/53956/monotone-property-of-heuristic-in-a-algorithm

Why admissible (non-overestimating) heuristic run optimal: 
https://en.wikipedia.org/wiki/Admissible_heuristic

General information about a-star in nice slides: 
https://courses.cs.duke.edu/fall11/cps149s/notes/a_star.pdf

Some other nice slides:
http://www.cs.toronto.edu/~sheila/384/w14/Lectures/csc384w14-Lecture02-HeuristicSearch-4pp.pdf

More about consistent / monotone heuristics: 
https://en.wikipedia.org/wiki/Consistent_heuristic
