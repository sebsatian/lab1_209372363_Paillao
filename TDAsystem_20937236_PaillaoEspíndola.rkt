#lang racket

; Se importan las funciones del TDA chatbot.
(require "TDAchatbot_20937236_PaillaoEspindola.rkt")

; Representación: Este TDA representa un sistema de chatbots y se ordena en una lista que contiene
; el nombre del sistema, el código inicial del chatbot y una lista de chatbots.

; Constructor: Función para crear el sistema
(define (system name InitialChatbotCodeLink . chatbots)
  (append (list name InitialChatbotCodeLink) chatbots)
)

; Pertenencia: Determina si un elemento pertenece a un sistema, retorna #t si pertenece y #f si no.
(define (system? sistema) 
  (and (list? sistema); Verifica que sea una lista
       (string? (car sistema)); Verifica que el nombre del sistema sea un string
       (number? (cadr sistema)); Verifica que el código inicial del sistema sea un número
       (list? (cddr sistema)); Verifica que la lista de chatbots sea una lista
  )
)

; Selectores:
; Selector de nombre del sistema.
(define (get-systemName sistema)
  (car sistema)
)
; Selector de código inicial del sistema.
(define (get-systemInitialcode sistema)
  (cadr sistema)
)
; Selector de lista de chatbots del sistema.
(define (get-systemChatbot sistema)
  (cddr sistema)
)

; Modificadores: 

  ; Añade un chatbot al sistema

  ;Se crea la función para añadir un chatbot al sistema.
  (define (system-add-chatbot sistema chatbot)
    ; Comprueba si el ID del chatbot ya existe en la lista de IDs de chatbots en el sistema.
  (if (member (get-chatbotId chatbot) (map get-chatbotId (get-systemChatbot sistema))
      )
      sistema; Si el ID del chatbot ya existe en la lista, devuelve el sistema original sin cambios.
      (append sistema (list chatbot); Si el ID del chatbot no existe, añade el chatbot al sistema y devuelve el sistema modificado.
      )
  )
  )