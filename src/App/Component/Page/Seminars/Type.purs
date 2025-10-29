module App.Component.Page.Seminars.Type where

import Proem

import App.Component.Common.Timeline.Type as Timeline
import App.Component.Common.YoutubeVideo.Type as YoutubeVideo
import App.Component.Util.Type (NoInput, NoOutput, NoQuery, NoSlotAddressIndex)
import App.Util.Capability.AppM (AppM)
import Data.Date (Date)
import Data.Maybe (Maybe)
import Halogen (HalogenM, Slot)
import Type.Prelude (Proxy(..))
import Util.Time (unsafeDate)

type Input = NoInput

type Output = NoOutput

type Slots =
  ( timeline :: Slot Timeline.Query Timeline.Output NoSlotAddressIndex
  , youtubeVideo :: Slot YoutubeVideo.Query YoutubeVideo.Output NoSlotAddressIndex
  )

timeline = Proxy :: Proxy "timeline"
youtubeVideo = Proxy :: Proxy "youtubeVideo"

type State =
  { selectedSeminar :: Maybe Seminar
  , seminars :: Maybe (Array Seminar)
  }

data Action 
  = Load 
  | SelectSeminar (Maybe Seminar)
  | SelectSeminarByDate (Maybe Date)

type Query :: ∀ k. k -> Type
type Query = NoQuery

type SeminarsM a = HalogenM State Action Slots Output AppM a

type SeminarRow = 
  ( title :: String
  , theme :: String
  , firstname :: String
  , lastname :: String
  , date :: Date
  , videoUrl :: String
  )

type Seminar = { | SeminarRow }

title = Proxy :: Proxy "title"
theme = Proxy :: Proxy "theme"
firstname = Proxy :: Proxy "firstname"
lastname = Proxy :: Proxy "lastname"
day = Proxy :: Proxy "day"
month = Proxy :: Proxy "month"
year = Proxy :: Proxy "year"
videoUrl = Proxy :: Proxy "videoUrl"

mockDates :: Array Date
mockDates = 
  [ { d: 1, m: 1, y: 2024 }
  , { d: 15, m: 2, y: 2024 }
  , { d: 10, m: 3, y: 2024 }
  , { d: 5, m: 4, y: 2024 }
  , { d: 20, m: 5, y: 2024 }
  , { d: 30, m: 6, y: 2024 }
  , { d: 25, m: 7, y: 2024 }
  , { d: 15, m: 8, y: 2024 }
  , { d: 10, m: 9, y: 2024 }
  , { d: 5, m: 10, y: 2024 }
  , { d: 20, m: 11, y: 2024 }
  , { d: 31, m: 12, y: 2024 }
  ] <#> \{ d, m, y } -> unsafeDate y m d

