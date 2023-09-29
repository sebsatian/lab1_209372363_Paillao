#lang racket

; TDA para sistema
(define-struct system (chatbots))
; Constructor para el TDA sistema
(define (crear-sistema chatbots)
  (make-sistema chatbots))
; Selector para el TDA sistema
(define (obtener-chatbots system)
  (sistema-chatbots system))
; Modificador para el TDA sistema
(define (agregar-chatbot system chatbot)
  (set-sistema-chatbots! system (cons chatbot (obtener-chatbots sistema))))