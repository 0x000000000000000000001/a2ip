module Server.Main where

import Prelude

import Effect (Effect)
import Effect.Console (log)

-- Type pour le serveur HTTP Node.js
foreign import data HttpServer :: Type

-- Type pour les requêtes entrantes
foreign import data IncomingMessage :: Type

-- Type pour les réponses sortantes  
foreign import data ServerResponse :: Type

-- Crée un serveur HTTP
foreign import createHttpServer :: (IncomingMessage -> ServerResponse -> Effect Unit) -> Effect HttpServer

-- Démarre l'écoute sur un port
foreign import listenOn :: HttpServer -> Int -> Effect Unit -> Effect Unit

-- Récupère l'URL de la requête
foreign import getUrl :: IncomingMessage -> String

-- Récupère la méthode HTTP
foreign import getMethod :: IncomingMessage -> String

-- Envoie une réponse
foreign import sendResponse :: ServerResponse -> Int -> String -> Effect Unit

-- Handler pour les requêtes
handleRequest :: IncomingMessage -> ServerResponse -> Effect Unit
handleRequest req res = do
  let url = getUrl req
  let method = getMethod req
  log $ method <> " " <> url
  
  let responseBody = if url == "/ping" then "pong" else "404 Not Found"
  let statusCode = if url == "/ping" then 200 else 404
  
  sendResponse res statusCode responseBody

main :: Effect Unit
main = do
  server <- createHttpServer handleRequest
  listenOn server 8080 do
    log "Server running at http://localhost:8080/"
