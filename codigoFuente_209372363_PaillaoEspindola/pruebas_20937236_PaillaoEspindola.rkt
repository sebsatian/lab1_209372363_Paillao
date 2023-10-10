#lang racket

(require "TDAflow_20937236_PaillaoEspindola.rkt")
(require "TDAchatbot_20937236_PaillaoEspindola.rkt")
(require "TDAuser_20937236_PaillaoEspindola.rkt")
(require "TDAchatHistory_20937236_PaillaoEspindola.rkt")
(require "TDAsystem_20937236_PaillaoEspindola.rkt")
(require "TDAoption_20937236_PaillaoEspindola.rkt")



;AQUI EL SCRIPT DE PRUEBA CREADO POR MI
; Crear opciones
(define op1 (option 1 "1) Deportes extremos" 1 1 "extremos" "deportes" "adrenalina" "aventura"))
(define op2 (option 2 "2) Compra en línea" 2 1 "comprar" "en línea" "shop" "online"))
(define op3 (option 1 "1) Salto en bungee" 3 1 "salto" "bungee" "alto" "puente"))
(define op4 (option 2 "2) Skydiving" 3 2 "skydiving" "paracaidismo" "altitud" "paracaídas"))
(define op5 (option 1 "1) Tecnología" 4 1 "tecnología" "electronics" "gadget" "dispositivos"))
(define op6 (option 2 "2) Comida" 4 2 "comida" "alimentos" "restaurante" "comida rápida"))
(define op7 (option 1 "1) Cajón del Maipo" 5 1 "Cajón del Maipo" "naturaleza"))
(define op8 (option 2 "2) Reñaca" 5 2 "Reñaca" "playa" "arena"))
(define op9 (option 1 "1) Cajón del Maipo" 6 1 "Cajón del Maipo" "naturaleza"))
(define op10 (option 2 "2) Cerro Panul" 6 2 "Cerro Panul" "montaña" "vista"))
(define op11 (option 1 "1) Celulares Samsung" 7 1 "Samsung" "Android" "Galaxy"))
(define op12 (option 2 "2) Celulares Apple" 7 2 "Apple" "iPhone" "iOS"))
(define op13 (option 1 "1) McDonald's" 8 1 "McDonald's" "Hamburguesas" "coca cola" "papas fritas"))
(define op14 (option 2 "2) El Faraón" 8 2 "El Faraón" "papas fritas" "papas" "fritas"))

; Crear flujos
(define f10 (flow 1 "Flujo Principal Chatbot 1\nBienvenido\n¿Qué te gustaría hacer?" op1 op2 op2 op2 op2 op1))
(define f11 (flow 2 "Flujo Principal Chatbot 2\nBienvenido\n¿Dónde te gustaría viajar?" op3 op4 op4 op4 op3))
(define f12 (flow 3 "Flujo Principal Chatbot 3\nBienvenido\n¿Qué buscas comprar?" op5 op6 op6 op6 op5))

; Crear chatbots
(define cb0 (chatbot 0 "Inicial" "Bienvenido\n¿Qué te gustaría hacer?" 1 f10 f10 f10 f10))
(define cb1 (chatbot 1 "Max Steel" "Bienvenido.\n¿Dónde te gustaría ir?" 2 f11 f11 f11 f11))
(define cb2 (chatbot 2 "Asesor de Compras" "Hola.\n¿Qué buscas comprar hoy?" 3 f12 f12 f12 f12))

; Crear sistema
(define s0 (system "Chatbots Paradigmas" 0 cb0 cb0 cb0 cb0 cb1 cb2))

; Añadir chatbots al sistema
(define s1 (system-add-chatbot s0 cb1))
(define s2 (system-add-chatbot s1 cb2))

; Añadir usuarios al sistema
(define s3 (system-add-user s2 "user1"))
(define s4 (system-add-user s3 "user2"))
(define s5 (system-add-user s4 "user2"))  ; Solo añade una ocurrencia de user2
(define s6 (system-add-user s5 "user3"))

