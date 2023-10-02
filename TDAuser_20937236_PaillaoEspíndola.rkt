#lang racket

; Representación: Este TDA representa un usuario y se ordena en una lista que contiene
; el nombre del usuario y una lista de mensajes.

; Constructor: Función para crear el usuario
(define (user name . messages)
(append (list name) messages)
)

; Pertenencia: Determina si un elemento pertenece a un usuario, retorna #t si pertenece y #f si no.
(define (user? usuario)
(and (list? usuario); Verifica que sea una lista
(string? (car usuario)); Verifica que el nombre del usuario sea un string
(list? (cdr usuario)); Verifica que la lista de mensajes sea una lista
)
)

; Selectores:
; Selector de nombre del usuario.
(define (get-userName usuario)
(car usuario)
)
; Selector de lista de mensajes del usuario.
(define (get-userMessages usuario)
(cdr usuario)
)

; Modificadores:

; Añade un mensaje al usuario
(define (user-add-message usuario message)
(append usuario (list message))
)

(provide user user? get-userName get-userMessages user-add-message)