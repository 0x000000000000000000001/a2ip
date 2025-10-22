module Component.Router.HandleAction where

import Proem hiding (div)

import Capability.Log (debug)
import Component.Router.Type (Action(..), RouteM)
import Data.Foldable (for_)
import Data.Maybe (Maybe(..))
import Data.Time.Duration (Milliseconds(..))
import Effect.Aff (delay)
import Effect.Aff.Class (liftAff)
import Effect.Class (liftEffect)
import Halogen (fork, get, kill, modify_, subscribe')
import Halogen.Query.Event (eventListener)
import Util.Html.Dom (scroll)
import Web.DOM.Document (toEventTarget)
import Web.HTML (window)
import Web.HTML.HTMLDocument (toDocument)
import Web.HTML.Window (document)

handleAction :: Action -> RouteM Unit
handleAction = case _ of
  Initialize -> do
    doc <- liftEffect $ document =<< window
    subscribe' $ κ $ eventListener
      scroll
      (doc # toDocument # toEventTarget)
      (HandleDocScroll # Just # κ)

  HandleDocScroll -> do
    state <- get
    for_ state.scrollFork kill

    forkId <- fork do
      (delay $ Milliseconds 300.0) # liftAff
      handleAction HandleDocScrollEnd

    modify_ _ { scrollFork = Just forkId }

  HandleDocScrollEnd -> do
    modify_ _ { scrollFork = Nothing }

    debug "ahaha, scroll ended!"