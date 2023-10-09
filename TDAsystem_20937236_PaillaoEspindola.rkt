#lang racket

; Se importan las funciones del TDA chatbot.
(require "TDAchatbot_20937236_PaillaoEspindola.rkt")
; Se importan las funciones del TDA user.
(require "TDAuser_20937236_PaillaoEspindola.rkt")
; Se importan las funciones del TDA chatHistory.
(require "TDAchatHistory_20937236_PaillaoEspindola.rkt")
; Se importan las funciones del TDA flow.
(require "TDAflow_20937236_PaillaoEspindola.rkt")
; Se importan las funciones del TDA option.
(require "TDAoption_20937236_PaillaoEspindola.rkt")
; Función auxiliar para verificar si un chatbot ya está en la lista de chatbots.
(define (chatbot-exists? chatbotId chatbots)
  (if (null? chatbots)
      #f
      (if (= chatbotId (get-chatbotId (car chatbots)))
          #t
          (chatbot-exists? chatbotId (cdr chatbots)))))

; Representación: Este TDA representa un sistema de chatbots y se ordena en una lista que contiene
; el nombre del sistema, el código inicial del chatbot, una lista de chatbots y una lista de usuarios.

; Constructor: Función para crear el sistema
(define (system name InitialChatbotCodeLink . chatbots)
  (let ((unique-chatbots (filter (lambda (cb) (not (chatbot-exists? (get-chatbotId cb) chatbots))) chatbots)))
    (append (list name InitialChatbotCodeLink '() '()) unique-chatbots)))



