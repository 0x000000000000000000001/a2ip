module Api.Main where

import Proem

import Api.Ping (ping)
import Api.Sync (sync)
import Effect (Effect)
import Effect.Aff (launchAff_)
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

foreign import flushStreamImpl :: ∀ w. w -> Effect Unit

sendResponse :: Int -> String -> ServerResponse -> Effect Unit
sendResponse statusCode body res = do
  setStatusCode statusCode res
  let msg = toOutgoingMessage res
  setHeader "Content-Type" "text/plain" msg
  ø $ writeString (toWriteable msg) UTF8 body
  end (toWriteable msg)

sendStreamingMessage :: String -> ServerResponse -> Effect Unit
sendStreamingMessage msg res = do
  let stream = toWriteable $ toOutgoingMessage res
  ø $ writeString stream UTF8 (msg <> "\n")
  flushStreamImpl stream

handleRequest :: IncomingMessage IMServer -> ServerResponse -> Effect Unit
handleRequest req res = do
  let url' = url req
      method' = method req

  log $ method' <> " " <> url'
  
  launchAff_ $
    case url' of
      "/ping" -> do
        result <- ping
        ʌ $ sendResponse 200 result res
      "/sync" -> do
        ʌ $ do
          setStatusCode 200 res
          let msg = toOutgoingMessage res
          setHeader "Content-Type" "text/plain; charset=utf-8" msg
          setHeader "Transfer-Encoding" "chunked" msg
        _ <- sync (\message -> ʌ $ sendStreamingMessage message res)
        ʌ $ end (toWriteable $ toOutgoingMessage res)
      _ -> ʌ $ sendResponse 404 "404 Not Found" res

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
