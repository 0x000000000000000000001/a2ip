module App.Component.Page.Home.Type where

import App.Component.Common.Modal.Type as Modal
import App.Component.Common.Carrousel.Type as Carrousel
import App.Component.Common.Input.Type as Input
import App.Component.Util.Type (NoInput, NoOutput, NoQuery, NoSlotAddressIndex)
import App.Util.Capability.AppM (AppM)
import Halogen (HalogenM, Slot)

type Input = NoInput

type Output = NoOutput

type Slots =
  ( modal :: Slot Carrousel.Query (Modal.Output Carrousel.Output) NoSlotAddressIndex
  , input :: Slot Input.Query Input.Output NoSlotAddressIndex
  )

type State = 
  { showModal :: Boolean
  }

data Action = ShowModal | HideModal | DoNothing

type Query :: ∀ k. k -> Type
type Query = NoQuery

type HomeM a = HalogenM State Action Slots Output AppM a
