module Util.Http
  ( delete
  , delete_
  , get
  , getCheckStatus
  , module Exports
  , patch
  , patch_
  , post
  , post_
  , put
  , put_
  , request
  )
  where

import Prelude

import Affjax (Error, Request, Response, URL, printError)
import Affjax (Request, Response, Error, URL) as Exports
import Affjax.RequestBody (RequestBody)
import Affjax.ResponseFormat (ResponseFormat)
import Affjax.StatusCode (StatusCode(..))
import Data.Either (Either(..))
import Data.Maybe (Maybe)
import Effect.Aff (Aff)
import Util.Env (isNode)
import Affjax.Node as AffjaxNode
import Affjax.Web as AffjaxWeb

get :: forall a. ResponseFormat a -> URL -> Aff (Either Error (Response a))
get = if isNode then AffjaxNode.get else AffjaxWeb.get

post :: forall a. ResponseFormat a -> URL -> Maybe RequestBody -> Aff (Either Error (Response a))
post = if isNode then AffjaxNode.post else AffjaxWeb.post

post_ :: URL -> Maybe RequestBody -> Aff (Either Error Unit)
post_ = if isNode then AffjaxNode.post_ else AffjaxWeb.post_

put :: forall a. ResponseFormat a -> URL -> Maybe RequestBody -> Aff (Either Error (Response a))
put = if isNode then AffjaxNode.put else AffjaxWeb.put

put_ :: URL -> Maybe RequestBody -> Aff (Either Error Unit)
put_ = if isNode then AffjaxNode.put_ else AffjaxWeb.put_

delete :: forall a. ResponseFormat a -> URL -> Aff (Either Error (Response a))
delete = if isNode then AffjaxNode.delete else AffjaxWeb.delete

delete_ :: URL -> Aff (Either Error Unit)
delete_ = if isNode then AffjaxNode.delete_ else AffjaxWeb.delete_

patch :: forall a. ResponseFormat a -> URL -> RequestBody -> Aff (Either Error (Response a))
patch = if isNode then AffjaxNode.patch else AffjaxWeb.patch

patch_ :: URL -> RequestBody -> Aff (Either Error Unit)
patch_ = if isNode then AffjaxNode.patch_ else AffjaxWeb.patch_

request :: forall a. Request a -> Aff (Either Error (Response a))
request = if isNode then AffjaxNode.request else AffjaxWeb.request

-- | Does a GET request and checks for HTTP status codes.
-- | Returns an error message if the status code indicates a failure.
-- | Returns Left for:
-- |   - Network errors (timeout, DNS issues, etc.)
-- |   - HTTP status codes >= 400 (client/server errors)
-- | Returns Right only for 2xx and 3xx status codes
getCheckStatus :: forall a. ResponseFormat a -> String -> Aff (Either String (Response a))
getCheckStatus format url = do
  response <- get format url
  case response of
    Left error -> pure $ Left $ printError error
    Right res -> do
      let (StatusCode code) = res.status
      if code >= 200 && code < 400
        then pure $ Right res
        else pure $ Left $ "HTTP " <> show code <> ": " <> res.statusText
