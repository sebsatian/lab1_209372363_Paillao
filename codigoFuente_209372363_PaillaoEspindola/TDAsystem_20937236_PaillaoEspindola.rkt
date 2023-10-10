#lang racket
(require "TDAchatHistory_20937236_PaillaoEspindola.rkt") ; Se importan las funciones del TDA chatHistory.
(require "TDAuser_20937236_PaillaoEspindola.rkt") ; Se importan las funciones del TDA user.
(require "TDAflow_20937236_PaillaoEspindola.rkt") ; Se importan las funciones del TDA flow.
(require "TDAoption_20937236_PaillaoEspindola.rkt") ; Se importan las funciones del TDA option.
(require "TDAchatbot_20937236_PaillaoEspindola.rkt") ; Se importan las funciones del TDA chatbot.
; Función auxiliar para verificar si un chatbot ya está en la lista de chatbots.}

(define (chatbot-exists? chatbotId chatbots)
  (if (null? chatbots)
      #f
      (if (= chatbotId (get-chatbotId (car chatbots)))
          #t
          (chatbot-exists? chatbotId (cdr chatbots)))))

; Representación: Este TDA representa un sistema de chatbots y se ordena en una lista que contiene
; el nombre del sistema, el código inicial del chatbot, una lista de chatbots y una lista de usuarios.


