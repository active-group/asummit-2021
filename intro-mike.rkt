;; Die ersten drei Zeilen dieser Datei wurden von DrRacket eingefügt. Sie enthalten Metadaten
;; über die Sprachebene dieser Datei in einer Form, die DrRacket verarbeiten kann.
#reader(lib "beginner-reader.rkt" "deinprogramm" "sdp")((modname intro-mike) (read-case-sensitive #f) (teachpacks ((lib "image.rkt" "teachpack" "deinprogramm" "sdp"))) (deinprogramm-settings #(#f write repeating-decimal #f #t none explicit #f ((lib "image.rkt" "teachpack" "deinprogramm" "sdp")))))
(define x (+ 12 23))

(define y
  (* 12
     (* (+ 15
           27)
        29)))
                   
(define circle1 (circle 50 "solid" "gold"))

(define square1 (square 100 "outline" "green"))

(define star1 (star 50 "solid" "blue"))

(define overlay1 (overlay star1 circle1))

; Kommentar

#;(above
 (beside circle1 star1)
 (beside star1 circle1))

#;(above
 (beside square1 circle1)
 (beside circle1 square1))

(above
 (beside image1 image2)
 (beside image2 image1))
