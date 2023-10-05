#lang racket

; Representación: Este TDA representa un usuario del sistema.

; Constructor: Función para crear el usuario
(define (user username); Esta funcion sólo crea un usuario y se usa como herramienta
    (list username);     en la función modificadora system-add-user.
)

; Selectores:
; Selector de nombre del usuario.
(define (get-username user)
    (car user))


(provide (all-defined-out)) 