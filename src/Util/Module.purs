module Util.Module
  ( captureCallingModuleName
  )
  where

import Data.Unit (Unit)

foreign import captureCallingModuleName :: Unit -> String