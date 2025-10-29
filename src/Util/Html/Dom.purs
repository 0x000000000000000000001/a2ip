module Util.Html.Dom
  ( dataAttr
  , dataAttrPrefixed
  , dataAttrQuerySelector
  , getScrollY
  , isVisible
  , placeElementInScreenYCenter
  , scroll
  , scrollTo
  )
  where

import Proem

import Data.Array (mapMaybe)
import Data.Int (round, toNumber)
import Data.Maybe (Maybe)
import Effect.Class (class MonadEffect)
import Halogen (AttrName(..))
import Halogen.HTML (attr)
import Halogen.HTML.Properties (IProp)
import Type.Prelude (class IsSymbol, Proxy)
import Web.DOM (Element)
import Web.DOM.Element (fromNode, getBoundingClientRect)
import Web.DOM.NodeList (toArray)
import Web.DOM.ParentNode (QuerySelector(..), querySelectorAll)
import Web.Event.Event (EventType(..))
import Web.HTML (window)
import Web.HTML.HTMLDocument (toParentNode)
import Web.HTML.Window (document, innerHeight, scrollY)
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
isVisible sel = ʌ do
  win <- window
  doc <- document win
  screenHeight <- toNumber <$> innerHeight win

  nodeList <- querySelectorAll sel (toParentNode doc)
  nodes <- toArray nodeList
  let elements = nodes # mapMaybe fromNode

  case elements of
    [] -> η false
    [ element ] -> do
      rect <- getBoundingClientRect element
      η $ rect.top >= 0.0 && rect.bottom <= screenHeight
    _ -> η false

scroll :: EventType
scroll = EventType "scroll"

scrollTo :: ∀ m. MonadEffect m => Int -> Int -> m Unit
scrollTo x y = ʌ do
  win <- window
  Window.scroll x y win

getScrollY :: ∀ m. MonadEffect m => m Int
getScrollY = ʌ do
  win <- window
  y <- scrollY win
  η $ round y

placeElementInScreenYCenter :: ∀ m. MonadEffect m => Element -> m Unit
placeElementInScreenYCenter element = ʌ do
  win <- window
  rect <- getBoundingClientRect element

  screenHeight <- toNumber <$> innerHeight win

  let targetY = round $ rect.top + (rect.height / 2.0) - (screenHeight / 2.0)

  scrollTo 0 targetY