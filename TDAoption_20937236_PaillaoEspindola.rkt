#lang racket

; Representación: Este TDA representa una opción para el flujo de un chatbot y se ordena en una lista que contiene
; el código de la opción, el mensaje, el código del chatbot, el código del flujo inicial y una lista de palabras clave.

; Constructor: Función para crear la opción
(define (option code message chatbotCodeLink initialFlowCodeLink . keywords)
  (append (list code message chatbotCodeLink initialFlowCodeLink) keywords)
)

; Pertenencia: Determina si un elemento pertenece a una opción, retorna #t si pertenece y #f si no.
(define (option? opcion) 
  (and (list? opcion); Verifica que sea una lista
       (number? (car opcion)); Verifica que el código de la opción sea un número
       (string? (cadr opcion)); Verifica que el mensaje sea un string
       (number? (caddr opcion)); Verifica que el código del chatbot sea un número
       (number? (cadddr opcion)); Verifica que el código del flujo inicial sea un número
       (list? (cddddr opcion)); Verifica que la lista de palabras clave sea una lista
  )
)

; Selectores:
; Selector del código de la opción.
(define (get-optionCode opcion)
  (car opcion)
)
; Selector del mensaje de la opción.
(define (get-optionMessage opcion)
  (cadr opcion)
)
; Selector del código del chatbot.
(define (get-CbCodeLink opcion)
  (caddr opcion)
)
; Selector del código del flujo inicial.
(define (get-flowCode opcion)
  (cadddr opcion)
)
; Selector de la lista de palabras clave.
(define (get-optionKeywords opcion)
  (cddddr opcion)
)

(provide (all-defined-out))