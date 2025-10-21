module Component.Page.Seminars.HandleAction
  ( handleAction
  ) where

import Proem

import Component.Page.Seminars.Type (Action(..), ComponentM)
import Data.Maybe (Maybe(..))
import Halogen (modify_)

handleAction :: Action -> ComponentM Unit
handleAction = case _ of 
  SelectDate date -> modify_ _ { selectedDate = Just date }
