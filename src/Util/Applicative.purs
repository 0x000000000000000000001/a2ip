module Util.Applicative
  ( η
  , ηι
  , ι
  )
  where

import Prelude

ι :: Unit 
ι = unit

η :: ∀ f a. Applicative f => a -> f a
η = pure

ηι :: ∀ f. Applicative f => f Unit
ηι = pure unit