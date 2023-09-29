; TDA para user
(define-struct user (nombre correo chatHistory))
; Constructor para el TDA user
(define (crear-user nombre correo chatHistory)
  (make-user nombre correo chatHistory))
; Selectores para el TDA user
(define (obtener-nombre user)
  (user-nombre user))
(define (obtener-correo user)
  (user-correo user))
(define (obtener-chatHistory user)
  (user-chatHistory user))
; Modificador para el TDA user
(define (agregar-chat user chat)
  (set-user-chatHistory! user (cons chat (obtener-chatHistory user))))