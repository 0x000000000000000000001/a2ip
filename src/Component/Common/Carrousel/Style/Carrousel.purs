module Component.Common.Carrousel.Style.Carrousel
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS (justifyContent, rgba, white)
import CSS as CSS
import CSS.Background (backgroundColor)
import CSS.Common (center)
import Color (darken)
import Component.Common.PrettyErrorImage.Style.PrettyErrorImage as PrettyErrorImage
import Component.Common.PrettyErrorImage.Style.QuestionMark as QuestionMark
import Util.Style (backgroundColorNone, borderRadius1, displayFlex, fill, flexGrow1, heightPct100, heightRem, overflowHidden, positionRelative, raw, widthPct100, widthRem, (.?), (.|*.), (:&.), (:?), (:|*.))

classId :: String
classId = "bg2Md6TUT"

style :: CSS.CSS
style = do
  classId .? do
    positionRelative
    displayFlex
    justifyContent center
    heightRem 30.0
    widthRem 55.0
    backgroundColor $ rgba 0 0 0 0.6
    borderRadius1 0.6
    overflowHidden

  __indexImage :? do 
    widthPct100
    heightPct100
    raw "object-fit" "contain"

  ____errored :? do
    backgroundColorNone
    flexGrow1

  ______questionMark :? do
    fill $ darken 0.16 white
  
  where 
  __indexImage = classId .|*. PrettyErrorImage.classId 
  ____errored = __indexImage :&. PrettyErrorImage.classIdWhenErrored
  ______questionMark = ____errored :|*. QuestionMark.classId