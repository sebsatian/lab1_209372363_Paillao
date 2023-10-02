#lang racket
; Representación: Este TDA representa un chatbot, el cual tiene un nombre y una lista de opciones.

; Constructor: para un chatbot. Toma un nombre y una lista opcional de opciones.
(define (chatbot chatbotID name welcomeMessage startFlowId . flows)
 (append (list chatbotID name welcomeMessage startFlowId) flows)
)

; Pertenencia: Verifica si es un chatbot, retorna #t si lo es, #f en caso contrario.
(define (chatbot? chatbot)
    (and (list? chatbot); Comprueba que sea una lista.
         (number? (car chatbot)); Comprueba que el id sea un número.
         (string? (cadr chatbot)); Comprueba que el nombre sea un string.
         (string? (caddr chatbot)); Comprueba que el mensaje de bienvenida sea un string.
         (number? (cadddr chatbot)) ; Comprueba que el id del flujo inicial sea un número.
         (list? (cddddr chatbot)); Comprueba que la lista de flujos sea una lista.
    )
)

; Selectores: 
; Selector Id: Toma un chatbot y retorna su id.
(define (get-chatbotId chatbot)
    (car chatbot)
)
; Selector Name: Toma un chatbot y retorna su nombre.
(define (get-chatbotName chatbot)
    (cadr chatbot)
)
; Selector Welcome Message: Toma un chatbot y retorna su mensaje de bienvenida.
(define (get-welcomeMessage chatbot)
    (caddr chatbot)
)
; Selector initial flow: Toma un chatbot y retorna el id del flujo inicial.
(define (get-startFlowId chatbot)
    (cadddr chatbot)
)
; Selector flows: Toma un chatbot y retorna la lista de flujos.
(define (get-flows chatbot)
    (cddddr chatbot)
)

;  Exportar funciones:
(provide get-chatbotId)
