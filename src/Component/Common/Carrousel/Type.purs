module Component.Common.Carrousel.Type
  ( Action(..)
  , ComponentM
  , Input
  , Output
  , Query
  , Slots
  , State
  , indexImage
  )
  where

import Capability.AppM (AppM)
import Component.Common.PrettyErrorImage.Type as PrettyErrorImage
import Component.Util.Type (NoOutput, NoQuery, NoSlotAddressIndex)
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

type ComponentM a = HalogenM State Action Slots Output AppM a
