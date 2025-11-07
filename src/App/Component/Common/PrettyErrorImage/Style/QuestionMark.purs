module App.Component.Common.PrettyErrorImage.Style.QuestionMark
  ( statefulClass
  , statelessClass
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.PrettyErrorImage.Type (State)
import CSS (darken)
import CSS as CSS
import Halogen.HTML.Properties (id)
import Util.Style.Style (fill, loadingGrey, nothing, refineClass, reflectHashModuleName, svg, widthRem, (.?), (.|*), (.|>), (:?))

statelessClass :: String
statelessClass = reflectHashModuleName ι

statefulClass :: String -> String
statefulClass id = refineClass statelessClass id

style :: ∀ u. State u -> CSS.CSS
style 
  { id
  , input: 
      { style: 
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
  statelessClass .? do
    nothing

  statefulClass id .? do
    widthRem 3.0

  __svg :? do
      fill $ color ??⇒ darken 0.4 loadingGrey

  where 
  __svg = statefulClass id .|> svg