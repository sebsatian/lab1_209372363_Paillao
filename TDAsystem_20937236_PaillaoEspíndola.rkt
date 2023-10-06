#lang racket

; Se importan las funciones del TDA chatbot.
(require "TDAchatbot_20937236_PaillaoEspindola.rkt")
; Se importan las funciones del TDA user.
(require "TDAuser_20937236_PaillaoEspindola.rkt")

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
    (append (list name InitialChatbotCodeLink '() ) unique-chatbots))
)

; Pertenencia: Determina si un elemento pertenece a un sistema, retorna #t si pertenece y #f si no.
(define (system? sistema) 
  (and (list? sistema); Verifica que sea una lista
       (string? (car sistema)); Verifica que el nombre del sistema sea un string
       (number? (cadr sistema)); Verifica que el código inicial del sistema sea un número
       (list? (caddr sistema)); Verifica que la lista de usuarios sea una lista
       (list? (cdddr sistema)); Verifica que la lista de chatbots sea una lista
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
; Selector de lista de chatbots del sistema.
(define (get-systemChatbots sistema)
  (cdddr sistema)
)

; Modificadores: 

  ; Añade un chatbot al sistema

  ; Se crea la función para añadir un chatbot al sistema.
  (define (system-add-chatbot sistema chatbot)
   ; Comprueba si el ID del chatbot ya existe en la lista de IDs de chatbots en el sistema.
  (if (member (get-chatbotId chatbot) (map get-chatbotId (get-systemChatbot sistema))
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
  (if (member username (map get-userName (get-systemUsers sistema)))
      sistema ; Si el usuario ya existe en la lista, devuelve el sistema original sin cambios.
       ; Si el usuario no existe, añade el usuario al sistema y devuelve el sistema modificado.
      (list (get-systemName sistema) (get-systemInitialcode sistema) (append (get-systemUsers sistema) (list new-user)) (get-systemChatbot sistema))
  )
)

; Funcion de login.

; Funcion auxiliar selectora de usuario logeado actual, para verificar si ya hay un usuario logeado o no.
(define (get-currentUser sistema)
  (if (list? (cadddr sistema))
      '()
      (cadddr sistema)
  )
)

; Funcion para logear un usuario, requiere el nombre del sistema y el username.
(define (system-login sistema username)
  ; Comprueba si el usuario ya existe en la lista de usuarios en el sistema.
  (if (and (member username (map get-userName (get-systemUsers sistema))) (null? (get-currentUser sistema)))
      ; Si el usuario existe y no hay otro usuario logeado, establece al usuario como el usuario actual del sistema.
      (list (get-systemName sistema) (get-systemInitialcode sistema) (get-systemUsers sistema) (get-systemChatbot sistema) username)
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

  ; Crea una nueva versión del sistema sin el usuario.
  (list systemName initialCode '() chatBots)  
)

(provide (all-defined-out))