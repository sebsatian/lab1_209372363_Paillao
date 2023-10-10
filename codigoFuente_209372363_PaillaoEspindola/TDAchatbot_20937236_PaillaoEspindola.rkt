#lang racket

; Se importa TDA flow para poder usarlo en la lista de flujos de un chatbot.
(require "TDAflow_20937236_PaillaoEspindola.rkt")

; Función auxiliar para verificar si un flujo ya está en la lista de flujos de un chatbot.
(define (flow-exists? flowId flows)
  (cond 
    ((null? flows) #f) ; Si no hay flujos, retorna falso
    ((= flowId (get-flowId (car flows))) #t) ; Si el ID del flujo actual coincide con flowId, retorna verdadero
    (else (flow-exists? flowId (cdr flows))) ; De lo contrario, verifica el resto de los flujos
  )
)

(define (chatbot chatbotId name welcomeMessage InitialFlowCodeLink . flows)
  ; Función auxiliar para eliminar duplicados de flujos usando una lista acumulativa
  (define (unique-flows flows accum)
    (cond
      ((null? flows) accum)
      ((flow-exists? (get-flowId (car flows)) accum) 
       (unique-flows (cdr flows) accum))
      (else 
       (unique-flows (cdr flows) (cons (car flows) accum)))))

  ; Retorna el chatbot con flujos únicos
  (append (list chatbotId name welcomeMessage InitialFlowCodeLink) (unique-flows flows '())))

; Pertenencia: Verifica si es un chatbot.
(define (chatbot? chatbot)
  (and (list? chatbot)
       (number? (car chatbot))
       (string? (cadr chatbot))
       (string? (caddr chatbot))
       (number? (cadddr chatbot))
       (list? (cddddr chatbot))))

; Selector Id: Obtiene el identificador del chatbot.
(define (get-chatbotId chatbot)
  (if (and (list? chatbot) (>= (length chatbot) 1) (number? (car chatbot)))
      (car chatbot)
      #f))

; Selector Name: Obtiene el nombre del chatbot.
(define (get-chatbotName chatbot)
  (cadr chatbot))

; Selector Welcome Message: Obtiene el mensaje de bienvenida del chatbot.
(define (get-welcomeMessage chatbot)
  (caddr chatbot))

; Selector Initial Flow: Obtiene el identificador del flujo inicial del chatbot.
(define (get-startFlowId chatbot)
  (if (and (list? chatbot) (>= (length chatbot) 4) (number? (cadddr chatbot)))
      (cadddr chatbot)
      #f))

; Selector Flows: Obtiene la lista de flujos asociados al chatbot.
(define (get-chatbotFlows chatbot)
  (cond
    ((and (list? chatbot) (>= (length chatbot) 5))
     (cddddr chatbot))
    (else
     '())))

; Función para añadir un flujo a un chatbot.
(define (chatbot-add-flow chatbot flow)
  ; Función auxiliar add-flow-to-flows. Esta es una función recursiva de cola que itera a través de los flujos existentes
  ; y añade el nuevo flujo solo si no existe ya.
  (define (add-flow-to-flows flows flow)
    (cond
      ; Caso base: si no quedan más flujos para verificar, retorna el flujo dado como una lista
      ((null? flows) (list flow))
      ; Si el flujo dado ya existe en los flujos, retorna los flujos sin cambios
      ((flow-exists? (get-flowId flow) flows) flows)
      ; Paso recursivo de cola: si el flujo no existe en los flujos, añade el flujo al principio de los flujos y
      ; realiza una llamada recursiva con el resto de los flujos. Se usa recursión de cola aquí para aprovechar su 
      ; eficiencia en el uso de la memoria y porque es un enfoque común en el paradigma funcional para iterar a través de listas.
      (else (cons (car flows) (add-flow-to-flows (cdr flows) flow)))))
  
  ; Llama a la función auxiliar con los flujos del chatbot y añade el flujo resultante a la información existente del chatbot.
  (list (get-chatbotId chatbot)
        (get-chatbotName chatbot)
        (get-welcomeMessage chatbot)
        (get-startFlowId chatbot)
        (add-flow-to-flows (get-chatbotFlows chatbot) flow)))

; Exportar funciones:
(provide (all-defined-out))
