(define (problem koltski_problem)
(:domain klotski)
(:objects p1 p2 p3 p4 p5 p6 p7 p8 p9 p10
		  p11 p12 p13 p14 p15 p16 p17 p18 p19 p20
		  b1 m1 m2 m3 m4 l1 s1 s2 s3 s4)
		  
(:init 

(small s1)
(small s2)
(small s3)
(small s4)
(medium m1)
(medium m2)
(medium m3)
(medium m4)
(long l1)
(big b1)

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


(at b1 p2)
(at b1 p3)
(at b1 p6)
(at b1 p7)

(at m1 p1)
(at m1 p5)
(at m2 p4)
(at m2 p8)
(at m3 p9)
(at m3 p13)
(at m4 p12)
(at m4 p16)

(at l1 p10)
(at l1 p11)

(at s1 p17)
(at s2 p14)
(at s3 p15)
(at s4 p20)

(free p18)
(free p19)
)

(:goal (and (at b1 p14)
		   (at b1 p15)
		   (at b1 p18)
		   (at b1 p19)))
)