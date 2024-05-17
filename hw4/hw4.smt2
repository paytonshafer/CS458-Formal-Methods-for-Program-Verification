; Payton Shafer CS458: HW4
(set-option :produce-unsat-cores true)

(declare-sort Person) ; sort for person
(declare-fun M (Person Person) bool) ; mother function (p1 is mother of p2)

; Problem 1
; To get proper output of Problem 1 uncomment out the get model-call and comment problems 2 check-sat and get-model calls
(push)

; Somebody has a mother
; There exists x, y in person such that x is y's mother
(assert (exists ((x Person) (y Person)) (M x y)))

; Everybody has a mother who is not themself
; For all x, y in person st if M(x, y) then x != y
(assert (forall ((x Person)) (exists ((y Person)) (and (M x y) (not (= x y)))))) ; SHould have exitst y and & instead of =>

; Nobody can have two mothers
; For all x, y, z in person st if M(x, y) and M(z, y) then x = z
(assert (forall ((x Person) (y Person) (z Person)) (=> (and (M x y) (M z y)) (= x z))))

; Somebody has at least two children
; There exists x, y, z in person st M(x, y) and M(x, z)
(assert (exists ((x Person) (y Person) (z Person)) (and (M x y) (M x z) (not (= y z))))) ; FORGOT TO ADD y != z

(check-sat)
(get-model)
; This returns sat and gives us a model of a universe where this holds true as follows:
; Universe: P0, P1, P2, P3, P4; (Where P is a Person)
; Mother function: P0 is the mother of P1 and P2 is the mother P3 and P4
; P0 -> P1
; P2 -> P3
;   \-> P4

(pop)

; Problem 2
; To get proper output of Problem 2 comment out the previous get-model call and uncomment problems two check-sat and get-model calls
(push)

(declare-fun Age (Person) Int) ; Declare Age function to get age of person
(declare-const ann Person)

; Somebody has a mother
; There exists x, y in person such that x is y's mother
(assert (exists ((x Person) (y Person)) (M x y)))

; Nobody can have two mothers
; For all x, y, z in person st if M(x, y) and M(z, y) then x = z
(assert (forall ((x Person) (y Person) (z Person)) (=> (and (M x y) (M z y)) (= x z))))

; Mothers are older than their children
; For all x,y in Person if M(x, y) then Age(x) > Age(y)
(assert (forall ((x Person) (y Person)) (=> (M x y) (> (Age x) (Age y)))))

; Everybody who is not Ann has a mother (This does not say whether Ann has a mother)
; For all x in person if x is not Ann then There exists y in person such that M(y, x)
(assert (forall ((x Person)) (=> (not (= x ann)) (exists ((y Person)) (M y x)))))

; Somebody has at least two children
; There exists x, y, z in person st M(x, y) and M(x, z)
(assert (exists ((x Person) (y Person) (z Person)) (and (M x y) (M x z)))) ; dont have x != z

; Age is positive
; for all x in Person Age(x) > 0
(assert (forall ((x Person)) (> (Age x) 0)))

;(check-sat)
;(get-model)
; This returns sat and gives us a model of a universe where this holds true as follows:
; Universe: P0, P1, P2, P3, P4; (Where P is a Person)
; Ann is P4
; Mother function: P4 is the mother of P3, P2, P0 and P0 is the mother of P1
;   /-> P3
; P4 -> P0 -> P1
;   \-> P2
; Age function: P4 is 7, P3 is 4, P2 is 3, P1 is 1 and P0 is 2

(pop)

; Problem 3
(push)

; Somebody is the mother of everybody
; There exists x in person st for all y in person M(x, y) [x is y's mother]
(assert (!(exists ((x Person)) (forall ((y Person)) (M y x))) :named mother-of-everyone))

; Nobody has a mother
; For all x and y in person !M(x, y) [x is not y's mother]
(assert (!(forall ((x Person) (y Person)) (not (M x y)))  :named nobody-has-mother))

; Somebody has no mother
; There exists x in person st for all y in person !M(y, x) [y is not x's mother]
(assert (!(exists ((x Person)) (forall ((y Person)) (not (M y x)))) :named somebody-no-mother))

(check-sat)
(get-unsat-core)
; The output of unsat means the statements are unsatisfiable 
; So we ask for the unsat core to find out which statements clash and we got: (mother-of-everyone nobody-has-mother)
; This means the statements "Somebody is the mother of everybody" and "Nobody has a mother" together make this unsat

(pop)

; Problem 4
(push)

; Somebody has a mother
; There exists x and y st x is y's mother
(assert (exists ((x Person) (y Person)) (M x y)))

; Everybody has a mother
; For all x in people there exists y in people st y is x's mother
(assert (forall ((x Person)) (exists ((y Person)) (M y x))))

; Nobody can be their own maternal grandmother (no one can be their moms mom)
; For all x in person there exists y in person st if M(y, x) then !M(x, y)
(assert (forall ((x Person)) (exists ((y Person)) (=> (M y x) (not (M x y))))))

(check-sat)
; When this is ran z3 does not know how to solve it so it runs forever and returns unknown when '^c' is used
; The output is unknown because z3 tries to create an infinate universe for the problem.
; Since no one can be their own grandmother and everyone needs a mother z3 keeps adding new people to be the mother of the person
; it just added. Due to this the universe becomes infinite since z3 never stops adding people.

(pop)