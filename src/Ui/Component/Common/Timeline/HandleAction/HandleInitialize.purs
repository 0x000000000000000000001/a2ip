module Ui.Component.Common.Timeline.HandleAction.HandleInitialize
  ( handleInitialize
  ) where

import Proem

import Ui.Component.Common.Timeline.Type (Action(..), TimelineM)
import Data.Maybe (Maybe(..))
import Effect.Ref (new)
import Halogen (modify_, subscribe')
import Halogen.Query.Event (eventListener)
import Util.Html.Dom (scroll)
import Web.DOM.Document (toEventTarget)
import Web.HTML (window)
import Web.HTML.HTMLDocument (toDocument)
import Web.HTML.Window (document)

handleInitialize :: ∀ w i. TimelineM w i Unit
handleInitialize = do
  doc <- ʌ $ document =<< window
  subscribe' $ κ $ eventListener
    scroll
    (doc # toDocument # toEventTarget)
    (HandleDocScroll # Just # κ)

  ref <- ʌ $ new Nothing
  modify_ _ { scrollFork = Just ref }