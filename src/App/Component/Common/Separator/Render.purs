module App.Component.Common.Separator.Render
  ( render
  ) where

import Proem hiding (div)

import App.Component.Common.Separator.Style.Separator (classId, classIdWhenLoading)
import App.Component.Common.Separator.Style.Sheet (sheet)
import App.Component.Common.Separator.Style.Text.Text as Text
import App.Component.Common.Separator.Type (Action, Slots, State, TextElementTag)
import App.Util.Capability.AppM (AppM)
import Data.String (toLower)
import Halogen (ComponentHTML)
import Halogen.HTML (div, text)
import Halogen.HTML.Core (ElemName(..))
import Halogen.HTML.Elements (element)
import Util.Style (class_, classes)

render :: State -> ComponentHTML Action Slots AppM
render s =
  div
    [ classes
        $ [ classId ]
        <> (s.loading ? [ classIdWhenLoading ] ↔ [])
    ]
    [ sheet
    , element
        (s.textElementTag # name)
        [ class_ Text.classId ]
        [ text s.text ]
    ]

name :: TextElementTag -> ElemName
name = ElemName ◁ toLower ◁ show 