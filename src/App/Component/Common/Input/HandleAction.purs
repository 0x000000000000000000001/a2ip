module App.Component.Common.Input.HandleAction
  ( handleAction
  ) where

import Proem

import App.Component.Common.Input.Type (Action(..), InputM, Output(..))
import App.Component.Common.Input.Util (inputRef)
import Data.Maybe (Maybe(..))
import Data.Traversable (for_)
import Effect.Ref (new, write)
import Halogen (get, getHTMLElementRef, modify_, raise)
import Util.Log (unsafeDebug)
import Web.Event.Event (stopPropagation)
import Web.HTML.HTMLElement (focus)
import Web.UIEvent.MouseEvent (toEvent)

handleAction :: Action -> InputM Unit
handleAction = case _ of
  Initialize -> do
    state <- get

    ref <- ʌ $ new state.input.initialValue

    modify_ _ { value = Just ref }

  Receive input -> modify_ _ { input = input }

  HandleNewValue newValue -> do
    state <- get

    for_
      state.value
      \ref -> ʌ $ write newValue ref

    raise $ ChangedValue newValue

  HandleFocus -> modify_ _ { focus = true }

  HandleBlur -> modify_ _ { focus = false }

  HandleClick -> do
    maybeElement <- getHTMLElementRef inputRef

    for_ maybeElement \element -> 
      ʌ $ focus element

  HandleLabelClick mouseEvent -> do
    let event = toEvent mouseEvent
        _ = unsafeDebug "abc"

    ʌ $ stopPropagation event
