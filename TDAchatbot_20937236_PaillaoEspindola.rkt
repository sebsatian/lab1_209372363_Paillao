#lang racket

; Se importan las funciones del TDA chatbot.
(require "TDAchatbot_20937236_PaillaoEspindola.rkt")
; Se importan las funciones del TDA user.

; Función auxiliar para verificar si un flujo ya está en la lista de flujos de un chatbot.
(define (flow-exists? flowId flows)
  (if (null? flows)
      #f
      (if (= flowId (get-flowId (car flows)))
          #t
          (flow-exists? flowId (cdr flows)))))

; Constructor: Función para crear el chatbot
(define (chatbot chatbotId name welcomeMessage InitialFlowCodeLink . flows)
  (let ((unique-flows (filter (lambda (f) (not (flow-exists? (get-flowId f) flows))) flows)))
    (append (list chatbotId name welcomeMessage InitialFlowCodeLink '() ) unique-flows))
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
(define (get-chatbotFlows chatbot)
    (cddddr chatbot)
)


; Modificadores: 
; Añade flujos al final de la lista de flujos de un chatbot.
(define (chatbot-add-flow chatbot flows); Devuelve una nueva lista chatbot con los flujos añadidos
  (define (recursion chatbot flowAux); Funcion RECURSIVA DE COLA que añaade los flujos a la lista de flujos del chatbot
    (if (null? flowAux); CASO BASE: Si no quedan flujos por añadir, devuelve el chatbot
        chatbot
        (let ((flow (car flowAux))); Si quedan flujos, se añade el primero a la lista de flujos del chatbot
          (if (member (get-flowId flow) (map get-flowId (get-chatbotFlows chatbot))); Condicional para comparar Id´s de flujos
              (recursion chatbot (cdr flowAux)); Si el flujo ya existe, se llama a la funcion recursiva con el resto de flujos.
              ; Si el flujo no existe, se llama a la funcion recursiva con el resto de flujos y se añade el flujo al chatbot
              (recursion (list (get-chatbotId chatbot) (get-chatbotName chatbot) (get-chatbotWelcomeMessage chatbot) (get-chatbotStartFlowId chatbot) (append (get-chatbotFlows chatbot) (list flow))) (cdr flowAux))
          )
        )
    )
  )
  ; Llamado recursivo que caracteriza a la recursión de cola, por ser la última operación realizada.
  (recursion chatbot flows)
)

;  Exportar funciones:
(provide get-chatbotId)
