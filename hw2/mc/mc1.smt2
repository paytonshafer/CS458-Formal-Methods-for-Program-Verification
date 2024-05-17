; Mutilated checkerboard for an 4x4 board with positions 24, 34 blocked off

; vij means a vertical domino starting at (i, j)
(declare-const v11 Bool)
(declare-const v12 Bool)
(declare-const v13 Bool)
(declare-const v21 Bool)
(declare-const v22 Bool)
(declare-const v23 Bool)
(declare-const v31 Bool)
(declare-const v32 Bool)
(declare-const v33 Bool)
(declare-const v41 Bool)
(declare-const v42 Bool)
(declare-const v43 Bool)

; hij means a horizontal domino starting at (i, j)
(declare-const h11 Bool)
(declare-const h12 Bool)
(declare-const h13 Bool)
(declare-const h14 Bool)
(declare-const h21 Bool)
(declare-const h22 Bool)
(declare-const h23 Bool)
(declare-const h24 Bool)
(declare-const h31 Bool)
(declare-const h32 Bool)
(declare-const h33 Bool)
(declare-const h34 Bool)

; Ensure open cells are covered by a domino
; Go through each unmutilated cell and ensure atleast one domino that covers it is true
(assert (or h11 v11)) ;cell 11
(assert (or h12 v11 v12)) ;cell 12
(assert (or h13 v12 v13)) ;cell 13
(assert (or h14 v13)) ;cell 14
(assert (or h11 h21 v21)) ;cell 21
(assert (or h12 h22 v21 v22)) ;cell 22
(assert (or h13 h23 v22 v23)) ;cell 23
(assert (or h21 h31 v31)) ;cell 31
(assert (or h22 h32 v31 v32)) ;cell 32
(assert (or h23 h33 v32 v33)) ;cell 33
(assert (or h31 v41)) ;cell 41
(assert (or h32 v41 v42)) ;cell 42
(assert (or h33 v42 v43)) ;cell 43
(assert (or h34 v43)) ;cell 44

; Ensure blocked off cells have NO dominos
; Check the four (at most) places where a domino starting there would cover it and ensure no domino will go there
(assert (and (not h14) (not h24) (not v23))) ;blocked cell 24
(assert (and (not h24) (not h34) (not v33))) ;blocked cell 34

; This function takes 4 arguments and sums up the bool values
; This will be used to ensure only one bool is true for each digit for each row, col, and box
(define-fun sum_ones ((n1 Bool)(n2 Bool)(n3 Bool)(n4 Bool)) Int
    (+ (ite n1 1 0)
       (ite n2 1 0)
       (ite n3 1 0)
       (ite n4 1 0)))

; Ensure no dominos overlap
; Use the above function to ensure only one domino is true on each cell, if there are less than 4 dominos then false is used in place of the missing ones
(assert (= (sum_ones false h11 false v11) 1)) ;cell 11
(assert (= (sum_ones false h12 v11 v12) 1)) ;cell 12
(assert (= (sum_ones false h13 v12 v13) 1)) ;cell 13
(assert (= (sum_ones false h14 v13 false) 1)) ;cell 14
(assert (= (sum_ones h11 h21 false v21) 1)) ;cell 21
(assert (= (sum_ones h12 h22 v21 v22) 1)) ;cell 22
(assert (= (sum_ones h13 h23 v22 v23) 1)) ;cell 23
(assert (= (sum_ones h21 h31 false v31) 1)) ;cell 31
(assert (= (sum_ones h22 h32 v31 v32) 1)) ;cell 32
(assert (= (sum_ones h23 h33 v32 v33) 1)) ;cell 33
(assert (= (sum_ones h31 false false v41) 1)) ;cell 41
(assert (= (sum_ones h32 false v41 v42) 1)) ;cell 42
(assert (= (sum_ones h33 false v42 v43) 1)) ;cell 43
(assert (= (sum_ones h34 false v43 false) 1)) ;cell 44

(check-sat)
(get-model)
; The output gives the solution of where to put the dominos and is as follows:
; Note di in a square means half the domino is there and the other half is in the square with the matching di
; Note Xi represents a blocked off square (in this case there are two so i is in {1, 2})
; For example cell 11 has d1 and call 12 has d1 so those two cells are covered by the same domino
;| d1 | d2 | d3 | d3 |
;| d1 | d2 | d4 | d4 |
;| d5 | d6 | d6 | d7 |
;| d5 | X1 | X2 | d7 |