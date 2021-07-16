(define (problem koltski_problem_medium2)
(:domain klotski)
(:objects p1 p2 p3 p4 p5 p6 p7 p8 p9 p10
		  p11 p12 p13 p14 p15 p16 p17 p18 p19 p20
		  m1 m2)
		  
(:init 

(medium m1)
(medium m2)

(under p5 p1)
(under p9 p5)
(under p13 p9)
(under p17 p13)
(under p6 p2)
(under p10 p6)
(under p14 p10)
(under p18 p14)

(under p7 p3)
(under p11 p7)
(under p15 p11)
(under p19 p15)
(under p8 p4)
(under p12 p8)
(under p16 p12)
(under p20 p16)

(right p2 p1)
(right p3 p2)
(right p4 p3)
(right p6 p5)
(right p7 p6)
(right p8 p7)

(right p10 p9)
(right p11 p10)
(right p12 p11)
(right p14 p13)
(right p15 p14)
(right p16 p15)

(right p18 p17)
(right p19 p18)
(right p20 p19)

(at m1 p15)
(at m1 p19)
(at m2 p10)
(at m2 p14)

(free p1)
(free p2)
(free p3)
(free p4)
(free p5)
(free p6)
(free p7)
(free p8)
(free p9)

(free p11)
(free p12)
(free p13)

(free p16)
(free p17)
(free p18)

(free p20)
)

(:goal (and (at m1 p16)
	   		(at m1 p20)
	   		(at m2 p5)
	   		(at m2 p9)))
)