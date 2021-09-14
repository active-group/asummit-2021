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
      ((string=? pet "snake") #f))))

;(cute? "parakeet")

; Uhrzeit besteht aus / hat folgende Eigenschaften:
; - Stunde
; - Minute
; zusammengesetzte Daten (NICHT: Komposition)