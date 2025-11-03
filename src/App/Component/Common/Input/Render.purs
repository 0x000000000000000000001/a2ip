module App.Component.Common.Input.Render
  ( render
  ) where

import Proem hiding (div)

import App.Component.Common.Input.Style.Field as Field
import App.Component.Common.Input.Style.Input (classId)
import App.Component.Common.Input.Style.Label as Label
import App.Component.Common.Input.Style.Sheet (sheet)
import App.Component.Common.Input.Type (Action(..), Slots, State)
import App.Util.Capability.AppM (AppM)
import Data.Array ((:))
import Halogen (ComponentHTML)
import Halogen.HTML (div, input, text)
import Halogen.HTML as HH
import Halogen.HTML.Events (onValueInput)
import Halogen.HTML.Properties as HP
import Util.Log (unsafeDebugShow)
import Util.Style (classes)

render :: State -> ComponentHTML Action Slots AppM
render state@{ input: { placeholder, label, class_: class' } } =
    let _ = unsafeDebugShow "render" in
    div
        [ classes $ [ classId ] <> (class' ?? (_ : []) ⇔ []) ]
        ( [ sheet state ]
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
                    --   , HP.value value
                    , onValueInput HandleInput
                    ]
                    <> (placeholder ?? (HP.placeholder ▷ (_ : [])) ⇔ [])
                ]
        )
