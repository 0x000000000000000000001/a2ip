module App.Component.Common.PrettyErrorImage.Style.PrettyErrorImage
  ( statefulClass
  , statelessClass
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.PrettyErrorImage.Type (State, Try(..))
import App.Component.Util.Type (applyToSize)
import CSS (backgroundColor, borderColor, height, solid, width)
import CSS as CSS
import Util.Style.Style (alignItemsCenter, borderRadius1, borderStyle, borderWidthRem1, displayFlex, justifyContentCenter, loading, loadingGrey, nothing, overflowHidden, positionRelative, inferStatefulClass, reflectStatelessClass, (.?))

statelessClass :: String
statelessClass = reflectStatelessClass ι

statefulClass :: String -> String
statefulClass id = inferStatefulClass statelessClass id

style :: State -> CSS.CSS
style 
  { id
  , try
  , input: 
      { loading: loading' 
      , style: 
          { width: width'
          , height: height'
          , border
          , when: 
              { errored: 
                  { backgroundColor: backgroundColor'
                  }
              }
          }
      } 
  } = do
  statelessClass .? do 
    positionRelative
    borderStyle solid
    overflowHidden

  statefulClass id .? do
    width' ?? (applyToSize width) ⇔ nothing
    height' ?? (applyToSize height) ⇔ nothing
    border 
      ?? (\border' -> do 
        border'.radius ?? (applyToSize borderRadius1) ⇔ nothing
        border'.width ?? borderWidthRem1 ⇔ nothing
        border'.color ?? borderColor ⇔ nothing
      )
      ⇔ nothing

    when (try == StopTrying) do
      displayFlex
      justifyContentCenter
      alignItemsCenter
      backgroundColor $ backgroundColor' ??⇒ loadingGrey

    when loading' do 
      loading
