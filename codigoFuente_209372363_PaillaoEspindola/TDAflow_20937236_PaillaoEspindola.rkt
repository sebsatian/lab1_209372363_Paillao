#lang racket
(require "TDAoption_20937236_PaillaoEspindola.rkt")

(define (flow id name-msg . options)
  ; Eliminar duplicados de las opciones usando una función auxiliar unique-options
  (define (unique-options options)
    (cond
      ((null? options) '()) ; Caso base: lista vacía
      ((member (car options) (cdr options)) ; Si la opción actual está en el resto de la lista
       (unique-options (cdr options))) ; No agregues la opción actual, continúa con el resto
      (else ; La opción actual no está en el resto de la lista
       (cons (car options) (unique-options (cdr options)))))) ; Agrega la opción actual y continúa con el resto

  ; Llamar a unique-options para eliminar duplicados y luego construir el flujo
  (let ((unique-options-list (unique-options options)))
    (append (list id name-msg) unique-options-list)))


; Pertenencia: comprueba si un flujo es una lista con la estructura de un flujo.
(define (flow? flujo)
  (and (list? flujo)
       (number? (car flujo))
       (string? (cadr flujo))
       (list? (cddr flujo))))
; Selectores:
; Selector de id de flujo.
(define (get-flowId flujo)
  (car flujo)
)
; Selector de mensaje de flujo.
(define (get-flowMessage flujo)
  (cadr flujo)
)
; Selector de opciones de flujo.
(define (get-flowOptions flujo)
  (cddr flujo)
)
; Modificadores:
(define (flow-add-option flujo option)
  (if (not (member (get-optionCode option) (map get-optionCode (get-flowOptions flujo))))
      (append flujo (list option))
      flujo)
)
(provide (all-defined-out))
