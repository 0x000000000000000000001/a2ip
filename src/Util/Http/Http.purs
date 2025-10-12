module Util.Http.Http
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

import Proem

import Affjax (AffjaxDriver, Error, Request, Response, URL, printError)
import Affjax (Request, Response, Error, URL) as Exports
import Affjax as Affjax
import Affjax.RequestBody (RequestBody)
import Affjax.ResponseFormat (ResponseFormat)
import Affjax.StatusCode (StatusCode(..))
import Data.Either (Either(..))
import Data.Maybe (Maybe)
import Effect.Aff (Aff)

foreign import driver :: AffjaxDriver

get :: ∀ a. ResponseFormat a -> URL -> Aff (Either Error (Response a))
get = Affjax.get driver

post :: ∀ a. ResponseFormat a -> URL -> Maybe RequestBody -> Aff (Either Error (Response a))
post = Affjax.post driver

post_ :: URL -> Maybe RequestBody -> Aff (Either Error Unit)
post_ = Affjax.post_ driver

put :: ∀ a. ResponseFormat a -> URL -> Maybe RequestBody -> Aff (Either Error (Response a))
put = Affjax.put driver

put_ :: URL -> Maybe RequestBody -> Aff (Either Error Unit)
put_ = Affjax.put_ driver

delete :: ∀ a. ResponseFormat a -> URL -> Aff (Either Error (Response a))
delete = Affjax.delete driver

delete_ :: URL -> Aff (Either Error Unit)
delete_ = Affjax.delete_ driver

patch :: ∀ a. ResponseFormat a -> URL -> RequestBody -> Aff (Either Error (Response a))
patch = Affjax.patch driver

patch_ :: URL -> RequestBody -> Aff (Either Error Unit)
patch_ = Affjax.patch_ driver

request :: ∀ a. Request a -> Aff (Either Error (Response a))
request = Affjax.request driver

-- | Does a GET request and checks for HTTP status codes.
-- | Returns an error message if the status code indicates a failure.
-- | Returns Left for:
-- |   - Network errors (timeout, DNS issues, etc.)
-- |   - HTTP status codes >= 400 (client/server errors)
-- | Returns Right only for 2xx and 3xx status codes
getCheckStatus :: ∀ a. ResponseFormat a -> String -> Aff (Either String (Response a))
getCheckStatus format url = do
  response <- get format url
  response
    ?! (\res -> do
      let (StatusCode code) = res.status
      code >= 200 && code < 400
        ? (pure $ Right res)
        ↔ (pure $ Left $ "HTTP " <> show code <> ": " <> res.statusText)
    )
    ⇿ pure ◁ Left ◁ printError
