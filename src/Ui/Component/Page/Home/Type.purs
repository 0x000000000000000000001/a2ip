module Ui.Component.Page.Home.Type where

import Ui.Component.Common.Carrousel.Type as Carrousel
import Ui.Component.Common.Modal.Type as Modal
import Ui.Component.Util.Type (NoInput, NoOutput, NoQuery, NoSlotAddressIndex)
import Ui.Util.Capability.AppM (AppM)
import Halogen (HalogenM, Slot)

type Input = NoInput

type Output = NoOutput

type Slots =
  ( modal :: Slot Carrousel.Query (Modal.Output Carrousel.Output) NoSlotAddressIndex
  )

type State = 
  { showModal :: Boolean
  , innerClicks :: Int
  , outerClicks :: Int
  }

data Action = ShowModal | HideModal | DoNothing | InnerClicked | OuterClicked

type Query :: ∀ k. k -> Type
type Query = NoQuery

type HomeM a = HalogenM State Action Slots Output AppM a
