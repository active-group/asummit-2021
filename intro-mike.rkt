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

; Uhrzeit besteht aus / hat folgende Eigenschaften:
; - Stunde UND
; - Minute
; zusammengesetzte Daten
(define-record time
  make-time ; Konstruktor
  (time-hour natural) ; Selektoren, Getter-Funktion
  (time-minute natural))

(: make-time (natural natural -> time))
(: time-hour (time -> natural))
(: time-minute (time -> natural))

(define time1 (make-time 11 24)) ; 11 Uhr 24
(define time2 (make-time 23 45))

; Minuten seit Mitternacht
(: msm (time -> natural))

(check-expect (msm time1)
              684)
(check-expect (msm time2)
              (+ (* 23 60) 45))

; Schablone
#;(define msm
  (lambda (time)
    ...
    (time-hour time)
    (time-minute time)
    ...
    ))
              
(define msm
  (lambda (time)
    (+ (* 60 (time-hour time))
       (time-minute time))))

; Aus Minuten seit Mitternacht die Zeit berechnen
(: msm->time (natural -> time))

(check-expect (msm->time (msm time1)) time1)
(check-expect (msm->time (msm time2)) time2)

(define msm->time
  (lambda (minutes)
    (make-time (quotient minutes 60)
               (remainder minutes 60))))

; Ein Tier (auf dem texanischen Highway) ist eins der folgenden:
; - Gürteltier ODER
; - Papagei
; Fallunterscheidung
; gemischte Daten
(define animal
  (signature (mixed dillo parrot)))

; Ein Gürteltier hat folgende Eigenschaften
; - lebendig oder tot
; - Gewicht
; zusammengesetzte Daten
(define-record dillo
  make-dillo
  dillo? ; Prädikat
  (dillo-alive? boolean)
  (dillo-weight number))

; Ist das Objekt ein Gürteltier?
(: dillo? (any -> boolean))

(define dillo1 (make-dillo #t 10)) ; lebendiges Gürteltier, 10kg
(define dillo2 (make-dillo #f 8)) ; totes Gürteltier, 8kg

; Gürteltier überfahren
(: run-over-dillo (dillo -> dillo))

(check-expect (run-over-dillo dillo1)
              (make-dillo #f 10))
(check-expect (run-over-dillo dillo2)
              dillo2
              #;(make-dillo #f 8))

(define run-over-dillo
  (lambda (dillo)
    (make-dillo #f (dillo-weight dillo))))


; Ein Papagei hat folgende Eigenschaften:
; - Satz (kann sprechen)
; - Gewicht
; zusammengesetzte Daten
(define-record parrot
  make-parrot
  parrot?
  (parrot-sentence string)
  (parrot-weight number))

(: parrot? (any -> boolean))
   
(define parrot1 (make-parrot "Hello!" 2))
(define parrot2 (make-parrot "Goodbye!" 1))

; Papagei überfahren
(: run-over-parrot (parrot -> parrot))

(check-expect (run-over-parrot parrot1)
              (make-parrot "" 2))

(define run-over-parrot
  (lambda (parrot)
    (make-parrot "" (parrot-weight parrot))))

; Tier überfahren
(: run-over-animal (animal -> animal))

(check-expect (run-over-animal dillo1)
              (run-over-dillo dillo1))
(check-expect (run-over-animal parrot1)
              (run-over-parrot parrot1))

(define run-over-animal
  (lambda (animal)
    (cond
      ((dillo? animal) (run-over-dillo animal))
      ((parrot? animal) (run-over-parrot animal)))))


; Wenn eine neue Sorte Tiere dazukommt, muß run-over-animal geändert werden :-(

; In OO müssen Klassen geändert werden, wenn Operationen hinzukommen.

; Expression Problem

; interface Animal { void runOver(); }
; class Dillo implements Animal { ... }
; class Parrot implements Animal { ... }
; class Tarantula implements Animal { ... }
; animal instanceof Parrot

; Eine Liste ist eins der folgenden:
; - die leere Liste
; - eine Cons-Liste bestehend aus erstem Element und Rest-Liste
(define list-of-numbers
  (signature (mixed empty-list cons-list)))

; Die leere Liste ...
(define-record empty-list
  make-empty-list
  empty?) ; keine Felder / Selektoren

(define empty (make-empty-list))

; Eine Cons-Liste besteht aus:
; - erstes Element
; - Rest-Liste
(define cons-list
  cons
  cons?
  (first number)
  (rest list-of-numbers))



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