; Simulación de interacciones
(define s7 (system-login s6 "user1"))  ; Inicia sesión con "user1"
(define s8 (system-login s7 "user2"))  ; Intenta iniciar sesión con "user2" mientras "user1" ya ha iniciado sesión


; Añadir flujos a los chatbots adicionales
(define cb3 (chatbot-add-flow cb0 f10))
(define cb4 (chatbot-add-flow cb1 f11))
(define cb5 (chatbot-add-flow cb2 f12))

; Crear dos sistemas adicionales
(define s12 (system "Chatbots Paradigmas 2" 0 cb0 cb0 cb0 cb0 cb1 cb2)); No añade repetidos
(define s13 (system "Chatbots Paradigmas 3" 0 cb0 cb0 cb0 cb0 cb1 cb2))

; Añadir chatbots a los sistemas adicionales
(define s14 (system-add-chatbot s12 cb1))
(define s15 (system-add-chatbot s14 cb2))
(define s16 (system-add-chatbot s13 cb1))
(define s17 (system-add-chatbot s16 cb2))

; Añadir usuarios a los sistemas adicionales
(define s18 (system-add-user s15 "user1"))
(define s19 (system-add-user s18 "user2"))
(define s20 (system-add-user s19 "user2"))  ; Solo añade una ocurrencia de user2
(define s21 (system-add-user s20 "user3"))

; Simulación de interacciones adicionales
(define s22 (system-login s21 "user1"))  ; Inicia sesión con "user1"
(define s23 (system-login s22 "user2"))  ; Intenta iniciar sesión con "user2" mientras "user1" ya ha iniciado sesión
(define s24 (system-logout s23))  ; Cierra sesión con "user1"
(define s25 (system-login s24 "user2"))  ; Ahora inicia sesión con "user2"
(define s26 (system-logout s25))  ; Cierra sesión con "user2"

;Iniciar sesión con "user1"
(define s27 (system-login s26 "user1"))

;Interactúa con el chatbot inicial eligiendo "Deportes extremos"
(define s28 (system-talk-rec s27 "Deportes"))






;AQUI EL PRIMER SCRIPT DE PRUEBA DADO

(define op1 (option 1 "1) Viajar" 2 1 "viajar" "turistear" "conocer"))
(define op2 (option 2 "2) Estudiar" 3 1 "estudiar" "aprender" "perfeccionarme"))
(define f10 (flow 1 "flujo1" op1 op2 op2 op2 op2 op1)) ;solo añade una ocurrencia de op2
(define f11 (flow-add-option f10 op1)) ;se intenta añadir opción duplicada
(define cb0 (chatbot 0 "Inicial" "Bienvenido\n¿Qué te gustaría hacer?" 1 f10 f10 f10 f10)) ;solo añade una
ocurrencia de f10
(define s0 (system "Chatbots Paradigmas" 0 cb0 cb0 cb0))
(define s1 (system-add-chatbot s0 cb0)) ;igual a s0
(define s2 (system-add-user s1 "user1"))
(define s3 (system-add-user s2 "user2"))
(define s4 (system-add-user s3 "user2")) ;solo añade un ocurrencia de user2
(define s5 (system-add-user s4 "user3"))
(define s6 (system-login s5 "user8")) ;user8 no existe. No inicia sesión
(define s7 (system-login s6 "user1"))
(define s8 (system-login s7 "user2")) ;no permite iniciar sesión a user2, pues user1 ya inició sesión
(define s9 (system-logout s8))
(define s10 (system-login s9 "user2"))


;AQUI EL SEGUNDO

