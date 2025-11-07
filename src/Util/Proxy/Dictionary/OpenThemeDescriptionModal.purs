module Util.Proxy.Dictionary.OpenThemeDescriptionModal where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

openThemeDescriptionModal' = Proxy :: Proxy "openThemeDescriptionModal"
openThemeDescriptionModal_ = ᴠ openThemeDescriptionModal' :: String
_openThemeDescriptionModal = prop openThemeDescriptionModal' :: ∀ a r. Lens' (Record (openThemeDescriptionModal :: a | r)) a
