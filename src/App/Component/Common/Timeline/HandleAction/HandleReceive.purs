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

  let items = input.items # nubEq
      defaultItem = case input.defaultDate of
        First -> items !! 0
        Last -> items !! (length items - 1)
        FirstAfterNow -> find (_.date ▷ (_ > now)) items
        LastBeforeNow -> items # reverse # find (_.date ▷ (_ < now))
        _ -> Nothing

  oldState <- get
  let oldSelectedItem = oldState.selectedItem

  newState <- modify (\s -> s 
    { input = input
    , selectedItem = s.input.items /= items ? defaultItem ↔ s.selectedItem
    }
  )

  let newSelectedItem = newState.selectedItem
  when (oldSelectedItem /= newSelectedItem) do
    raise $ SelectedDate $ newSelectedItem <#> _.date

    for_ newSelectedItem (scrollToDate ◁ _.date)
