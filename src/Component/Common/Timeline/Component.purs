module Component.Common.Timeline.Component
  ( component
  ) where

import Proem

import Capability.AppM (AppM)
import Component.Common.Timeline.HandleAction (handleAction)
import Component.Common.Timeline.Render (render)
import Component.Common.Timeline.Type (Action(..), Input, Output, Query)
import Data.Array (nubEq, (!!))
import Data.Maybe (Maybe(..))
import Halogen (Component, defaultEval, mkComponent, mkEval)

component :: Component Query Input Output AppM
component = mkComponent
  { initialState: \input ->
      let
        dates = input.dates # nubEq
      in
        { class_: input.class_
        , dates
        , selectedDate: dates !! 0
        , scrollFork: Nothing
        }
  , render
  , eval: mkEval defaultEval
      { handleAction = handleAction
      , receive = Just ◁ Receive
      , initialize = Just Initialize
      }
  }