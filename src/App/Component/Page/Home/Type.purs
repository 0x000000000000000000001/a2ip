module App.Component.Page.Home.Type where

import App.Component.Common.Modal.Type as Modal
import App.Component.Common.Carrousel.Type as Carrousel
import App.Component.Util.Type (NoInput, NoOutput, NoQuery, NoSlotAddressIndex)
import App.Util.Capability.AppM (AppM)
import Halogen (HalogenM, Slot)
import Type.Prelude (Proxy(..))

type Input = NoInput

type Output = NoOutput

type Slots =
  ( modal :: Slot Modal.Query Modal.Output NoSlotAddressIndex
  , carrousel :: Slot Carrousel.Query Carrousel.Output NoSlotAddressIndex
  )

modal = Proxy :: Proxy "modal"
carrousel = Proxy :: Proxy "carrousel"

type State = 
  { showModal :: Boolean
  }

data Action = ShowModal

type Query :: ∀ k. k -> Type
type Query = NoQuery

type HomeM a = HalogenM State Action Slots Output AppM a
