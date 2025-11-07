module Util.Proxy.Dictionary.ThemeDescription where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

themeDescription' = Proxy :: Proxy "themeDescription"
themeDescription_ = ᴠ themeDescription' :: String
_themeDescription = prop themeDescription' :: ∀ a r. Lens' (Record (themeDescription :: a | r)) a
