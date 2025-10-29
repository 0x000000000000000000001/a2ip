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

import App.Component.Common.Timeline.Type (TimelineM, date)
import App.Component.Common.Timeline.Util (dateToDataAttr)
import Data.Array (head, mapMaybe)
import Data.Date (Date)
import Data.Foldable (for_)
import Data.Maybe (Maybe(..))
import Util.Html.Dom (dataAttrQuerySelector, isVisible, placeElementInScreenYCenter)
import Web.DOM.Element (Element, QuerySelector, fromNode)
import Web.DOM.NodeList (toArray)
import Web.DOM.ParentNode (querySelectorAll)
import Web.HTML (window)
import Web.HTML.HTMLDocument (toParentNode)
import Web.HTML.Window (document)

scrollToDate :: Date -> TimelineM Unit
scrollToDate date_ = do
  element <- getDateElement date_

  for_ element placeElementInScreenYCenter

isDateVisible :: Date -> TimelineM Boolean
isDateVisible date_ = isVisible $ dateQuerySelector (Just date_)

dateQuerySelector :: Maybe Date -> QuerySelector
dateQuerySelector date_ = dataAttrQuerySelector date (Just $ dateToDataAttr date_)

getDateElement :: Date -> TimelineM (Maybe Element)
getDateElement date = do 
  elements <- getDateElements (Just date) 
  pure $ elements >>= head 

getAllDateElements :: TimelineM (Maybe (Array Element))
getAllDateElements = getDateElements Nothing

getDateElements :: Maybe Date -> TimelineM (Maybe (Array Element))
getDateElements date = ʌ do
  win <- window
  doc <- document win
  nodeList <- querySelectorAll (dateQuerySelector date) (toParentNode doc)
  nodes <- toArray nodeList
  let elements = nodes # mapMaybe fromNode
  case elements of
    [] -> η Nothing
    _ -> η $ Just elements
