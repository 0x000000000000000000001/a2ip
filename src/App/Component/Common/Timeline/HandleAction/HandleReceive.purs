module App.Component.Common.Timeline.HandleAction.HandleReceive
  ( handleReceive
  ) where

import Proem

import App.Component.Common.Timeline.HandleAction.Util (scrollToDate)
import App.Component.Common.Timeline.Type (DefaultDate(..), Input, Output(..), TimelineM)
import Data.Array (find, length, nubByEq, reverse, (!!))
import Data.Foldable (for_)
import Data.Maybe (Maybe(..))
import Effect.Now (nowDate)
import Halogen (get, modify, raise)

handleReceive :: Input -> TimelineM Unit
handleReceive input = do
  now <- ʌ nowDate

  let items = input.items # nubByEq (\a b -> a.date == b.date)
      defaultItem = case input.defaultDate of
        First -> items !! 0
        Last -> items !! (length items - 1)
        FirstAfterNow -> find (_.date ▷ (_ > now)) items
        LastBeforeNow -> items # reverse # find (_.date ▷ (_ < now))
        _ -> Nothing

  oldState <- get
  let oldSelectedItem = oldState.selectedItem
      itemsChanged = (length oldState.input.items /= length items) || (oldState.input.items <#> _.date) /= (items <#> _.date)

  newState <- modify (\s -> s 
    { input = input
    , selectedItem = itemsChanged ? defaultItem ↔ s.selectedItem
    }
  )

  let newSelectedItem = newState.selectedItem
  when ((oldSelectedItem <#> _.date) /= (newSelectedItem <#> _.date)) do
    raise $ SelectedDate $ newSelectedItem <#> _.date

    for_ newSelectedItem (scrollToDate ◁ _.date)
