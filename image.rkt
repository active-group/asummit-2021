;; Die ersten drei Zeilen dieser Datei wurden von DrRacket eingefügt. Sie enthalten Metadaten
;; über die Sprachebene dieser Datei in einer Form, die DrRacket verarbeiten kann.
#reader(lib "beginner-reader.rkt" "deinprogramm" "sdp")((modname image) (read-case-sensitive #f) (teachpacks ((lib "image.rkt" "teachpack" "deinprogramm" "sdp"))) (deinprogramm-settings #(#f write repeating-decimal #f #t none explicit #f ((lib "image.rkt" "teachpack" "deinprogramm" "sdp")))))
(define x
  (+ 12
     (* 23 42)))

(define star1 (star 50 "solid" "green"))
(define circle1 (circle 50 "solid" "red"))
(define square1 (square 100 "outline" "blue"))

(define overlay1 (overlay star1 circle1))
(define overlay2 (overlay circle1 square1))

(above
 (beside star1 circle1)
 (beside circle1 star1))

(above
 (beside circle1 square1)
 (beside square1 circle1))

(above
 (beside image1 image2)
 (beside image2 image1))