; Pertenencia: Determina si un elemento pertenece a un sistema, retorna #t si pertenece y #f si no.
(define (system? sistema) 
  (and (list? sistema) ; Verifica que sea una lista
       (string? (car sistema)) ; Verifica que el nombre del sistema sea un string
       (number? (cadr sistema)) ; Verifica que el código inicial del sistema sea un número
       (list? (caddr sistema)) ; Verifica que la lista de usuarios sea una lista
       (list? (cadddr sistema)) ; Verifica que la lista de chatHistory sea una lista
       (list? (cddddr sistema)) ; Verifica que la lista de chatbots sea una lista
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
; Selector de lista de usuarios del sistema.
(define (get-systemUsers sistema)
  (caddr sistema)
)
; Selector de lista de chatHistory del sistema.
(define (get-chatHistory sistema)
  (cadddr sistema)
)
; Selector de lista de chatbots del sistema.
(define (get-systemChatbots sistema)
  (cddddr sistema)
)



; Modificadores: 

  ; Añade un chatbot al sistema

  ; Se crea la función para añadir un chatbot al sistema.
  (define (system-add-chatbot sistema chatbot)
   ; Comprueba si el ID del chatbot ya existe en la lista de IDs de chatbots en el sistema.
  (if (member (get-chatbotId chatbot) (map get-chatbotId (get-systemChatbots sistema))
      )
      sistema; Si el ID del chatbot ya existe en la lista, devuelve el sistema original sin cambios.
      (append sistema (list chatbot)); Si el ID del chatbot no existe, añade el chatbot al sistema y devuelve el sistema modificado.
  )
  )

  ; Añade un usuario al sistema
(define (system-add-user sistema username)
  ; Crea un nuevo usuario
  (define new-user (user username))
  ; Comprueba si el usuario ya existe en la lista de usuarios en el sistema.
  (if (member username (map get-username (get-systemUsers sistema)))
      sistema ; Si el usuario ya existe en la lista, devuelve el sistema original sin cambios.
       ; Si el usuario no existe, añade el usuario al sistema y devuelve el sistema modificado.
      (list (get-systemName sistema) (get-systemInitialcode sistema) (append (get-systemUsers sistema) (list new-user)) (get-systemChatbots sistema))
  )
)

; Funcion de login.

; Funcion auxiliar selectora de usuario logeado actual, para verificar si ya hay un usuario logeado o no.
(define (get-currentUser sistema)
  (if (list? (caddr sistema))
      '()
      (caddr sistema)
  )
)

; Funcion para logear un usuario, requiere el nombre del sistema y el username.
; Funcion para logear un usuario, requiere el nombre del sistema y el username.
(define (system-login sistema username)
  ; Comprueba si el usuario ya existe en la lista de usuarios en el sistema.
  (if (and (member username (map get-username (get-systemUsers sistema))) (null? (get-currentUser sistema)))
      ; Si el usuario existe y no hay otro usuario logeado, establece al usuario como el usuario actual del sistema.
      (let ((new-chatHistory (cons (list username "logged in") (get-chatHistory sistema))))
        ; Añade una entrada al chatHistory para registrar que el usuario ha iniciado sesión.
        (list (get-systemName sistema) (get-systemInitialcode sistema) (get-systemUsers sistema) username new-chatHistory (get-systemChatbots sistema)))
      ; Si el usuario no existe o ya hay otro usuario logeado, devuelve el sistema original sin cambios.
      sistema
  )
)
  
; Función para deslogear al user con su sesión iniciada.
(define (system-logout sistema)
  ; Rescata todo lo del sistema exceptuando al usuario para devolver una lista sin él.
  (define systemName (get-systemName sistema))
  (define initialCode (get-systemInitialcode sistema))
  (define chatBots (get-systemChatbots sistema))  ; Aquí se modificó 'chatBot' a 'chatBots' para reflejar que es una lista de chatbots.
  (define currentUser (get-currentUser sistema))
  (define new-chatHistory (cons (list currentUser "logged out") (get-chatHistory sistema)))
  ; Añade una entrada al chatHistory para registrar que el usuario ha cerrado sesión.
  (list systemName initialCode (get-systemUsers sistema) #f new-chatHistory chatBots)
)
; Otras funciones

; Función para encontrar un chatbot en la lista de chatbots del sistema por su ID.
(define (find-chatbot sistema chatbotId)
  (let ((chatbots (get-systemChatbots sistema)))
    (cond ((null? chatbots) #f)
          ((= chatbotId (get-chatbotId (car chatbots))) (car chatbots)) 
          (else (find-chatbot (cdr chatbots) chatbotId))
    )
  )
)

; Funcion para comprobar si hay un usuario loggeado.
(define (logged? sistema)
  (not (null? (get-currentUser sistema)))
)

; Función get-all-options: Toma un sistema y retorna las opciones de todos los flujos del chatbot actual.

(define (get-all-options sistema)
  (if (not (logged? sistema)) ; Comprueba si hay un usuario conectado.
      (error "No hay ningún usuario conectado.") ; Si no hay ningún usuario conectado, lanza un error.
      (let ((chatbot (get-currentChatbot sistema)) ; Obtiene el chatbot actual del sistema.
            (flows (get-chatbotFlows chatbot))) ; Obtiene todos los flujos del chatbot actual.
        (map get-flowOptions flows) ; Aplica la función get-flowOptions a cada flujo, devolviendo una lista de listas de opciones.
      )
  )
)
; Función get-all-chatbots: Toma un sistema y retorna todos los chatbots en ese sistema.
(define (get-all-chatbots system)
  (cdddr system) ; Los chatbots son todos los elementos después del tercer elemento del sistema.
)

; Función get-chatbot-by-flow: Toma un sistema y un flujo y retorna el chatbot que contiene ese flujo.
(define (get-chatbot-by-flow system flow)
  (let ((chatbots (get-all-chatbots system))) ; Obtiene todos los chatbots del sistema.
    (let ((matching-chatbots (filter (lambda (chatbot) (member flow (get-chatbotFlows chatbot))) chatbots))) ; Busca los chatbots que contienen el flujo.
      (if (null? matching-chatbots)
          (error "No hay ningún chatbot que contenga ese flujo.")
          (car matching-chatbots) ; Retorna el primer chatbot que contiene el flujo (asumiendo que solo puede haber uno).
      )
    )
  )
)

; Función get-currentChatbot: Toma un sistema y retorna el chatbot actual del sistema segun.
(define (get-currentChatbot sistema)
  (let ((chatbots (get-systemChatbots sistema)) ; Obtiene la lista de chatbots del sistema
        (initialCode (get-systemInitialcode sistema))) ; Obtiene el InitialChatbotCodeLink del sistema
    (car (filter (lambda (cb) (= (get-startFlowId cb) initialCode)) chatbots)))) ; Busca y retorna el chatbot cuyo InitialCode es igual al InitialChatbotCodeLink

; Función set-currentChatbot: Toma un sistema y un chatbot y devuelve un nuevo sistema con el chatbot actualizado.
(define (set-currentChatbot system new-chatbot)
  (cons (car system) (cons new-chatbot (cddr system))) ; Asume que el chatbot actual es el segundo elemento del sistema.
)




(define (system-talk-rec system message)
  (if (not (logged? system))
      (error "No hay ningún usuario conectado.")
      (let ((options (get-all-options system))) ; Obtiene todas las opciones de todos los flujos del chatbot actual.
        (if (string->number message)
            (let ((matching-options (filter (lambda (option) (equal? (get-optionCode option) (string->number message))) options))) ; Busca las opciones cuyo código coincide con el mensaje.
              (if (null? matching-options)
                  (error "No hay ninguna opción que coincida con el mensaje.")
                  (let ((chosen-option (car matching-options))) ; Toma la primera opción que coincide (asumiendo que solo puede haber una).
                    (let ((next-flow (get-CbCodeLink chosen-option))) ; Obtiene el flujo al que lleva la opción.
                      (if (null? next-flow)
                          (let ((response (get-optionMessage chosen-option))) ; Si el flujo es nulo, devuelve el mensaje de la opción.
                            (chatHistory-add (get-chatHistory system) response "system" (current-seconds)) ; Agrega el mensaje al historial de chat.
                            (list response)
                          )
                          (let ((new-chatbot (get-chatbot-by-flow system next-flow))) ; Obtiene el chatbot por su flujo.
                            (set-currentChatbot system new-chatbot) ; Actualiza el chatbot actual del sistema con el nuevo chatbot.
                            (chatHistory-add (get-chatHistory system) message (get-currentUser system) (current-seconds)) ; Agrega el mensaje al historial de chat.
                            system ; Retorna el sistema actualizado.
                          )
                      )
                    )
                  )
              )
            )
            (let ((matching-options (filter (lambda (option) (member message (get-optionKeywords option))) options))) ; Busca las opciones cuyas palabras clave coinciden con el mensaje.
              (if (null? matching-options)
                  (error "No hay ninguna opción que coincida con el mensaje.")
                  (let ((chosen-option (car matching-options))) ; Toma la primera opción que coincide (asumiendo que solo puede haber una).
                    (let ((next-flow (get-CbCodeLink chosen-option))) ; Obtiene el flujo al que lleva la opción.
                      (if (null? next-flow)
                          (let ((response (get-optionMessage chosen-option))) ; Si el flujo es nulo, devuelve el mensaje de la opción.
                            (chatHistory-add (get-chatHistory system) response "system" (current-seconds)) ; Agrega el mensaje al historial de chat.
                            (list response)
                          )
                          (let ((new-chatbot (get-chatbot-by-flow system next-flow))) ; Obtiene el chatbot por su flujo.
                            (set-currentChatbot system new-chatbot) ; Actualiza el chatbot actual del sistema con el nuevo chatbot.
                            (chatHistory-add (get-chatHistory system) message (get-currentUser system) (current-seconds)) ; Agrega el mensaje al historial de chat.
                            system ; Retorna el sistema actualizado.
                          )
                      )
                    )
                  )
              )
            )
        )
      )
  )
)
(provide (all-defined-out))
