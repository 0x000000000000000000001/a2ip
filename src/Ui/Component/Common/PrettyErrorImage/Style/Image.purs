module Ui.Component.Common.PrettyErrorImage.Style.Image
  ( class'
  , image
  , image_
  , staticClass
  , style
  )
  where

import Proem hiding (top)

import Ui.Component.Common.PrettyErrorImage.Type (State)
import CSS (opacity)
import CSS as CSS
import DOM.HTML.Indexed (HTMLimg)
import Halogen.HTML (HTML, Leaf, img)
import Util.Style.Image (fill, objectFit)
import Util.Style.Style (classes, heightPct100, inferClass, reflectStaticClass, widthPct100, (.?))

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

image :: ∀ w i. String -> Leaf HTMLimg w i
image id props = img ([ classes [staticClass, class' id] ] <> props)

image_ :: ∀ w i. String -> HTML w i
image_ id = image id []