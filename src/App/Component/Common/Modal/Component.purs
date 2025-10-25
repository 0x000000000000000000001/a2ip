module App.Component.Common.Modal.Component
  ( component
  ) where

import Proem hiding (div)

import App.Component.Common.Modal.HandleAction (handleAction)
import App.Component.Common.Modal.HandleInnerOutput (handleInnerOutput)
import App.Component.Common.Modal.Style.Close as Close
import App.Component.Common.Modal.Style.Core as Core
import App.Component.Common.Modal.Style.Modal (classId)
import App.Component.Common.Modal.Style.Sheet (sheet)
import App.Component.Common.Modal.Type (Action(..), Input, Output, Slots, State, inner)
import App.Component.Util.Type (noHtml, noSlotAddressIndex)
import App.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..))
import Halogen (Component, ComponentHTML, defaultEval, mkComponent, mkEval)
import Halogen.HTML (div, slot)
import Halogen.HTML.Events (onClick)
import Html.Renderer.Halogen (render_)
import Util.Style (class_)

component
  :: ∀ q i o. Component q i o AppM
  -> Component q (Input i) (Output o) AppM
component innerComponent = mkComponent
  { initialState: \input -> 
      { closable: input.closable 
      , innerInput: input.innerInput
      }
  , render
  , eval: 
      mkEval 
      defaultEval 
      { handleAction = handleAction
      , receive = Just ◁ Receive 
      }
  }
  where 
  render :: State i -> ComponentHTML (Action i o) (Slots q o) AppM
  render s = 
    div 
      [ class_ classId
      , onClick HandleClick
      ]
      [ sheet
      , div 
          [ class_ Core.classId ]
          [ s.closable 
              ? (
                div
                  [ class_ Close.classId, onClick $ κ $ HandleCloseClick ]
                  [ render_ closeSvg ]
              ) 
              ↔ noHtml
          , slot
              inner
              noSlotAddressIndex
              innerComponent
              s.innerInput
              handleInnerOutput
          ]
      ]

  closeSvg :: String
  closeSvg = """
  <?xml version="1.0" encoding="utf-8"?><!-- Uploaded to: SVG Repo, www.svgrepo.com, Generator: SVG Repo Mixer Tools -->
  <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
  <circle cx="12" cy="12" r="10" stroke="#1C274C" stroke-width="1.5"/>
  <path d="M14.5 9.50002L9.5 14.5M9.49998 9.5L14.5 14.5" stroke="#1C274C" stroke-width="1.5" stroke-linecap="round"/>
  </svg>
  """