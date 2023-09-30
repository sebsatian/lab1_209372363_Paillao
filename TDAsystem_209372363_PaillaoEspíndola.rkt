#lang racket

; Representación
; Un system es una lista que comienza con el símbolo 'system y contiene una lista de chatbots.
; Ejemplo: '(system (chatbot1 chatbot2))

; Constructor
(define (create-system chatbots)
  (list 'system chatbots))

; Función de pertenencia
(define (system? x)
  (and (list? x) (eq? (car x) 'system)))

; Selectores
(define (get-chatbots system)
  (cadr system))

; Modificadores
(define (add-chatbot system chatbot)
  (set-cdr! system (cons chatbot (get-chatbots system))))
