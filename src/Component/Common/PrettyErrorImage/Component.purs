module Component.Common.PrettyErrorImage.Component
  ( component
  )
  where

import Proem

import CSS (face)
import Capability.AppM (AppM)
import Component.Common.PrettyErrorImage.HandleAction (handleAction)
import Component.Common.PrettyErrorImage.Render (render)
import Component.Common.PrettyErrorImage.Type (Action(..), Input, Output, Query)
import Data.Maybe (Maybe(..))
import Halogen (Component, defaultEval, mkComponent, mkEval)

component :: Component Query Input Output AppM
component = mkComponent
    { initialState: \input -> 
        { errorCount: 0  
        , src: input.src
        , fallbackSrc: input.fallbackSrc
        , class_: input.class_
        }
    , render   
    , eval: mkEval defaultEval
        { handleAction = handleAction
        , receive = \input -> Just $ Receive input
        }
    }