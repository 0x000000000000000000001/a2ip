module Ui.Component.Common.Carrousel.Style.Media
  ( class'
  , media
  , media_
  , staticClass
  , style
  )
  where

import Proem hiding (top, div)

import Ui.Component.Common.Carrousel.Type (Media(..), State)
import CSS (backgroundColor, black)
import CSS as CSS
import DOM.HTML.Indexed (HTMLdiv)
import Data.Array ((!!))
import Data.Maybe (Maybe(..))
import Halogen.HTML (HTML, Node, div)
import Util.Style.Style (classes, heightPct100, inferClass, noCss, positionRelative, raw, reflectStaticClass, topLeftToTopLeft, widthPct100, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

class' :: String -> String
class' = inferClass staticClass

style :: State -> CSS.CSS
style { id, index, input: { slides } } = do
  staticClass .? do
    positionRelative
    widthPct100
    heightPct100
    topLeftToTopLeft
    raw "transition" "background-color 0s"

  class' id .? do 
    let
      slide = slides !! index
      media' = slide <#> _.media

    case media' of 
      Just (YoutubeVideo _) -> backgroundColor black
      _ -> noCss

media :: ∀ w i. String -> Node HTMLdiv w i
media id props = div ([ classes [staticClass, class' id] ] <> props)

media_ :: ∀ w i. String -> Array (HTML w i) -> HTML w i
media_ id = media id []