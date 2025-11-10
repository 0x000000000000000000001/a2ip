module App.Component.Common.Timeline.HandleAction.Util
  ( dateQuerySelector
  , getAllDateElements
  , getDateElement
  , getDateElements
  , isDateVisible
  , scrollToDate
  )
  where

import Proem

import App.Component.Common.Timeline.Type (TimelineM)
import App.Component.Common.Timeline.Util (dateToDataAttr)
import Data.Array (head, mapMaybe)
import Data.Date (Date)
import Data.Foldable (for_)
import Data.Maybe (Maybe(..))
import Util.Html.Dom (dataAttrQuerySelector, isVisible, placeElementInScreenYCenter)
import Util.Proxy.Dictionary.Date (date')
import Web.DOM.Element (Element, QuerySelector, fromNode)
import Web.DOM.NodeList (toArray)
import Web.DOM.ParentNode (querySelectorAll)
import Web.HTML (window)
import Web.HTML.HTMLDocument (toParentNode)
import Web.HTML.Window (document)

scrollToDate :: ∀ w i. Date -> TimelineM w i Unit
scrollToDate date_ = do
  element <- getDateElement date_

  for_ element placeElementInScreenYCenter

isDateVisible :: ∀ w i. Date -> TimelineM w i Boolean
isDateVisible date_ = isVisible $ dateQuerySelector (Just date_)

dateQuerySelector :: Maybe Date -> QuerySelector
dateQuerySelector date_ = dataAttrQuerySelector date' (date_ <#> dateToDataAttr)

getDateElement :: ∀ w i. Date -> TimelineM w i (Maybe Element)
getDateElement date = do 
  elements <- getDateElements (Just date) 
  pure $ elements >>= head 

getAllDateElements :: ∀ w i. TimelineM w i (Maybe (Array Element))
getAllDateElements = getDateElements Nothing

getDateElements :: ∀ w i. Maybe Date -> TimelineM w i (Maybe (Array Element))
getDateElements date = ʌ do
  doc <- document =<< window

  nodeList <- querySelectorAll (dateQuerySelector date) (toParentNode doc)
  nodes <- toArray nodeList
  
  let elements = nodes # mapMaybe fromNode
  
  case elements of
    [] -> η Nothing
    _ -> η $ Just elements
