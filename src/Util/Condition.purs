module Util.Condition
  ( (?)
  , (?→)
  , (↔)
  , class Conditional
  , isFalsy
  , if_
  , orDefault
  )
  where

import Data.Either (Either, isLeft)
import Data.Function (apply)
import Data.Maybe (Maybe, isNothing)
import Prelude (not)

if_ :: ∀ a b. Conditional a => a -> b -> b -> b
if_ b t e = if isFalsy b then e else t

infixl 1 if_ as ?

infixr 0 apply as ↔

class Conditional a where
  isFalsy :: a -> Boolean

instance conditionalBoolean :: Conditional Boolean where
  isFalsy = not

instance conditionalString :: Conditional String where
  isFalsy "" = true
  isFalsy _ = false

instance conditionalMaybe :: Conditional (Maybe a) where
  isFalsy = isNothing

instance conditionalEither :: Conditional (Either a b) where
  isFalsy = isLeft

instance conditionalArray :: Conditional (Array a) where
  isFalsy [] = true
  isFalsy _ = false

orDefault :: ∀ a. Conditional a => a -> a -> a
orDefault val def = val ? val ↔ def

infixr 8 orDefault as ?→
