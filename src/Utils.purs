module Utils
  ( class_
  , ourRed
  ) where

import Prelude

import CSS.Color (Color, hsl)
import Data.Maybe (fromMaybe)
import Data.String (Pattern(..), stripPrefix)
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP

ourRed :: Color
ourRed = hsl 353.91 0.8174 0.4725

-- | Utility function to set the class attribute on an HTML element.
-- | It automatically removes any "." prefix from the class name.
class_ :: forall r i. String -> HH.IProp (class :: String | r) i
class_ className = HP.class_ $ HH.ClassName $
  fromMaybe className (stripPrefix (Pattern ".") className)