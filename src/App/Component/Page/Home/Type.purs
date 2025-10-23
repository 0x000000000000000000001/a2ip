module App.Component.Page.Home.Type where

import App.Component.Common.Carrousel.Type as Carrousel
import App.Component.Util.Type (NoAction, NoInput, NoOutput, NoQuery, NoState)
import App.Util.Capability.AppM (AppM)
import Halogen (HalogenM, Slot)
import Type.Prelude (Proxy(..))

type Input = NoInput

type Output = NoOutput

type Slots =
  ( carrousel :: Slot Carrousel.Query Carrousel.Output String
  )

carrousel = Proxy :: Proxy "carrousel"

type State = NoState

type Action = NoAction

type Query :: ∀ k. k -> Type
type Query = NoQuery

type HomeM a = HalogenM State Action Slots Output AppM a
