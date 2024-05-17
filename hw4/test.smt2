(declare-sort Person) ; sort for person
(declare-fun M (Person Person) bool) ; mother function (p1 is mother of p2)

; Somebody has a mother
; There exists x, y in person such that x is y's mother
(assert (exists ((x Person) (y Person)) (M x y)))

; Everybody has a mother who is not themself
; For all x, y in person st if M(x, y) then x != y
(assert (forall ((x Person)) (exists ((y Person)) (and (M y x) (not (= x y)))))) ; SHould have exitst y and & instead of =>

; Nobody can have two mothers
; For all x, y, z in person st if M(x, y) and M(z, y) then x = z
(assert (forall ((x Person) (y Person) (z Person)) (=> (and (M x y) (M z y)) (= x z))))

; Somebody has at least two children
; There exists x, y, z in person st M(x, y) and M(x, z)
(assert (exists ((x Person) (y Person) (z Person)) (and (M x y) (M x z) (not (= y z))))) ; FORGOT TO ADD y != z

(check-sat)
(get-model)