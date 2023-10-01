#lang racket

; Representación
; Un user es una lista que comienza con el símbolo 'user y contiene un nombre, correo y chatHistory.
; Ejemplo: '(user "nombre" "correo" (chat1 chat2))

; Constructor
(define (create-user nombre correo chatHistory)
  (list 'user nombre correo chatHistory))

; Selectores
(define (get-nombre user)
  (cadr user))
(define (get-correo user)
  (caddr user))
(define (get-chatHistory user)
  (cadddr user))

; Modificadores
(define (add-chat user chat)
  (set-cdddr! user (cons chat (get-chatHistory user))))
