module App.Component.Router.Menu.HandleLinkOutput (handleLinkOutput) where

import Proem hiding (top, div)

import App.Component.Common.Link.Type as Link
import App.Component.Router.Menu.Type (Action(..))

handleLinkOutput :: Link.Output -> Action
handleLinkOutput (Link.Clicked _ ev) = HandleItemClick ev