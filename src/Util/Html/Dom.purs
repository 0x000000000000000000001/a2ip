module Util.Html.Dom
  ( scroll
  , scrollTo
  , getScrollY
  , dataAttr
  , dataAttrPrefixed
  , dataAttrQuerySelector
  , isVisible
  )
  where

import Proem

import Data.Array (mapMaybe)
import Data.Int (round, toNumber)
import Data.Maybe (Maybe)
import Effect.Class (class MonadEffect, liftEffect)
import Halogen (AttrName(..))
import Halogen.HTML (attr)
import Halogen.HTML.Properties (IProp)
import Type.Prelude (class IsSymbol, Proxy)
import Web.DOM.Element (fromNode, getBoundingClientRect)
import Web.DOM.NodeList (toArray)
import Web.DOM.ParentNode (QuerySelector(..), querySelectorAll)
import Web.Event.Event (EventType(..))
import Web.HTML (window)
import Web.HTML.HTMLDocument (toParentNode)
import Web.HTML.Window (document, innerHeight)
import Web.HTML.Window as Window

dataAttrPrefix :: String
dataAttrPrefix = "data-"

dataAttrPrefixed :: ∀ sym. IsSymbol sym => Proxy sym -> String
dataAttrPrefixed name = dataAttrPrefix <> (ᴠ name)

dataAttr :: ∀ sym r i. IsSymbol sym => Proxy sym -> String -> IProp r i
dataAttr name value = attr (AttrName $ dataAttrPrefixed name) value

dataAttrQuerySelector :: ∀ sym. IsSymbol sym => Proxy sym -> Maybe String -> QuerySelector
dataAttrQuerySelector name value =
  QuerySelector
    $ "["
    <> dataAttrPrefixed name
    <> (value ?? (\v -> "=\"" <> v <> "\"") ⇔ "")
    <> "]"

-- | Check if a date element is visible on screen
isVisible :: ∀ m. MonadEffect m => QuerySelector -> m Boolean
isVisible sel = liftEffect do
  win <- window
  doc <- document win
  screenHeight <- toNumber <$> innerHeight win

  nodeList <- querySelectorAll sel (toParentNode doc)
  nodes <- toArray nodeList
  let elements = nodes # mapMaybe fromNode

  case elements of
    [] -> pure false
    [ element ] -> do
      rect <- getBoundingClientRect element
      pure $ rect.top >= 0.0 && rect.bottom <= screenHeight
    _ -> pure false

scroll :: EventType
scroll = EventType "scroll"

scrollTo :: ∀ m. MonadEffect m => Int -> Int -> m Unit
scrollTo x y = liftEffect do
  win <- window
  Window.scroll x y win

getScrollY :: ∀ m. MonadEffect m => m Int
getScrollY = liftEffect do
  win <- window
  y <- Window.scrollY win
  pure $ round y