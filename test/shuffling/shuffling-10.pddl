(define (problem shuffling-10)
(:domain shuffling_domain)
(:objects block1 block2 block3 block4 block5 block6 block7 block8 block9 block10
          pos1 pos2 pos3 pos4 pos5 pos6 pos7 pos8 pos9 pos10)

(:init
(at block1 pos9)
(at block2 pos4)
(at block3 pos1)
(at block4 pos6)
(at block5 pos5)
(at block6 pos3)
(at block7 pos10)
(at block8 pos8)
(at block9 pos2)
(at block10 pos7)

(left pos1 pos2)
(left pos2 pos3)
(left pos3 pos4)
(left pos4 pos5)
(left pos5 pos6)
(left pos6 pos7)
(left pos7 pos8)
(left pos8 pos9)
(left pos9 pos10)
)
(:goal
    (and (at block1 pos1)
         (at block2 pos2)
         (at block3 pos3)
         (at block4 pos4)
         (at block5 pos5)
         (at block6 pos6)
         (at block7 pos7)
         (at block8 pos8)
         (at block9 pos9)
         (at block10 pos10)))
)
