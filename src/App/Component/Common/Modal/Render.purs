module App.Component.Common.Modal.Render
  ( render
  ) where

import Proem hiding (div)

import App.Component.Common.Modal.HandleInnerOutput (handleInnerOutput)
import App.Component.Common.Modal.Style.Core.Close (close)
import App.Component.Common.Modal.Style.Core.Core (core_)
import App.Component.Common.Modal.Style.Core.Sheet (sheet) as Core
import App.Component.Common.Modal.Style.Modal (modal)
import App.Component.Common.Modal.Style.Sheet (sheet)
import App.Component.Common.Modal.Type (Action(..), Slots, State)
import App.Component.Util.Type (noHtml, noSlotAddressIndex)
import App.Util.Capability.AppM (AppM)
import Halogen (Component, ComponentHTML)
import Halogen.HTML (slot)
import Halogen.HTML.Events (onClick)
import Html.Renderer.Halogen (render_)
import Util.Proxy.Dictionary.Inner (inner')

render 
  :: ∀ q i o
   . Component q i o AppM
  -> State i
  -> ComponentHTML (Action i o) (Slots q o) AppM
render innerComponent s@{ id, input: { closable, open, innerInput } } = 
  modal id
    (open ? [ onClick HandleClick ] ↔ [])    
    [ sheet s
    , not open 
        ? noHtml 
        ↔ core_
          [ Core.sheet
          , closable 
              ? ( 
                close 
                  [ onClick $ κ $ HandleCloseClick ]
                  [ render_ closeSvg ]
              ) 
              ↔ noHtml
          , slot
              inner'
              noSlotAddressIndex
              innerComponent
              innerInput
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
