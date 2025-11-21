module Ui.Component.Common.Timeline.Util
  ( dateToDataAttr
  , parseDateDataAttr
  )
  where

import Proem

import Data.Array ((!!))
import Data.Date (Date, day, month, year)
import Data.Enum (fromEnum)
import Data.Int (fromString)
import Data.Maybe (Maybe)
import Data.String (Pattern(..), split)
import Util.Time (unsafeDate)

parseDateDataAttr :: String -> Maybe Date
parseDateDataAttr str = do
  let parts = split (Pattern "-") str

  dayStr <- parts !! 0
  monthStr <- parts !! 1
  yearStr <- parts !! 2
  
  day <- fromString dayStr
  month <- fromString monthStr
  year <- fromString yearStr
  
  η $ unsafeDate year month day

dateToDataAttr :: Date -> String
dateToDataAttr date = 
  let d = fromEnum $ day date
      m = fromEnum $ month date
      y = fromEnum $ year date
  in show d <> "-" <> show m <> "-" <> show y