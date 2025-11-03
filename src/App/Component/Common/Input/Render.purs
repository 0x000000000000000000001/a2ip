module App.Component.Common.Input.Render
  ( render
  ) where

import Proem hiding (div)

import App.Component.Common.Input.Style.Field as Field
import App.Component.Common.Input.Style.Input (classId, classIdWithFocus)
import App.Component.Common.Input.Style.Label as Label
import App.Component.Common.Input.Style.Sheet (sheet)
import App.Component.Common.Input.Type (Action(..), Slots, State)
import App.Util.Capability.AppM (AppM)
import Data.Array ((:))
import Halogen (ComponentHTML)
import Halogen.HTML (div, input, text)
import Halogen.HTML as HH
import Halogen.HTML.Events (onBlur, onFocus, onValueInput)
import Halogen.HTML.Properties as HP
import Util.Style (classes)

render :: State -> ComponentHTML Action Slots AppM
render s@{ focus, input: { placeholder, label, class_: class' } } =
    div
        [ classes 
            [ classId
            , class' ??⇒ ""
            , focus ? classIdWithFocus ↔ "" 
            ] 
        ]
        ( [ sheet s ]
            <>
            ( label
                ??
                    ( \l ->
                        [ HH.label
                            [ classes [ Label.classId ] ]
                            [ text l ]
                        ]
                    )
                ⇔ []
            )
            <>
            [ input
                $
                    [ classes [ Field.classId ]
                    , onValueInput HandleNewValue
                    , onFocus $ κ HandleFocus
                    , onBlur $ κ HandleBlur
                    ]
                <> (
                    focus 
                    ? (placeholder ?? (HP.placeholder ▷ (_ : [])) ⇔ [])
                    ↔ []
                )
            ]
        )
