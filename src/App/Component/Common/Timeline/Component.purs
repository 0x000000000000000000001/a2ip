module App.Component.Common.Timeline.Component
  ( component
  ) where

import Proem

import App.Util.Capability.AppM (AppM)
import App.Component.Common.Timeline.HandleAction.HandleAction (handleAction)
import App.Component.Common.Timeline.Render (render)
import App.Component.Common.Timeline.Type (Action(..), Input, Output, Query)
import Data.Array (nubEq)
import Data.Maybe (Maybe(..))
import Halogen (Component, defaultEval, mkComponent, mkEval)

component :: Component Query Input Output AppM
component = mkComponent
  { initialState: \input ->
      let
        dates = input.dates # nubEq
      in
        { input: input { dates = dates }
        , selectedDate: Nothing
        , scrollFork: Nothing
        }
  , render
  , eval: mkEval defaultEval
      { handleAction = handleAction
      , receive = Just ◁ Receive
      , initialize = Just Initialize
      }
  }