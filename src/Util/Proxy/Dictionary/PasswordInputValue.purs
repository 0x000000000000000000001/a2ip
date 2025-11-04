module Util.Proxy.Dictionary.PasswordInputValue where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

passwordInputValue' = Proxy :: Proxy "passwordInputValue"
passwordInputValue_ = ᴠ passwordInputValue' :: String
_passwordInputValue = prop passwordInputValue' :: forall a r. Lens' (Record (passwordInputValue :: a | r)) a
