module Util.Http
  ( getCheckStatus
  ) where

import Prelude

import Affjax.Node (Response, printError)
import Affjax.Node as Affjax
import Affjax.ResponseFormat (ResponseFormat)
import Affjax.StatusCode (StatusCode(..))
import Data.Either (Either(..))
import Effect.Aff (Aff)

-- | Does a GET request and checks for HTTP status codes.
-- | Returns an error message if the status code indicates a failure.
-- | Returns Left for:
-- |   - Network errors (timeout, DNS issues, etc.)
-- |   - HTTP status codes >= 400 (client/server errors)
-- | Returns Right only for 2xx and 3xx status codes
getCheckStatus :: forall a. ResponseFormat a -> String -> Aff (Either String (Response a))
getCheckStatus format url = do
  response <- Affjax.get format url
  case response of
    Left error -> pure $ Left $ printError error
    Right res -> do
      let (StatusCode code) = res.status
      if code >= 200 && code < 400
        then pure $ Right res
        else pure $ Left $ "HTTP " <> show code <> ": " <> res.statusText
