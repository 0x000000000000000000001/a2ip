module Util.Proxy.Dictionary.QuestionMark where

import Data.Lens (Lens')
import Data.Lens.Record (prop)
import Proem (ᴠ)
import Type.Prelude (Proxy(..))

questionMark' = Proxy :: Proxy "questionMark"
questionMark_ = ᴠ questionMark' :: String
_questionMark = prop questionMark' :: forall a r. Lens' (Record (questionMark :: a | r)) a
