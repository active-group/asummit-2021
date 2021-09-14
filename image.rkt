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

; Kommentar

#;(above
 (beside star1 circle1)
 (beside circle1 star1))

#;(above
 (beside circle1 square1)
 (beside square1 circle1))

; Konstruktionsanleitungen für eine Funktion
; 1. Schritt: Kurzbeschreibung

; Quadratisches Kachelmuster erzeugen
; 2. Schritt: Signaturdeklaration
(: tile (image image -> image))

; 3. Schritt: Tests
; ...

; 4. Schritt: Funktionsdefinition
(define tile
  (lambda (image1 image2)
    (above
     (beside image1 image2)
     (beside image2 image1))))

#;(tile circle1 star1)

#|

class C {
  static int m(int x) {
     x = 18;
     ... x ...
     x = 19;
     ... x ...
  }

  ...
  C.m(17)
  ...
}

In Java:
Variable steht für eine Speicherzelle, deren Inhalt ausgetauscht werden kann.

In funktionalen Sprachen:
Variable steht für einen Wert => Substitution zulässig / Mathematik 

|#

; Datenmodellierung

; 1. Schritt: Datendefinition

; Haustier ist eins der folgenden:
; - Hund - ODER -
; - Katze - ODER -
; - Schlange
; Fallunterscheidung
; Spezialfall: Aufzählung

; 2. Schritt: -> Code
(define pet
  (signature (enum "dog" "cat" "snake")))

; Ist ein Haustier niedlich?
(: cute? (pet -> boolean))

(check-expect (cute? "dog") #t)
(check-expect (cute? "cat") #t)
(check-expect (cute? "snake") #f)

; Gerüst
#;(define cute?
  (lambda (pet)
    ...))

; Schablone
#;(define cute?
  (lambda (pet)
    ; Schablone
    ; für Fallunterscheidungen: Verzweigung, einen Zweig pro Fall
    ; jeder Zweig: Bedingung, Antwort
    (cond
      ((string=? pet "dog") ...)
      ((string=? pet "cat") ...)
      ((string=? pet "snake") ...))))

(define cute?
  (lambda (pet)
    ; Schablone
    ; für Fallunterscheidungen: Verzweigung, einen Zweig pro Fall
    ; jeder Zweig: Bedingung, Antwort
    (cond
      ((string=? pet "dog") #t)
      ((string=? pet "cat") #t)
      ((string=? pet "snake") #f)
      #;(else #t))))

;(cute? "parakeet")

; Uhrzeit besteht aus / hat folgende Eigenschaften:
; - Stunde
; - Minute
; zusammengesetzte Daten (NICHT: Komposition)
(define-record time ; Signatur
  make-time ; Konstruktor
  (time-hour natural) ; Selektor + Signatur Feld
  (time-minute natural))

; natural: natürliche Zahl, "Zählzahl", 0,1,2,3,4,...
(: make-time (natural natural -> time))
(: time-hour (time -> natural))
(: time-minute (time -> natural))

; 12 Uhr 24
(define time1 (make-time 12 24))
; 5 Uhr 6
(define time2 (make-time 5 06))

; Minuten seit Mitternacht
(: msm (time -> natural))

(check-expect (msm time1) (+ (* 12 60) 24))
(check-expect (msm time2) (+ (* 5 60) 6))

(define msm
  (lambda (time)
    (+ (* (time-hour time) 60)
       (time-minute time))))

; Minuten seit Mitternacht in Uhrzeit umwandeln
(: msm->time (natural -> time))

(check-expect (msm->time (+ (* 5 60) 6)) time2)

(define msm->time
  (lambda (msm)
    (make-time (quotient msm 60)
               (remainder msm 60))))

; Ein Gürteltier hat folgende Eigenschaften:
; - lebendig oder tot - UND -
; - Gewicht
; eigentlich: Zustand des Gürteltiers zu einem bestimmten Zeitpunkt
(define-record dillo
  make-dillo
  (dillo-alive? boolean)
  (dillo-weight number))

; lebendiges Gürteltier, 10kg
(define dillo1 (make-dillo #t 10))
; totes Gürteltier, 12kg
(define dillo2 (make-dillo #f 12))

; objektorientiert: (dillo -> void)

; Gürteltier
(: run-over-dillo (dillo -> dillo))

(check-expect (run-over-dillo dillo1) (make-dillo #f 10))
(check-expect (run-over-dillo dillo2)
              dillo2)

(define run-over-dillo
  (lambda (dillo)
    (make-dillo #f (dillo-weight dillo))))

; Ein Papagei hat folgende Eigenschaften:
; - Satz
; - Gewicht
(define-record parrot
  make-parrot
  (parrot-sentence string)
  (parrot-weight number))

; Papagei, begrüßt immer, 1kg
(define parrot1 (make-parrot "Hallo!" 1))
; dicker Papagei, verabschiedet
(define parrot2 (make-parrot "Tschüß!" 2))

; Papagei überfahren
(: run-over-parrot (parrot -> parrot))

(check-expect (run-over-parrot parrot1) (make-parrot "" 1))

(define run-over-parrot
  (lambda (parrot)
    (make-parrot "" (parrot-weight parrot))))

; Ein Tier (auf dem texanischen Highway) ist eins der folgenden:
; - Gürteltier - ODER -
; - Papagei
; gemischte Daten
(define animal
  (signature (mixed dillo parrot)))

; Tier überfahren
(: run-over-animal (animal -> animal))

(check-expect (run-over-animal dillo1)
              (run-over-dillo dillo1))
(check-expect (run-over-animal parrot1)
              (run-over-parrot parrot1))

(define run-over-animal
  (lambda (animal)
    (cond
     (... ...)
     (... ...))))