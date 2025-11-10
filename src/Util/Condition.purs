module Util.Condition
  ( (?)
  , (↔)
  , if_
  )
  where

import Data.Eq ((==))
import Data.Function (apply)
import Data.Maybe (Maybe(..))

if_ :: ∀ a. Boolean -> a -> a -> a
if_ b t e = if b then t else e

infixl 1 if_ as ?

infixr 0 apply as ↔

class Conditional a where
  orDefault :: a -> a -> a

instance defaultableString :: Conditional String where
  orDefault "" default = default
  orDefault str _ = str

instance defaultableMaybe :: Conditional (Maybe a) where
  orDefault Nothing default = default
  orDefault (Just x) _ = Just x

instance defaultableArray :: Conditional (Array a) where
  orDefault [] default = default
  orDefault arr _ = arr

infixr 8 orDefault as ?→
