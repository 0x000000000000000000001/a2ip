module App.Component.Common.Timeline.HandleAction.HandleInitialize
  ( handleInitialize
  ) where

import Proem

import App.Component.Common.Timeline.Type (Action(..), TimelineM)
import Data.Maybe (Maybe(..))
import Halogen (subscribe')
import Halogen.Query.Event (eventListener)
import Util.Html.Dom as UtilDom
import Web.DOM.Document (toEventTarget)
import Web.HTML (window)
import Web.HTML.HTMLDocument (toDocument)
import Web.HTML.Window (document)

handleInitialize :: TimelineM Unit
handleInitialize = do
  doc <- ʌ $ document =<< window
  subscribe' $ κ $ eventListener
    UtilDom.scroll
    (doc # toDocument # toEventTarget)
    (HandleDocScroll # Just # κ)