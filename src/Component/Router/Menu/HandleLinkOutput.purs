module Component.Router.Menu.HandleLinkOutput (handleLinkOutput) where

import Proem hiding (top, div)

import Component.Common.Link.Type as Link
import Component.Router.Menu.Type (Action(..))

handleLinkOutput :: Link.Output -> Action
handleLinkOutput (Link.Clicked _) = ToggleFolding true