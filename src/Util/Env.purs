module Util.Env
  ( isNode
  , isBrowser
  ) where

import Prelude

foreign import isNode :: Boolean

isBrowser :: Boolean
isBrowser = not isNode
