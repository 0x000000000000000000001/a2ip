module Utils.Html.Encode
  ( arrayToIndexMap
  ) where

import Prelude

import Data.Array (mapWithIndex)
import Data.Map (Map, fromFoldable)
import Data.Tuple (Tuple(..))

arrayToIndexMap :: forall a. Ord a => Array a -> Map a Int
arrayToIndexMap = fromFoldable <<< mapWithIndex (flip Tuple)