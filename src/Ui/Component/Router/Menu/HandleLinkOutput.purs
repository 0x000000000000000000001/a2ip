module Ui.Component.Router.Menu.HandleLinkOutput (handleLinkOutput) where

import Proem hiding (top, div)

import Ui.Component.Common.Link.Type as Link
import Ui.Component.Router.Menu.Type (Action(..))

handleLinkOutput :: Link.Output -> Action
handleLinkOutput _ = DoNothing