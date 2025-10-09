module Component.Common.PrettyErrorImage.Render 
  ( render
  )
  where

import Prelude hiding (div)

import Capability.AppM (AppM)
import Component.Common.PrettyErrorImage.Type (Action(..), Slots, State)
import Data.Maybe (Maybe(..), fromMaybe)
import Halogen (ComponentHTML)
import Halogen.HTML (img, text)
import Halogen.HTML.Events (onError)
import Halogen.HTML.Properties (src)
import Util.Style (class_)

render :: State -> ComponentHTML Action Slots AppM
render s = 
  if s.errored 
  then text "error" 
  else img (
    (if s.class_ == Nothing then [] else [ class_ $ fromMaybe "" s.class_ ]) 
    <> (if s.src == Nothing then [] else [ src $ fromMaybe "" s.src ]) 
    <> [ onError $ const HandleError ]
  )