module App.Component.Common.Input.Render
  ( render
  ) where

import Proem hiding (div)

import App.Component.Common.Input.Style.Field (field)
import App.Component.Common.Input.Style.Input (staticClass, staticClassWhenOpen)
import App.Component.Common.Input.Style.Label as Label
import App.Component.Common.Input.Style.Sheet (sheet)
import App.Component.Common.Input.Type (Action(..), Slots, State)
import App.Component.Common.Input.Util (inputRef)
import App.Component.Util.Type (noHtml)
import App.Util.Capability.AppM (AppM)
import Data.Array ((:))
import Halogen (ComponentHTML)
import Halogen.HTML (div, text)
import Halogen.HTML as HH
import Halogen.HTML.Events (onBlur, onClick, onFocus, onMouseDown, onValueInput)
import Halogen.HTML.Properties (ref)
import Halogen.HTML.Properties as HP
import Util.Style.Style (class_, classes)

render :: State -> ComponentHTML Action Slots AppM
render s@{ id, open, input: { placeholder, label } } =
  div
    [ classes
        [ staticClass
        , open ? staticClassWhenOpen ↔ ""
        ]
    , onClick $ κ HandleClick
    ]
    [ sheet s
    , label
        ??
          ( \l ->
              HH.label
                ( [ class_ Label.staticClass ]
                    <>
                      ( open
                          ? [ onClick HandleLabelClick
                            , onMouseDown HandleLabelMouseDown
                            ]
                          ↔ []
                      )
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
