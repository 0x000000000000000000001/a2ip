module Component.Common.Separator.Style.Wing.Wing
  ( classId
  , classIdWhenNth
  , style
  )
  where

import Proem hiding (top)

import CSS (backgroundColor, pct, transform, translate)
import CSS as CSS
import Component.Common.Separator.Style.Util (grey)
import Component.Common.Separator.Style.Wing.End as End
import Util.Style (borderRadius1, flexGrow1, hash9, heightRem, left0, positionAbsolute, positionRelative, right0, top0, (.?), (.|*.), (:?))

classId :: String
classId = "nSWR5IYn6"

classIdWhenNth :: Int -> String
classIdWhenNth n = hash9 $ classId <> show n

style :: CSS.CSS
style = do
  classId .? do
    flexGrow1
    heightRem 0.1
    backgroundColor grey
    borderRadius1 3.0

  a_end :? do 
    positionAbsolute
    top0

  classIdWhenNth 1 .? do
    positionRelative
     
  b_end :? do 
    left0
    transform $ translate (pct $ -50.0) (pct $ -50.0)

  classIdWhenNth 2 .? do
    positionRelative
     
  c_end :? do 
    right0
    transform $ translate (pct $ 50.0) (pct $ -50.0)
    
  where 
  a_end = classId .|*. End.classId
  b_end = classIdWhenNth 1 .|*. End.classId
  c_end = classIdWhenNth 2 .|*. End.classId