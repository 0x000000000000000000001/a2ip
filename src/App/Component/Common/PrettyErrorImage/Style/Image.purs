module App.Component.Common.PrettyErrorImage.Style.Image
  ( class'
  , staticClass
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.PrettyErrorImage.Type (State)
import CSS (opacity)
import CSS as CSS
import Util.Style.Image (fill, objectFit)
import Util.Style.Style (heightPct100, inferClass, reflectStaticClass, widthPct100, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

class' :: String -> String
class' = inferClass staticClass

style :: State -> CSS.CSS
style 
  { id
  , input: 
      { loading: loading' 
      , style: 
          { fit
          }
      } 
  } = do
  staticClass .? do 
    widthPct100
    heightPct100

  class' id .? do
    objectFit $ fit ??⇒ fill

    when loading' do 
      opacity 0.0
