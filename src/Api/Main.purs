module Server.Main where

import Proem

import Effect (Effect)
import Effect.Console (log)
import Node.Encoding (Encoding(..))
import Node.EventEmitter (once_)
import Node.HTTP as HTTP
import Node.HTTP.IncomingMessage as IM
import Node.HTTP.OutgoingMessage as OM
import Node.HTTP.Server as Server
import Node.HTTP.ServerResponse as ServerResponse
import Node.HTTP.Types (IMServer, IncomingMessage, ServerResponse)
import Node.Net.Server (listenTcp)
import Node.Net.Server as NetServer
import Node.Stream as Stream

handleRequest :: IncomingMessage IMServer -> ServerResponse -> Effect Unit
handleRequest req res = do
  let url = IM.url req
  let method = IM.method req

  log $ method <> " " <> url
  
  let responseBody = if url == "/ping" then "pong" else "404 Not Found"
  let statusCode = if url == "/ping" then 200 else 404
  
  ServerResponse.setStatusCode statusCode res
  let om = ServerResponse.toOutgoingMessage res
  OM.setHeader "Content-Type" "text/plain" om
  void $ Stream.writeString (OM.toWriteable om) UTF8 responseBody
  Stream.end (OM.toWriteable om)

main :: Effect Unit
main = do
  server <- HTTP.createServer
  server # once_ Server.requestH handleRequest
  let netServer = Server.toNetServer server
      scheme = "http"
      host = "api.dev.a2ip-psychanalyse.org"
      port = 80
  netServer # once_ NetServer.listeningH do
    log $ "Server running at " <> scheme <> "://" <> host <> (port == 80 ? "" ↔ ":" <> show port) <> "/"
  listenTcp netServer { host, port }
