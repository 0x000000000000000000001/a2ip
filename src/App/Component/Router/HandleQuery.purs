module App.Component.Router.HandleQuery where

import Proem hiding (div)

import App.Component.Router.HandleAction (scrollKey)
import App.Component.Router.Type (RouteM, Query(..))
import App.Util.Capability.Navigate (Route, routePath)
import Data.Array ((!!))
import Data.Int (fromNumber)
import Data.Maybe (Maybe(..))
import Data.Number (fromString)
import Data.String (Pattern(..), split)
import Effect.Class (class MonadEffect)
import Halogen (modify_)
import Util.Html.Dom (scrollTo)
import Util.LocalStorage (getInLocalStorage)

handleQuery :: ∀ a. Query a -> RouteM (Maybe a)
handleQuery = case _ of
  Navigate route' a -> do
    -- lastY <- recoverScrollY route'
    scrollTo 0 0

    modify_ _ { route = route' }

    η (Just a) 

recoverScrollY :: ∀ m. MonadEffect m => Route -> m (Maybe Int)
recoverScrollY route = do
  maybeValue <- getInLocalStorage scrollKey

  let parts = split (Pattern ":") (maybeValue ??⇒ "")
      localStorageRoute = parts !! 0 ??⇒ ""
      localStorageY = parts !! 1 ??⇒ ""

  η $ (routePath route == localStorageRoute) 
    ? (localStorageY # fromString >>= fromNumber)
    ↔ Nothing
  