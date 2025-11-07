module App.Component.Common.PrettyErrorImage.Style.QuestionMark
  ( statelessClass
  , style
  ) where

import Proem hiding (top)

import App.Component.Common.PrettyErrorImage.Type (State)
import CSS (darken)
import CSS as CSS
import Util.Style.Style (fill, loadingGrey, reflectHashModuleName, widthRem, (.?))

statelessClass :: String
statelessClass = reflectHashModuleName ι

style :: ∀ u. State u -> CSS.CSS
style 
  { input: 
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
    widthRem 3.0
    fill $ color ??⇒ darken 0.4 loadingGrey