Script de Pruebas N°2
;Ejemplo de un sistema de chatbots basado en el esquema del enunciado general
;Chabot0
(define op1 (option 1 "1) Viajar" 1 1 "viajar" "turistear" "conocer"))
(define op2 (option 2 "2) Estudiar" 2 1 "estudiar" "aprender" "perfeccionarme"))
(define f10 (flow 1 "Flujo Principal Chatbot 1\nBienvenido\n¿Qué te gustaría hacer?" op1 op2 op2 op2 op2 op1))
;solo añade una ocurrencia de op2 y op1
(define f11 (flow-add-option f10 op1)) ;se intenta añadir opción duplicada
(define cb0 (chatbot 0 "Inicial" "Bienvenido\n¿Qué te gustaría hacer?" 1 f10 f10 f10 f10)) ;solo añade una
ocurrencia de f10
;Chatbot1
(define op3 (option 1 "1) New York, USA" 1 2 "USA" "Estados Unidos" "New York"))
(define op4 (option 2 "2) París, Francia" 1 1 "Paris" "Eiffel"))
(define op5 (option 3 "3) Torres del Paine, Chile" 1 1 "Chile" "Torres" "Paine" "Torres Paine" "Torres del Paine"))
(define op6 (option 4 "4) Volver" 0 1 "Regresar" "Salir" "Volver"))
;Opciones segundo flujo Chatbot1
(define op7 (option 1 "1) Central Park" 1 2 "Central" "Park" "Central Park"))
(define op8 (option 2 "2) Museos" 1 2 "Museo"))
(define op9 (option 3 "3) Ningún otro atractivo" 1 3 "Museo"))
(define op10 (option 4 "4) Cambiar destino" 1 1 "Cambiar" "Volver" "Salir"))
(define op11 (option 1 "1) Solo" 1 3 "Solo"))
(define op12 (option 2 "2) En pareja" 1 3 "Pareja"))
(define op13 (option 3 "3) En familia" 1 3 "Familia"))
(define op14 (option 4 "4) Agregar más atractivos" 1 2 "Volver" "Atractivos"))
(define op15 (option 5 "5) En realidad quiero otro destino" 1 1 "Cambiar destino"))
(define f20 (flow 1 "Flujo 1 Chatbot1\n¿Dónde te Gustaría ir?" op3 op4 op5 op6))
(define f21 (flow 2 "Flujo 2 Chatbot1\n¿Qué atractivos te gustaría visitar?" op7 op8 op9 op10))
(define f22 (flow 3 "Flujo 3 Chatbot1\n¿Vas solo o acompañado?" op11 op12 op13 op14 op15))
(define cb1 (chatbot 1 "Agencia Viajes" "Bienvenido\n¿Dónde quieres viajar?" 1 f20 f21 f22))
;Chatbot2
(define op16 (option 1 "1) Carrera Técnica" 2 1 "Técnica"))
(define op17 (option 2 "2) Postgrado" 2 1 "Doctorado" "Magister" "Postgrado"))
(define op18 (option 3 "3) Volver" 0 1 "Volver" "Salir" "Regresar"))
(define f30 (flow 1 "Flujo 1 Chatbot2\n¿Qué te gustaría estudiar?" op16 op17 op18))
(define cb2 (chatbot 2 "Orientador Académico" "Bienvenido\n¿Qué te gustaría estudiar?" 1 f30))
;Sistema
(define s0 (system "Chatbots Paradigmas" 0 cb0 cb0 cb0 cb1 cb2))
(define s1 (system-add-chatbot s0 cb0)) ;igual a s0
(define s2 (system-add-user s1 "user1"))
(define s3 (system-add-user s2 "user2"))
(define s4 (system-add-user s3 "user2"))
(define s5 (system-add-user s4 "user3"))
(define s6 (system-login s5 "user8"))
(define s7 (system-login s6 "user1"))
(define s8 (system-login s7 "user2"))
(define s9 (system-logout s8))
(define s10 (system-login s9 "user2"))
(define s1 (system-add-chatbot s0 cb0)) ;igual a s0
(define s2 (system-add-user s1 "user1"))
(define s3 (system-add-user s2 "user2"))
(define s4 (system-add-user s3 "user2"))
(define s5 (system-add-user s4 "user3"))
(define s6 (system-login s5 "user8"))
(define s7 (system-login s6 "user1"))
(define s8 (system-login s7 "user2"))
(define s9 (system-logout s8))
(define s10 (system-login s9 "user2"))

;EL RESTO DE LAS FUNCIONES NO FUNCIONAN DE MANERA CORRECTA O NO FUERON IMPLEMENTADAS