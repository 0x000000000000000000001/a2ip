module App.Component.Common.PrettyErrorImage.Style.QuestionMark
  ( class'
  , questionMark
  , questionMark_
  , staticClass
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.PrettyErrorImage.Type (State)
import App.Component.Util.Type (Size(..), applyToSize)
import CSS (darken, opacity, width)
import CSS as CSS
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, IProp)
import Html.Renderer.Halogen (render)
import Util.Style.Style (classes, fill, inferClass, loadingGrey, noCss, reflectStaticClass, svg, (.?), (.|>), (:?))

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
              { width: width'
              , when:
                  { errored:
                      { color: color
                      }
                  }
              }
          }
      } 
  } = do
  staticClass .? do
    noCss

  class' id .? do
    applyToSize width $ width' ??⇒ (Rem 3.0)

    when loading do
      opacity 0.0

  __svg :? do
    fill $ color ??⇒ darken 0.4 loadingGrey
    
  where 
  __svg = class' id .|> svg

questionMark :: ∀ w i. String -> Array (IProp HTMLdiv i) -> String -> HTML w i
questionMark id props = 
  render
  ([ classes [ staticClass, class' id ] ] <> props)

questionMark_ :: ∀ w i. String -> String -> HTML w i
questionMark_ id svgXml = questionMark id [] svgXml
