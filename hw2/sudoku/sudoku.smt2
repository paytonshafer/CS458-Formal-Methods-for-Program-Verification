; Sudoku solver for a 4x4 board with the following inital conditions: c211 ,c313 ,c122 ,c433 ,c242 ,c341 ,c444

; cijk means cell i, j has value k
(declare-const c111 Bool)
(declare-const c112 Bool)
(declare-const c113 Bool)
(declare-const c114 Bool)
(declare-const c121 Bool)
(declare-const c122 Bool)
(declare-const c123 Bool)
(declare-const c124 Bool)
(declare-const c131 Bool)
(declare-const c132 Bool)
(declare-const c133 Bool)
(declare-const c134 Bool)
(declare-const c141 Bool)
(declare-const c142 Bool)
(declare-const c143 Bool)
(declare-const c144 Bool)
(declare-const c211 Bool)
(declare-const c212 Bool)
(declare-const c213 Bool)
(declare-const c214 Bool)
(declare-const c221 Bool)
(declare-const c222 Bool)
(declare-const c223 Bool)
(declare-const c224 Bool)
(declare-const c231 Bool)
(declare-const c232 Bool)
(declare-const c233 Bool)
(declare-const c234 Bool)
(declare-const c241 Bool)
(declare-const c242 Bool)
(declare-const c243 Bool)
(declare-const c244 Bool)
(declare-const c311 Bool)
(declare-const c312 Bool)
(declare-const c313 Bool)
(declare-const c314 Bool)
(declare-const c321 Bool)
(declare-const c322 Bool)
(declare-const c323 Bool)
(declare-const c324 Bool)
(declare-const c331 Bool)
(declare-const c332 Bool)
(declare-const c333 Bool)
(declare-const c334 Bool)
(declare-const c341 Bool)
(declare-const c342 Bool)
(declare-const c343 Bool)
(declare-const c344 Bool)
(declare-const c411 Bool)
(declare-const c412 Bool)
(declare-const c413 Bool)
(declare-const c414 Bool)
(declare-const c421 Bool)
(declare-const c422 Bool)
(declare-const c423 Bool)
(declare-const c424 Bool)
(declare-const c431 Bool)
(declare-const c432 Bool)
(declare-const c433 Bool)
(declare-const c434 Bool)
(declare-const c441 Bool)
(declare-const c442 Bool)
(declare-const c443 Bool)
(declare-const c444 Bool)

; This function takes 4 arguments and sums up the bool values
; This will be used to ensure only one bool is true for each digit for each row, col, and box
(define-fun sum_ones ((n1 Bool)(n2 Bool)(n3 Bool)(n4 Bool)) Int
    (+ (ite n1 1 0)
       (ite n2 1 0)
       (ite n3 1 0)
       (ite n4 1 0)))

; No column has duplicate values
; Use the function to sum bool vals for each col for each digit and ensure is 1
(assert (= (sum_ones c111 c121 c131 c141) 1))
(assert (= (sum_ones c112 c122 c132 c142) 1))
(assert (= (sum_ones c113 c123 c133 c143) 1))
(assert (= (sum_ones c114 c124 c134 c144) 1))
(assert (= (sum_ones c211 c221 c231 c241) 1))
(assert (= (sum_ones c212 c222 c232 c242) 1))
(assert (= (sum_ones c213 c223 c233 c243) 1))
(assert (= (sum_ones c214 c224 c234 c244) 1))
(assert (= (sum_ones c311 c321 c331 c341) 1))
(assert (= (sum_ones c312 c322 c332 c342) 1))
(assert (= (sum_ones c313 c323 c333 c343) 1))
(assert (= (sum_ones c314 c324 c334 c344) 1))
(assert (= (sum_ones c411 c421 c431 c441) 1))
(assert (= (sum_ones c412 c422 c432 c442) 1))
(assert (= (sum_ones c413 c423 c433 c443) 1))
(assert (= (sum_ones c414 c424 c434 c444) 1))

; No row has duplicate values
; Use the function to sum bool vals for each row for each digit and ensure is 1
(assert (= (sum_ones c111 c211 c311 c411) 1))
(assert (= (sum_ones c112 c212 c312 c412) 1))
(assert (= (sum_ones c113 c213 c313 c413) 1))
(assert (= (sum_ones c114 c214 c314 c414) 1))
(assert (= (sum_ones c121 c221 c321 c421) 1))
(assert (= (sum_ones c122 c222 c322 c422) 1))
(assert (= (sum_ones c123 c223 c323 c423) 1))
(assert (= (sum_ones c124 c224 c324 c424) 1))
(assert (= (sum_ones c131 c231 c331 c431) 1))
(assert (= (sum_ones c132 c232 c332 c432) 1))
(assert (= (sum_ones c133 c233 c333 c433) 1))
(assert (= (sum_ones c134 c234 c334 c434) 1))
(assert (= (sum_ones c141 c241 c341 c441) 1))
(assert (= (sum_ones c142 c242 c342 c442) 1))
(assert (= (sum_ones c143 c243 c343 c443) 1))
(assert (= (sum_ones c144 c244 c344 c444) 1))

; No 'box' (nxn squares) has duplicate values
; Use the function to sum bool vals for each box for each digit and ensure is 1
(assert (= (sum_ones c111 c211 c121 c221) 1))
(assert (= (sum_ones c311 c411 c321 c421) 1))
(assert (= (sum_ones c131 c231 c141 c241) 1))
(assert (= (sum_ones c331 c431 c341 c441) 1))
(assert (= (sum_ones c112 c212 c122 c222) 1))
(assert (= (sum_ones c312 c412 c322 c422) 1))
(assert (= (sum_ones c132 c232 c142 c242) 1))
(assert (= (sum_ones c332 c432 c342 c442) 1))
(assert (= (sum_ones c113 c213 c123 c223) 1))
(assert (= (sum_ones c313 c413 c323 c423) 1))
(assert (= (sum_ones c133 c233 c143 c243) 1))
(assert (= (sum_ones c333 c433 c343 c443) 1))
(assert (= (sum_ones c114 c214 c124 c224) 1))
(assert (= (sum_ones c314 c414 c324 c424) 1))
(assert (= (sum_ones c134 c234 c144 c244) 1))
(assert (= (sum_ones c334 c434 c344 c444) 1))

; Each cell has a digit
; Ensure each cell has atleast one value true
(assert (or c111 c112 c113 c114))
(assert (or c121 c122 c123 c124))
(assert (or c131 c132 c133 c134))
(assert (or c141 c142 c143 c144))
(assert (or c211 c212 c213 c214))
(assert (or c221 c222 c223 c224))
(assert (or c231 c232 c233 c234))
(assert (or c241 c242 c243 c244))
(assert (or c311 c312 c313 c314))
(assert (or c321 c322 c323 c324))
(assert (or c331 c332 c333 c334))
(assert (or c341 c342 c343 c344))
(assert (or c411 c412 c413 c414))
(assert (or c421 c422 c423 c424))
(assert (or c431 c432 c433 c434))
(assert (or c441 c442 c443 c444))

; Initial configuration of cells (preassinged cells digits)
; And each of the given parameters to ensure they all hold true
(assert (and c211 c313 c122 c433 c242 c341 c444))

(check-sat)
(get-model)