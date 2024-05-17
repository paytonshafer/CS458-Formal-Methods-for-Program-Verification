; Payton Shafer CS458: HW3 Problem 2
; z3 code to solve the following cryptarithmetic problem given r>n and standard cryptarithmetic constraints:
;   clar
;  +kson
;  -----
;  class 

; Declare a variable for each letter and each of the carries from addition
(declare-const c Int)
(declare-const l Int)
(declare-const a Int)
(declare-const r Int)
(declare-const k Int)
(declare-const s Int)
(declare-const o Int)
(declare-const n Int)
(declare-const carry1 Int)
(declare-const carry2 Int)
(declare-const carry3 Int)

; Each letter is a digit from 0 to 9
(assert (and (>= c 0) (<= c 9)))
(assert (and (>= l 0) (<= l 9)))
(assert (and (>= a 0) (<= a 9)))
(assert (and (>= r 0) (<= r 9)))
(assert (and (>= k 0) (<= k 9)))
(assert (and (>= s 0) (<= s 9)))
(assert (and (>= o 0) (<= o 9)))
(assert (and (>= n 0) (<= n 9)))

; Each carry is either 0 or 1
(assert (xor (= carry1 1) (= carry1 0)))
(assert (xor (= carry2 1) (= carry2 0)))
(assert (xor (= carry3 1) (= carry3 0)))

; No two letters are the same digit
(assert (distinct c l a r k s o n))

; Given constraint that r > n
(assert (> r n))

; The leading numbers are not equal to 0
(assert (not (= c 0)))
(assert (not (= k 0)))

; Now I will go through each addition statements and write them in z3
;  c3 c2 c1             where c1, c2, c3 are carry1, carry2, carry3 respectivly
;   c  l  a  r
; + k  s  o  n
; -------------
; c l  a  s  s 

; r + n = carry1*10 + s
(assert (= (+ r n) (+ (* carry1 10) s)))

; carry1 + a + o = carry2*10 + s
(assert (= (+ carry1 a o) (+ (* carry2 10) s)))

; carry2 + l + s = carry3*10 + a
(assert (= (+ carry2 l s) (+ (* carry3 10) a)))

; carry3 + c + k = c*10 + l
(assert (= (+ carry3 c k) (+ (* c 10) l)))

; Get Soln 1
(check-sat)
(get-model)
; The result of SAT means there is a solution as follows:
;                              0 1 1 
;   1037                       1 0 3 7
;  +9285   or with carries:  + 9 2 8 5
;  -----                    -----------
;  10322                     1 0 3 2 2

; c = 1
; l = 0
; a = 3
; r = 7
; k = 9
; s = 2
; o = 8
; n = 5

; Trying to find more solutions to completly rule out soln1
(assert (or (not (= c 1)) (not (= l 0)) (not (= a 3)) (not (= r 7)) (not (= k 9)) (not (= s 2)) (not (= o 8)) (not (= n 5))))

; Try for Soln 2
(check-sat)
(get-model)
; The result of SAT means there is another solution as follows:
;                              0 1 1 
;   1047                       1 0 4 7
;  +9386   or with carries:  + 9 3 8 6
;  -----                    -----------
;  10433                     1 0 4 3 3

; c = 1
; l = 0
; a = 4
; r = 7
; k = 9
; s = 3
; o = 8
; n = 6

; Trying for more solns so completly rule out soln2
(assert (or (not (= c 1)) (not (= l 0)) (not (= a 4)) (not (= r 7)) (not (= k 9)) (not (= s 3)) (not (= o 8)) (not (= n 6))))

; Try for Soln 3
(check-sat)
(get-model)
; The result of UNSAT means there is no more solutions