module Util.Module
  ( reflectCallingModuleName
  )
  where

import Data.Unit (Unit)

foreign import reflectCallingModuleName :: Unit -> String