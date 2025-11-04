module App.Component.Common.Vault.Style.Front
  ( classId
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.Input.Style.Field as Field
import App.Component.Common.Input.Style.Input as Input
import App.Component.Common.Input.Style.Label as Label
import CSS (backgroundColor, border, borderBottom, color, column, darken, flexDirection, fromString, opacity, outline, rem, rgba, solid, white, zIndex)
import CSS as CSS
import Util.Style (alignItemsCenter, displayFlex, heightPct100, heightRem, justifyContentCenter, margin1, nothing, placeholder, positionRelative, red, svg, topLeftToTopLeft, transparent, widthPct100, widthRem, (.?), (.|*.), (.|*:), (:&:), (:?), (:|*.), (:|*:))

classId :: String
classId = "j8djWsw23"

style :: CSS.CSS
style = do
  classId .? do
    positionRelative
    topLeftToTopLeft
    zIndex 2
    backgroundColor $ rgba 0 0 0 0.75
    widthPct100
    heightPct100
    displayFlex
    justifyContentCenter
    alignItemsCenter
    flexDirection column

  __svg :? do 
    widthRem 8.0
    heightRem 8.0
    margin1 1.2
    opacity 0.9

  __input :? do
    nothing

  ____field :? do 
    outline solid (rem 0.2) white
    borderBottom solid (rem 0.0) white
    backgroundColor transparent
    color white

  ______placeholder :? do
    color $ darken 0.24 white

  ____label :? do
    color white

  where 
  __svg = classId .|*: svg
  __input = classId .|*. Input.classId
  ____field = __input :|*. Field.classId
  ______placeholder = ____field :&: placeholder
  ____label = __input :|*. Label.classId
