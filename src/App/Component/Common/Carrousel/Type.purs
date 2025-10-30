module App.Component.Common.Carrousel.Type
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
  , image
  , youtubeVideo
  )
  where

import App.Component.Common.PrettyErrorImage.Type as PrettyErrorImage
import App.Component.Common.YoutubeVideo.Type as YoutubeVideo
import App.Component.Util.Type (NoOutput, NoQuery, NoSlotAddressIndex)
import App.Util.Capability.AppM (AppM)
import Data.Eq (class Eq)
import Data.Maybe (Maybe)
import Halogen (HalogenM, Slot)
import Type.Prelude (Proxy(..))

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

image = Proxy :: Proxy "image"
youtubeVideo = Proxy :: Proxy "youtubeVideo"

type State = 
  { input :: Input
  , index :: Int
  }

data Action = GoToPrevious | GoToNext | Receive Input

type Query :: ∀ k. k -> Type
type Query = NoQuery

type CarrouselM a = HalogenM State Action Slots Output AppM a
