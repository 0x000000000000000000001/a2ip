module App.Component.Common.PrettyErrorImage.Component
  ( component
  ) where

import Proem

import App.Component.Common.PrettyErrorImage.HandleAction (handleAction)
import App.Component.Common.PrettyErrorImage.Render (render)
import App.Component.Common.PrettyErrorImage.Type (Action(..), Input, Output, Query, Try(..))
import App.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..))
import Halogen (Component, defaultEval, mkComponent, mkEval)

component :: Component Query Input Output AppM
component = mkComponent
  { initialState: \input ->
      { class_: input.class_
      , try: \input -> input.sources ?? (Just ◁ FirstTry ◁ _.first) ⇔ Just StopTrying
      , input: Nothing
      }
  , render
  , eval: mkEval defaultEval
      { handleAction = handleAction
      , receive = \input -> Just $ Receive input
      }
  }