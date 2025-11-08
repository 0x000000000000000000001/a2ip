module App.Component.Common.PrettyErrorImage.Style.QuestionMark
  ( statefulClass
  , statelessClass
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.PrettyErrorImage.Type (State)
import CSS (darken, opacity)
import CSS as CSS
import Util.Style.Style (fill, loadingGrey, nothing, inferStatefulClass, reflectStatelessClass, svg, widthRem, (.?), (.|>), (:?))

statelessClass :: String
statelessClass = reflectStatelessClass ι

statefulClass :: String -> String
statefulClass id = inferStatefulClass statelessClass id

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
  statelessClass .? do
    widthRem 3.0

  statefulClass id .? do
    nothing

    when loading do
      opacity 0.0

  __svg :? do
    fill $ color ??⇒ darken 0.4 loadingGrey
    
  where 
  __svg = statefulClass id .|> svg