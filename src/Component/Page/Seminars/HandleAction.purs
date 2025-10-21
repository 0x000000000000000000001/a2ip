module Component.Page.Seminars.HandleAction
  ( handleAction
  ) where

import Proem

import Component.Page.Seminars.Type (Action(..), SeminarsM)
import Data.Maybe (Maybe(..))
import Halogen (modify_)

handleAction :: Action -> SeminarsM Unit
handleAction = case _ of 
  SelectDate date -> modify_ _ { selectedDate = Just date }
