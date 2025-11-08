module App.Component.Common.PrettyErrorImage.Style.QuestionMark
  ( class'
  , staticClass
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.PrettyErrorImage.Type (State)
import CSS (darken, opacity)
import CSS as CSS
import Util.Style.Style (fill, loadingGrey, nothing, inferClass, reflectStaticClass, svg, widthRem, (.?), (.|>), (:?))

staticClass :: String
staticClass = reflectStaticClass ι

class' :: String -> String
class' = inferClass staticClass

style :: State -> CSS.CSS
style 
  { id
  , input: 
      { loading
      , style: 
          { questionMark:
              { when:
                  { errored:
                      { color: color
                      }
                  }
              }
          }
      } 
  } = do
  staticClass .? do
    widthRem 3.0

  class' id .? do
    nothing

    when loading do
      opacity 0.0

  __svg :? do
    fill $ color ??⇒ darken 0.4 loadingGrey
    
  where 
  __svg = class' id .|> svg