module Util.Applicative
  ( η
  , ηι
  , ι
  , κηι
  )
  where

import Prelude

import Util.Function (κ)

ι :: Unit 
ι = unit

η :: ∀ f a. Applicative f => a -> f a
η = pure

ηι :: ∀ f. Applicative f => f Unit
ηι = η ι

κηι :: ∀ f a. Applicative f => a -> f Unit
κηι = κ ηι