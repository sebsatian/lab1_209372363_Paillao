#lang racket

; Constructor
(define (chatHistory message sender time)
  (list sender message time))

; Selectores
; Obtener el remitente del mensaje
(define (chatHistory-sender chatHistory)
  (car chatHistory))
; Obtener el mensaje
(define (chatHistory-message chatHistory)
  (cadr chatHistory))
; Obtener el tiempo del mensaje
(define (chatHistory-time chatHistory)
  (caddr chatHistory))


; Modificadores
; Agregar un nuevo mensaje al Historial
(define (chatHistory-add chatHistory message sender time)
  (cons (chatHistory message sender time) chatHistory))

; Exportar funciones
(provide (all-defined-out))
