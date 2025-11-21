module Api.Main where

import Proem

import Effect (Effect)
import Effect.Console (log)
import Node.Encoding (Encoding(..))
import Node.EventEmitter (on_)
import Node.HTTP (createServer)
import Node.HTTP.IncomingMessage (method, url)
import Node.HTTP.OutgoingMessage (setHeader, toWriteable)
import Node.HTTP.Server (requestH, toNetServer)
import Node.HTTP.ServerResponse (setStatusCode, toOutgoingMessage)
import Node.HTTP.Types (IMServer, IncomingMessage, ServerResponse)
import Node.Net.Server (listenTcp)
import Node.Stream (end, writeString)

handleRequest :: IncomingMessage IMServer -> ServerResponse -> Effect Unit
handleRequest req res = do
  let url' = url req
      method' = method req

  log $ method' <> " " <> url'
  
  let responseBody = if url' == "/ping" then "pong" else "404 Not Found"
      statusCode = if url' == "/ping" then 200 else 404
  
  setStatusCode statusCode res

  let msg = toOutgoingMessage res

  setHeader "Content-Type" "text/plain" msg

  void $ writeString (toWriteable msg) UTF8 responseBody

  end (toWriteable msg)

main :: Effect Unit
main = do
  server <- createServer
  server # on_ requestH handleRequest

  let netServer = toNetServer server
      scheme = "http"
      host = "api.dev.a2ip-psychanalyse.org"
      port = 8081
      
  listenTcp netServer { host: "0.0.0.0", port }
  
  log $ 
    "Server running at " 
    <> scheme 
    <> "://" 
    <> host 
    <> (port == 80 ? "" ↔ ":" <> show port)
