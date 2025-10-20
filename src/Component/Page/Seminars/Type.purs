module Component.Page.Seminars.Type where

import Component.Common.Timeline.Type as Timeline
import Component.Util.Type (NoAction, NoInput, NoOutput, NoQuery, NoSlotAddressIndex, NoState)
import Halogen (Slot)
import Type.Prelude (Proxy(..))

type Input = NoInput

type Output = NoOutput

type Slots =
  ( timeline :: Slot Timeline.Query Timeline.Output NoSlotAddressIndex
  )

timeline = Proxy :: Proxy "timeline"

type State = NoState

type Action = NoAction

type Query :: ∀ k. k -> Type
type Query = NoQuery
