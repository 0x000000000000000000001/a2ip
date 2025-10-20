module Component.Page.Seminars.Type where

import Component.Common.Timeline.Type as Timeline
import Component.Util.Type (NoInput, NoOutput, NoQuery, NoSlotAddressIndex)
import Data.Maybe (Maybe)
import Halogen (Slot)
import Type.Prelude (Proxy(..))

type Input = NoInput

type Output = NoOutput

type Slots =
  ( timeline :: Slot Timeline.Query Timeline.Output NoSlotAddressIndex
  )

timeline = Proxy :: Proxy "timeline"

type State =
  { selectedDate :: Maybe Timeline.Date
  }

data Action = SelectDate Timeline.Date

type Query :: ∀ k. k -> Type
type Query = NoQuery
