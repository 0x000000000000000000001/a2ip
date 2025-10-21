module Util.Html.Dom
  ( isVisible
  )
  where

import Proem

import Data.Array (mapMaybe)
import Data.Int (toNumber)
import Effect.Class (class MonadEffect, liftEffect)
import Web.DOM.Element (fromNode, getBoundingClientRect)
import Web.DOM.NodeList (toArray)
import Web.DOM.ParentNode (QuerySelector, querySelectorAll)
import Web.HTML (window)
import Web.HTML.HTMLDocument (toParentNode)
import Web.HTML.Window (document, innerHeight)

-- | Check if a date element is visible on screen
isVisible :: forall m. MonadEffect m => QuerySelector -> m Boolean
isVisible sel = liftEffect do
  win <- window
  doc <- document win
  screenHeight <- toNumber <$> innerHeight win
  
  nodeList <- querySelectorAll sel (toParentNode doc)
  nodes <- toArray nodeList
  let elements = nodes # mapMaybe fromNode
  
  case elements of
    [] -> pure false
    [element] -> do
      rect <- getBoundingClientRect element
      pure $ rect.top >= 0.0 && rect.bottom <= screenHeight
    _ -> pure false