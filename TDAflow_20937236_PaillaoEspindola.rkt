#lang racket
; Se importan las funciones de TDA option.
(require "TDAoption_20937236_PaillaoEspindola.rkt")
; Representación: Este TDA representa un flujo de un chatbot y se ordena en una lista que contiene
; el ID del flujo, el mensaje del flujo y una lista de opciones.

; Constructor: Función para crear el flujo
(define (flow id name-msg . options)
(append (list id name-msg) options)
)

; Pertenencia: Determina si un elemento pertenece a un flujo, retorna #t si pertenece y #f si no.
(define (flow? flujo)
(and (list? flujo); Verifica que sea una lista
(number? (car flujo)); Verifica que el ID del flujo sea un número
(string? (cadr flujo)); Verifica que el mensaje del flujo sea un string
(list? (cddr flujo)); Verifica que la lista de opciones sea una lista
)
)

; Selectores:
; Selector del ID del flujo.
(define (get-flowId flujo)
(car flujo)
)
; Selector del mensaje del flujo.
(define (get-flowMessage flujo)
(cadr flujo)
)
; Selector de la lista de opciones del flujo.
(define (get-flowOptions flujo)
(cddr flujo)
)

; Modificadores:

; Añade una opción al flujo
(define (flow-add-option flujo option)
  (if (not (member (get-optionCode option) (map get-optionCode (get-flowOptions flujo))))
      (append flujo (list option))
      flujo
  )
)
(provide flow flow? get-flowId get-flowMessage get-flowOptions flow-add-option)