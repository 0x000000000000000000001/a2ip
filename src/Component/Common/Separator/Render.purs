module Component.Common.Separator.Render
  ( render
  )
  where

import Proem hiding (div)

import Capability.AppM (AppM)
import Component.Common.Separator.Style.Separator (classId)
import Component.Common.Separator.Style.Sheet (sheet)
import Component.Common.Separator.Style.Text as Text
import Component.Common.Separator.Style.Wing as Wing
import Component.Common.Separator.Type (Action, Slots, State)
import Halogen (ComponentHTML)
import Halogen.HTML (div, text)
import Util.Style (class_)

render :: State -> ComponentHTML Action Slots AppM
render s = 
  div 
  [ class_ classId ]
  [ sheet
  , div [ class_ Wing.classId ] [] 
  , div [ class_ Text.classId ] [ text s.text ]
  , div [ class_ Wing.classId ] []
  ]