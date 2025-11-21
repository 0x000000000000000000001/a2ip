module Ui.Component.Common.Carrousel.Type
  ( Action(..)
  , CarrouselM
  , Input
  , Media(..)
  , Output
  , Query
  , Slide
  , Slots
  , Source
  , State
  )
  where

import Ui.Component.Common.PrettyErrorImage.Type as PrettyErrorImage
import Ui.Component.Common.YoutubeVideo.Type as YoutubeVideo
import Ui.Component.Util.Type (NoOutput, NoQuery, NoSlotAddressIndex, WithId)
import Ui.Util.Capability.AppM (AppM)
import Data.Eq (class Eq)
import Data.Maybe (Maybe)
import Halogen (HalogenM, Slot)

type Source = String

data Media = Image Source | YoutubeVideo Source 

derive instance eqMedia :: Eq Media

type Slide = 
  { media :: Media
  , caption :: Maybe String
  }

type Input = 
  { slides :: Array Slide
  }

type Output = NoOutput

type Slots =
  ( image :: Slot PrettyErrorImage.Query PrettyErrorImage.Output NoSlotAddressIndex
  , youtubeVideo :: Slot YoutubeVideo.Query YoutubeVideo.Output NoSlotAddressIndex
  )

type State = WithId
  ( input :: Input
  , index :: Int
  )

data Action = GoToPrevious | GoToNext | Receive Input

type Query :: ∀ k. k -> Type
type Query = NoQuery

type CarrouselM a = HalogenM State Action Slots Output AppM a
