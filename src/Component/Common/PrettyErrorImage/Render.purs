module Component.Common.PrettyErrorImage.Render 
  ( render
  )
  where

import Prelude hiding (div)

import Capability.AppM (AppM)
import Component.Common.PrettyErrorImage.Type (Action(..), Slots, State)
import Data.Array (length)
import Halogen (ComponentHTML)
import Halogen.HTML (img, text)
import Halogen.HTML.Events (onError)
import Util.Log (unsafeDebugShow)

render :: State -> ComponentHTML Action Slots AppM
render s = 
  let _ = unsafeDebugShow $ length s.iProps
  in 
  if s.errored 
  then text "error" 
  else img $ s.iProps <> [ onError $ const HandleError ]