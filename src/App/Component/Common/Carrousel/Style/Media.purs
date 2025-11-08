module App.Component.Common.Carrousel.Style.Media
  ( class'
  , staticClass
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.Carrousel.Type (Media(..), State)
import CSS (black)
import CSS as CSS
import CSS.Background (backgroundColor)
import Data.Array ((!!))
import Data.Maybe (Maybe(..))
import Util.Style.Style (heightPct100, nothing, positionRelative, raw, inferClass, reflectStaticClass, topLeftToTopLeft, widthPct100, (.?))

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
      media = slide <#> _.media

    case media of 
      Just (YoutubeVideo _) -> backgroundColor black
      _ -> nothing
