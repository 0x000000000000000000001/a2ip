module App.Component.Page.Seminars.Type where

import App.Component.Common.Timeline.Type (Date(..))
import App.Component.Common.Timeline.Type as Timeline
import App.Component.Common.YoutubeVideo.Type as YoutubeVideo
import App.Component.Util.Type (NoInput, NoOutput, NoQuery, NoSlotAddressIndex)
import App.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe)
import Halogen (HalogenM, Slot)
import Type.Prelude (Proxy(..))

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
  [ Date { day: 1, month: 1, year: 2024 }
  , Date { day: 15, month: 2, year: 25 }
  , Date { day: 13, month: 3, year: 25 }
  , Date { day: 13, month: 3, year: 25 }
  , Date { day: 13, month: 4, year: 25 }
  , Date { day: 13, month: 5, year: 25 }
  , Date { day: 13, month: 6, year: 25 }
  , Date { day: 13, month: 7, year: 25 }
  , Date { day: 13, month: 8, year: 25 }
  , Date { day: 13, month: 9, year: 25 }
  , Date { day: 13, month: 10, year: 25 }
  , Date { day: 13, month: 11, year: 25 }
  , Date { day: 13, month: 12, year: 25 }
  ]

