module App.Component.Common.Carrousel.Style.Media
  ( statefulClass
  , statelessClass
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
import Util.Style (heightPct100, nothing, positionRelative, raw, refineClass, reflectHashModuleName, topLeftToTopLeft, widthPct100, (.?))

statelessClass :: String
statelessClass = reflectHashModuleName ι

statefulClass :: String -> String
statefulClass id = refineClass statelessClass id

style :: State -> CSS.CSS
style { id, index, input: { slides } } = do
  statelessClass .? do
    positionRelative
    widthPct100
    heightPct100
    topLeftToTopLeft
    raw "transition" "background-color 0s"

  -- __image :? do 
  --   asset
  --   raw "object-fit" "contain"

  statefulClass id .? do 
    let
      slide = slides !! index
      media = slide <#> _.media

    case media of 
      Just (YoutubeVideo _) -> backgroundColor black
      _ -> nothing

  -- __youtubeVideo :? do 
  --   asset

  -- where 
  -- __image = statelessClass .|*. PrettyErrorImage.statelessClass 
  -- __youtubeVideo = statelessClass .|*. YoutubeVideo.classId 

-- asset ∷ StyleM Unit
-- asset = do 
--   positionRelative
--   widthPct100
--   heightPct100