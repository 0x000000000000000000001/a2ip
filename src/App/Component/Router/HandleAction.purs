module App.Component.Router.HandleAction where

import Proem hiding (div)

import App.Component.Router.Type (Action, RouteM)
import App.Util.Capability.Navigate (Route, routePath)
import Effect.Class (class MonadEffect)
import Util.LocalStorage (setInLocalStorage)

handleAction :: Action -> RouteM Unit
handleAction = κηι
-- handleAction = case _ of
--   Initialize -> do
--     doc <- ∧ $ document =<< window
--     subscribe' $ κ $ eventListener
--       scroll
--       (doc # toDocument # toEventTarget)
--       (HandleDocScroll # Just # κ)

--   HandleDocScroll -> do
--     state <- get
--     for_ state.scrollFork kill

--     forkId <- fork do
--       (delay $ Milliseconds 300.0) # liftAff
--       handleAction HandleDocScrollEnd

--     modify_ _ { scrollFork = Just forkId }

--   HandleDocScrollEnd -> do
--     modify_ _ { scrollFork = Nothing }

--     state <- get
--     scrollY <- ∧ getScrollY
--     ∧ $ saveScrollY state.route scrollY

scrollKey :: String
scrollKey = "lastScrollEndPosY"

saveScrollY :: ∀ m. MonadEffect m => Route -> Int -> m Unit
saveScrollY route y = setInLocalStorage scrollKey (routePath route <> ":" <> show y)