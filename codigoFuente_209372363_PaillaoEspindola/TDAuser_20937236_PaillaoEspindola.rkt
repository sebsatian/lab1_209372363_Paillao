#lang racket

; Representación: Este TDA representa un usuario del sistema.

; Constructor: Función para crear el usuario con su propio historial de chat.
(define (user username)
    (list username (list))) ; El segundo elemento de la lista será el chatHistory del usuario.

; Selectores:
; Selector de nombre del usuario.
(define (get-username user)
    (car user))

; Selector de historial de chat del usuario.
(define (get-chatHistory user)
    (cadr user))

; Otras funciones:

(provide (all-defined-out))