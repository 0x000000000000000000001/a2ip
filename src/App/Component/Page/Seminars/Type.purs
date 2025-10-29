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

-- type ThemeInfo = 
--   { title :: String
--   , description :: String
--   }

-- data Theme 
--   = Politics 
--       { title: "Politique et Religion"
--       , description: "Ce séminaire international, interdisciplinaire et inter-sociétés reprend le fil d’un travail collectif inauguré en 1985 par l’Association Internationale d’Histoire de la Psychanalyse (AIHP). Construire son histoire est une nécessité pour tout sujet et tout groupe afin de se penser et de s'auto-investir dans une réalité qui les dépasse et va les effacer dans l’oubli. Mais l’écriture de l’Histoire, même partielle, ne se limite pas à raconter des histoires. Pourtant, l’histoire de la psychanalyse bien souvent ressemble à des histoires de famille, ce qui incitera à se demander la place qu’y tiennent le secret, l’anecdote, la révélation fracassante. Les relations personnelles des psychanalystes avec leurs passions se sont souvent entrecroisées avec l’histoire des concepts ce qui ne manque pas de reposer la question du statut de cette histoire. Comme toute histoire partielle, l’histoire de la psychanalyse doit aussi être située à l’intérieur de l’Histoire dans sa dimension sociétale et géopolitique et cette dimension devrait nous conduire à une réflexion sur l’avenir. Prévu pour trois années, ce séminaire abordera les thèmes suivants :  Les histoires de la psychanalyse, Les outils pour écrire l’histoire de la psychanalyse, les apparitions et disparitions dans l’histoire de la psychanalyse, les médiations et transmissions dans l’histoire de la psychanalyse, la place de l’histoire de la psychanalyse dans l’Histoire."
--       }
--   | Discontents 
--   | History

-- type SeminarsInfo = 
--   { politics :: SeminarInfo
--   , discontents :: SeminarInfo
--   , history :: SeminarInfo
--   }