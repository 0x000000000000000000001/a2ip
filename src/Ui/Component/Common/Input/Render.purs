module App.Component.Common.Input.Render
  ( render
  ) where

import Proem hiding (div)

import App.Component.Common.Input.Style.Field (field)
import App.Component.Common.Input.Style.Input (input)
import App.Component.Common.Input.Style.Label (label)
import App.Component.Common.Input.Style.Sheet (sheet)
import App.Component.Common.Input.Type (Action(..), Slots, State)
import App.Component.Common.Input.Util (inputRef)
import App.Component.Util.Type (noHtml)
import App.Util.Capability.AppM (AppM)
import Data.Array ((:))
import Halogen (ComponentHTML)
import Halogen.HTML (text)
import Halogen.HTML.Events (onBlur, onClick, onFocus, onMouseDown, onValueInput)
import Halogen.HTML.Properties (ref)
import Halogen.HTML.Properties as HP

render :: State -> ComponentHTML Action Slots AppM
render s@{ id, open, input: { placeholder, label: label' } } =
  input open 
    [ onClick $ κ HandleClick ]
    [ sheet s
    , label'
        ??
          ( \l ->
              label
                ( open
                    ? [ onClick HandleLabelClick
                      , onMouseDown HandleLabelMouseDown
                      ]
                    ↔ []
                )
                [ text l ]
          )
        ⇔ noHtml
    , field id
        ( [ ref inputRef
          , onValueInput HandleNewValue
          , onFocus $ κ HandleFocus
          , onBlur $ κ HandleBlur
          ]
            <>
              ( open
                  ? (placeholder ?? (HP.placeholder ▷ (_ : [])) ⇔ [])
                  ↔ []
              )
        )
    ]