; Constructor:
(define (system name initialChatbotCodeLink . chatbots)
  (define (unique-chatbots chatbots uniqueChatbots)
    (if (null? chatbots)
        uniqueChatbots
        (let ([chatbot (car chatbots)])
          (if (not (chatbot-exists? (get-chatbotId chatbot) uniqueChatbots))
              (unique-chatbots (cdr chatbots) (append uniqueChatbots (list chatbot)))
              (unique-chatbots (cdr chatbots) uniqueChatbots)))))
  (let ((uChatbots (unique-chatbots chatbots '())))
    (list name initialChatbotCodeLink uChatbots '() '()))
)

; Selectores:
; Selector de nombre del sistema.
(define (get-systemName system)
  (car system)
)

; Selector para el chatbot inicial del sistema.
(define (get-systemInitialcode system)
  (cadr system)
)

; Selector de lista de usuarios del sistema.
(define (get-systemUsers system)
  (caddr system)
)

; Selector de usuario actualmente logueado en el sistema.
(define (get-currentUser system)
  (cadddr system)
)

; Selector de chatbots del sistema.
(define (get-systemChatbots system)
  (if (>= (length system) 5) ; Asegurarse de que la lista tiene al menos 5 elementos
      (let ((lst (cddddr system)))
        (if (null? lst)
            '()
            (car lst)))
      '() ; Si no tiene suficientes elementos, devuelve una lista vacía
      ))


; Modificadores: 

  ; Añade un chatbot al sistema

  ; Se crea la función para añadir un chatbot al sistema.
(define (system-add-chatbot sistema chatbot)
  (let ((chatbotId (get-chatbotId chatbot))
        (existingChatbots (get-systemChatbots sistema)))
    (if (member chatbotId (map get-chatbotId existingChatbots))
        sistema
        (list (get-systemName sistema) (get-systemInitialcode sistema) (get-systemUsers sistema) (get-currentUser sistema) (append existingChatbots (list chatbot)))
    )
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

; Función para iniciar sesión con un usuario, requiere el sistema y el nombre de usuario.
(define (system-login sistema username)
  ; Si el nombre de usuario existe en la lista de usuarios del sistema y
  ; no hay ningún usuario logueado actualmente (es decir, currentUser es null),
  ; entonces establece al usuario como el usuario actualmente logueado.
  (if (and (member username (map get-username (get-systemUsers sistema))) (null? (get-currentUser sistema)))
      ; Retorna una nueva lista que es idéntica al sistema original, pero con el currentUser cambiado al nombre de usuario proporcionado.
      (list 
       (get-systemName sistema) ; nombre del sistema
       (get-systemInitialcode sistema) ; código inicial del sistema
       (get-systemUsers sistema) ; lista de usuarios del sistema
       username ; nombre de usuario que ahora está loggeado
       (get-systemChatbots sistema) ; lista de chatbots del sistema
       )

      ; Si el nombre de usuario no existe en la lista de usuarios del sistema o
      ; ya hay un usuario logueado actualmente, entonces retorna el sistema original sin cambios.
      sistema
  )
)
; Función para cerrar la sesión del usuario actual.
(define (system-logout sistema)
  ; Si no hay ningún usuario logueado actualmente (es decir, currentUser es null),
  ; entonces retorna el sistema original sin cambios.
  (if (null? (get-currentUser sistema)) 
      sistema

      ; Si hay un usuario logueado actualmente, entonces cierra su sesión.
      ; Retorna una nueva lista que es idéntica al sistema original,
      ; pero con el currentUser cambiado a #f (nulo), representando que no hay sesión iniciada.
      (list 
       (get-systemName sistema) ; nombre del sistema
       (get-systemInitialcode sistema) ; código inicial del sistema
       (get-systemUsers sistema) ; lista de usuarios del sistema
       #f ; ahora no hay sesión iniciada
       (get-systemChatbots sistema) ; lista de chatbots del sistema
       )
  )
)
; Otras funciones
(define (search-option-int options msg-int)
  (cond
    [(empty? options) #f]
    [(equal? msg-int (car (car options))) (car options)]
    [else (search-option-int (cdr options) msg-int)]))

(define (search-option-str options message)
  (cond
    [(empty? options) #f]
    [(member message (cdr (car options))) (car options)] 
    [else (search-option-str (cdr options) message)]))

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
  (let ((chatbot (get-currentChatbot sistema)) ; Obtiene el chatbot actual del sistema.
        (flows (get-chatbotFlows chatbot))) ; Obtiene todos los flujos del chatbot actual.
    (map get-flowOptions flows) ; Aplica la función get-flowOptions a cada flujo, devolviendo una lista de listas de opciones.
  )
)

; Función get-chatbot-by-flow: Toma un sistema y un flujo y retorna el chatbot que contiene ese flujo.
(define (get-chatbot-by-flow system flow)
  (let ((chatbots (get-systemChatbots system))) ; Obtiene todos los chatbots del sistema.
    (let ((matching-chatbots (filter (lambda (chatbot) (member flow (get-chatbotFlows chatbot))) chatbots))) ; Busca los chatbots que contienen el flujo.
      (if (null? matching-chatbots)
          (error "No hay ningún chatbot que contenga ese flujo.")
          (car matching-chatbots) ; Retorna el primer chatbot que contiene el flujo (asumiendo que solo puede haber uno).
      )
    )
  )
)


; Función get-currentChatbot: Toma un sistema y retorna el chatbot actual del sistema.
(define (get-currentChatbot sistema)
  ; Verifica si el sistema tiene la estructura adecuada
  (if (and (list? sistema)
           (>= (length sistema) 4) ; Asegura que el sistema tenga al menos 4 elementos
           (list? (get-systemChatbots sistema)) ; Verifica que la lista de chatbots sea una lista
           (number? (get-systemInitialcode sistema))) ; Verifica que el InitialChatbotCodeLink sea un número
      ; Si el sistema tiene la estructura adecuada, continúa
      (let ((chatbots (get-systemChatbots sistema))
            (initialCode (get-systemInitialcode sistema)))
        (if (null? chatbots)
            #f ; Si la lista de chatbots está vacía, retorna #f
            (car (filter (lambda (cb) (= (get-startFlowId cb) initialCode)) chatbots)))) ; Busca y retorna el chatbot cuyo InitialCode es igual al InitialChatbotCodeLink
      ; Si el sistema no tiene la estructura adecuada, retorna un valor apropiado (por ejemplo, #f)
      #f)
)

; Función set-currentChatbot: Toma un sistema y un chatbot y devuelve un nuevo sistema con el InitialChatbotCodeLink actualizado.
(define (set-currentChatbot system new-chatbot)
  (let ((chatbots (get-systemChatbots system)) ; Obtiene la lista de chatbots del sistema
        (startFlowId (get-startFlowId new-chatbot))) ; Obtiene el id del flujo inicial del nuevo chatbot
    (list (car system) startFlowId chatbots))) ; Crea un nuevo sistema con el InitialChatbotCodeLink actualizado

(define (system-add-chat system new-chatbot)
  ; Crea una nueva instancia del sistema con el chatbot actualizado
  (list (car system) (cadr system) new-chatbot (cadddr system)))

(define (system-add-chatHistory system new-chatHistory)
  ; Crea una nueva instancia del sistema con el chatHistory actualizado
  (list (car system) (cadr system) (caddr system) new-chatHistory))

(define (user-add-message user sender message option)
  (list (get-username user) 
        (chatHistory-add (get-chatHistory user) sender message option)))


; Función recursiva para buscar una opción que coincida con un número dado.
(define (find-option-by-code options code)
  (if (null? options)
      #f
      (let ((option (car options)))
        (if (equal? (get-optionCode option) code)
            option
            (find-option-by-code (cdr options) code)))))

; Función recursiva para buscar una opción que coincida con una palabra clave.
(define (find-option-by-keyword options keyword)
  (if (null? options)
      #f
      (let ((option (car options)))
        (if (member keyword (map string-downcase (get-optionKeywords option)))
            option
            (find-option-by-keyword (cdr options) keyword)))))

; Esta función 'system-talk-rec' toma un sistema y un mensaje como parámetros
; y realiza una serie de acciones, incluida la actualización del sistema.
(define (system-talk-rec system message)
  ; Verifica si hay un usuario conectado
  (if (not (logged? system))
      "No hay ningún usuario conectado." ; Retornar un mensaje en lugar de lanzar un error
      ; Extrae las opciones disponibles y el usuario actual del sistema
      (let ((options (apply append (get-all-options system))) ; Aquí se aplana la lista
            (current-user (get-currentUser system)))
        ; Busca una opción que coincida con el mensaje
        (let ((matching-option (if (string->number message)
                                   (find-option-by-code options (string->number message))
                                   (find-option-by-keyword options (string-downcase message)))))
          ; Verifica si encontró una opción coincidente
          (if (not matching-option)
              "No hay ninguna opción que coincida con el mensaje."
              ; Extrae el flujo siguiente (next-flow) a partir de la opción coincidente
              (let ((next-flow (get-CbCodeLink matching-option)))
                ; Si no hay un flujo siguiente, actualiza el historial de chat del usuario y retorna el sistema sin cambios
                (if (null? next-flow)
                    (begin
                      (user-add-message current-user 'bot (get-welcomeMessage (get-currentChatbot system)))
                      system) ; Retorna el sistema actualizado
                    ; Si hay un flujo siguiente, realiza una serie de actualizaciones en el sistema
                    (let* ((new-chatbot (get-chatbot-by-flow system next-flow))  ; Obtiene el nuevo chatbot según el flujo siguiente
                           (bot-message (get-welcomeMessage new-chatbot))  ; Obtiene el mensaje de bienvenida del nuevo chatbot
                           (new-chatHistory (chatHistory-add (get-chatHistory current-user) 'bot bot-message))  ; Añade el mensaje del bot al historial de chat
                           (new-chatHistory (chatHistory-add new-chatHistory 'user message (get-optionMessage matching-option)))  ; Añade el mensaje del usuario al historial de chat
                           (new-user (list (get-username current-user) new-chatHistory)) ; Crea un nuevo usuario con el chatHistory actualizado
                           (new-system (list (get-systemName system) (get-systemInitialcode system) (cons new-user (get-systemUsers system)) (get-currentUser system) (get-systemChatbots system)))) ; Crea un nuevo sistema con el usuario y el chatbot actualizados
                      new-system))))))))  ; Retorna el nuevo sistema
(provide (all-defined-out))