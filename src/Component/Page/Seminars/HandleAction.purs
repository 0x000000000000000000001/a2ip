module Component.Page.Seminars.HandleAction
  ( handleAction
  , seminarsTabId
  )
  where

import Proem

import Component.Page.Seminars.Type (Action(..), SeminarsM)
import Data.Maybe (Maybe(..))
import Halogen (modify_)

seminarsTabId = "1531940447" :: String

handleAction :: Action -> SeminarsM Unit
handleAction = case _ of 
  SelectDate date -> modify_ _ { selectedDate = Just date }
