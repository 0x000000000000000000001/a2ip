module Util.Proxy.Dictionary.SelectedSeminar where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

selectedSeminar' = Proxy :: Proxy "selectedSeminar"
selectedSeminar_ = ᴠ selectedSeminar' :: String
_selectedSeminar = prop selectedSeminar' :: ∀ a r. Lens' (Record (selectedSeminar :: a | r)) a
