module App.Component.Common.Timeline.HandleAction.HandleReceive
  ( handleReceive
  ) where

import Proem

import App.Component.Common.Timeline.HandleAction.Util (scrollToDate)
import App.Component.Common.Timeline.Type (DefaultDate(..), Input, Output(..), TimelineM)
import Data.Array (find, length, nubEq, reverse, (!!))
import Data.Foldable (for_)
import Data.Maybe (Maybe(..))
import Effect.Now (nowDate)
import Halogen (get, modify, raise)

handleReceive :: Input -> TimelineM Unit
handleReceive input = do
  now <- ʌ nowDate

  let dates = input.dates # nubEq
      defaultDate = case input.defaultDate of
        First -> dates !! 0
        Last -> dates !! (length dates - 1)
        FirstAfterNow -> find (_ > now) dates
        LastBeforeNow -> dates # reverse # find (_ < now)
        _ -> Nothing

  oldState <- get
  let oldSelectedDate = oldState.selectedDate

  newState <- modify (\s -> s 
    { input = input
    , selectedDate = s.input.dates /= dates ? defaultDate ↔ s.selectedDate 
    }
  )

  let newSelectedDate = newState.selectedDate
  when (oldSelectedDate /= newSelectedDate) do
    raise $ SelectedDate newSelectedDate

    for_ newSelectedDate scrollToDate
