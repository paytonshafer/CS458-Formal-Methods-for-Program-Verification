; Payton Shafer CS458: HW3 Problem 1
; z3 code to solve the logic puzzle found here: https://logic.puzzlebaron.com/pdf/T506XA.pdf

; The people are Adam, Audrey, Cynthia, Kassandra (kass)
(declare-datatypes () ((name adam audrey cynthia kass)))

; The internet browsers are Firefox (ff), Internet Explorer (ie), Opera, Safari
(declare-datatypes () ((browser ff ie opera safari)))

; The cameras are Canon, Casio, Kodak, Polaroid
(declare-datatypes () ((camera canon casio kodak polaroid)))

; b maps each person to the internet browser they use
(declare-fun b (name) browser)

; c maps each person to the camera they use
(declare-fun c (name) camera)

; m maps each person to how many megapixels they have
; 1 = 1.8, 2 = 3.2, 3 = 4.0, 4 = 7.0 then bound the output from 1 to 4
(declare-fun m (name) Int)
(assert (and (>= (m adam) 1) (<= (m adam) 4)))
(assert (and (>= (m audrey) 1) (<= (m audrey) 4)))
(assert (and (>= (m cynthia) 1) (<= (m cynthia) 4)))
(assert (and (>= (m kass) 1) (<= (m kass) 4)))

; binv is the inverse of b, cinv is the inverse of c, minv is the inverse of m
(declare-fun binv (browser) name)
(declare-fun cinv (camera) name)
(declare-fun minv (Int) name)

; This ensures those functions really are inverses using the definition of an inverse
(assert (= (binv (b adam)) adam))
(assert (= (binv (b audrey)) audrey))
(assert (= (binv (b cynthia)) cynthia))
(assert (= (binv (b kass)) kass))
(assert (= (cinv (c adam)) adam))
(assert (= (cinv (c audrey)) audrey))
(assert (= (cinv (c cynthia)) cynthia))
(assert (= (cinv (c kass)) kass))
(assert (= (minv (m adam)) adam))
(assert (= (minv (m audrey)) audrey))
(assert (= (minv (m cynthia)) cynthia))
(assert (= (minv (m kass)) kass))

; Now I will go through each of the statements to ensure they are true using the funcitons and variables defined above
; 1. Of Audrey and the photographer with the Canon camera, one only uses Safari for their web surfing and the other has the 4.0 megapixel camera.
; either audrey uses safari and canon person has 4.0 OR audrey has 4.0 and conon person uses safari
(assert (or (and (= audrey (binv safari)) (= (cinv canon) (minv 3))) (and (= (cinv canon) (binv safari)) (= audrey (minv 3)))))

; 2. The photographer with the Kodak camera is Cynthia.
(assert (= cynthia (cinv kodak)))

; 3. The person with the 4.0 megapixel camera can't stand using the Internet Explorer browser.
(assert (not (= (minv 3) (binv ie))))

; 4. The person who prefers using the Internet Explorer browser has a camera with more megapixels than the photographer with the Polaroid camera.
(assert (> (m (binv ie)) (m (cinv polaroid))))

; 5. Either the photographer with the Kodak camera or the photographer with the Polaroid camera only uses Firefox for their web surfing.
(assert (or (= (cinv kodak) (binv ff)) (= (cinv polaroid) (binv ff))))

; 6. The person with the 1.8 megapixel camera is Cynthia.
(assert (= (m cynthia) 1))

; 7. The person who prefers using the Internet Explorer browser is not Kassandra.
(assert (not (= (binv ie) kass)))

; 8. The person who prefers using the Safari browser is Audrey.
(assert (= (binv safari) audrey))

; 9. The photographer with the Canon camera has a camera with more megapixels than Audrey.
(assert (> (m (cinv canon)) (m audrey)))

; Check SAT and get result
(check-sat)
(get-model)
; The output of SAT means there is a solution to the puzzle and it is as follows:
; 1.8 cynthia firefox kodak
; 3.2 audrey safari polaroid
; 4.0 kassandra opera canon
; 7.0 adam internet-expl casio