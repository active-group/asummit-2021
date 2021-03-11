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

; Konstruktionsanleitungen

; Schritt 1: Kurzbeschreibung
; Zwei Bilder in quadratischem Kachelmuster anordnen
; Signaturdeklaration:
(: tile (image image -> image))
; dort Signatur (image image -> image)

; Testfall

(define tile
  (lambda (image1 image2)
    (above
     (beside image1 image2)
     (beside image2 image1))))

;(tile star1 overlay1)

; Ein Haustier ist eins der folgenden:
; - Hund ODER
; - Katze ODER
; - Schlange
; Fallunterscheidung
; Spezialfall: Aufzählung
(define pet
  (signature (enum "dog" "cat" "snake")))

; Ist ein Haustier niedlich?
(: cute? (pet -> boolean))

(check-expect (cute? "dog") #t) ; "true"
(check-expect (cute? "cat") #t)
(check-expect (cute? "snake") #f)

; Schablone
#;(define cute?
  (lambda (pet)
    (cond ; Verzweigung, 1 Zweig pro Fall
      ; jeder Zweig (Bedingung Ergebnis)      
      ((string=? pet "dog") ...)
      ((string=? pet "cat") ...)
      ((string=? pet "snake") ...))))

(define cute?
  (lambda (pet)
    (cond ; Verzweigung, 1 Zweig pro Fall
      ; jeder Zweig (Bedingung Ergebnis)      
      ((string=? pet "dog") #t)
      ((string=? pet "cat") #t)
      ((string=? pet "snake") #f)
      #;(else #f))))

  ;(cute? "parakeet")

; Uhrzeit:
; Stunde
; Minute
  
#|

In Java/OO-Sprachen:
Eine Variable steht für eine Speicherzelle, in der ein Wert drinsteht.

class C {
  int m(int x) {
    x
    x = 12;
    ...
    x
  }
}

|#