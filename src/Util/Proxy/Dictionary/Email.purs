module Util.Proxy.Dictionary.Email where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

email' = Proxy :: Proxy "email"
email_ = ᴠ email' :: String
_email = prop email' :: ∀ a r. Lens' (Record (email :: a | r)) a
