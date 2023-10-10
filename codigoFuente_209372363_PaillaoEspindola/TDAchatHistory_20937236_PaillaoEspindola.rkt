#lang racket

; Constructor
(define (chatHistory sender message option)
  (list sender message option))

; Selectores
; Obtener el remitente del mensaje
(define (chatHistory-sender chatHistory)
  (car chatHistory))
; Obtener el mensaje
(define (chatHistory-message chatHistory)
  (cadr chatHistory))
; Obtener la opción
(define (chatHistory-option chatHistory)
  (cadddr chatHistory))

; Modificadores
; Agregar un nuevo mensaje al Historial
; Función para agregar un mensaje al historial de chat del usuario.
(define (chatHistory-add chatHistory sender message option)
  (cons (chatHistory sender message option) chatHistory)) 

; Exportar funciones
(provide (all-defined-out))