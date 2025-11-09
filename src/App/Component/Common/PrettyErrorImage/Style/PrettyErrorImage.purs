module App.Component.Common.PrettyErrorImage.Style.PrettyErrorImage
  ( class'
  , staticClass
  , style
  ) where

import Proem hiding (top)

import App.Component.Common.PrettyErrorImage.Type (State, Try(..))
import App.Component.Util.Type (applyToSize)
import CSS (backgroundColor, borderColor, height, hover, solid, width)
import CSS as CSS
import Util.Style.Style (alignItemsCenter, borderRadius1, borderStyle, borderWidth1, displayFlex, inferClass, justifyContentCenter, loading, loadingGrey, nothing, overflowHidden, positionRelative, reflectStaticClass, (.&), (.?), (:?))

staticClass :: String
staticClass = reflectStaticClass ι

class' :: String -> String
class' = inferClass staticClass

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
          , with: 
              { hover: 
                  { border: border'
                  }
              }
          }
      }
  } = do
  staticClass .? do
    positionRelative
    borderStyle solid
    overflowHidden

  class' id .? do
    width' ?? (applyToSize width) ⇔ nothing
    height' ?? (applyToSize height) ⇔ nothing
    border.radius ?? (applyToSize borderRadius1) ⇔ nothing
    border.width ?? borderWidth1 ⇔ nothing
    border.color ?? borderColor ⇔ nothing
    
    when (try == StopTrying) do
      displayFlex
      justifyContentCenter
      alignItemsCenter
      backgroundColor $ backgroundColor' ??⇒ loadingGrey

    when loading' do
      loading
  
  __hover :? do
      border'.radius ?? (applyToSize borderRadius1) ⇔ nothing
      border'.width ?? borderWidth1 ⇔ nothing
      border'.color ?? borderColor ⇔ nothing
        
  where
  __hover = class' id .& hover
