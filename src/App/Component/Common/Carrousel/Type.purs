module App.Component.Common.Carrousel.Type
  ( Action(..)
  , CarrouselM
  , Input
  , Output
  , Query
  , Slots
  , State
  , indexImage
  )
  where

import App.Util.Capability.AppM.AppM (AppM)
import App.Component.Common.PrettyErrorImage.Type as PrettyErrorImage
import App.Component.Util.Type (NoOutput, NoQuery, NoSlotAddressIndex)
import Halogen (HalogenM, Slot)
import Type.Prelude (Proxy(..))

type Input = 
  { imageSources :: Array String
  }

type Output = NoOutput

type Slots =
  ( indexImage :: Slot PrettyErrorImage.Query PrettyErrorImage.Output NoSlotAddressIndex
  )

indexImage = Proxy :: Proxy "indexImage"

type State = 
  { index :: Int
  , imageSources :: Array String
  }

data Action = GoToPrevious | GoToNext | Receive Input

type Query :: ∀ k. k -> Type
type Query = NoQuery

type CarrouselM a = HalogenM State Action Slots Output AppM a
