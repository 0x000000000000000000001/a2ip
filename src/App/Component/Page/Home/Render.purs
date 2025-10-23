module App.Component.Page.Home.Render
  ( render
  ) where

import Proem hiding (div)

import App.Component.Common.PrettyErrorImage.Component as PrettyErrorImage
import App.Component.Common.Separator.Component as Separator
import App.Component.Common.Separator.Type (TextElementTag(..))
import App.Component.Page.Home.Style.Home (classId)
import App.Component.Page.Home.Style.Card.Card as Card
import App.Component.Page.Home.Style.Card.Line as CardLine
import App.Component.Page.Home.Style.Card.Names as CardNames
import App.Component.Page.Home.Style.Card.Portrait as CardPortrait
import App.Component.Page.Home.Style.Collaborators as Collaborators
import App.Component.Page.Home.Style.Members as Members
import App.Component.Page.Home.Style.Sheet (sheet)
import App.Component.Page.Home.Type (Action, Person, PersonRow, Slots, State, collaborators, country, email, job, members, phone, portraits, role, separators)
import App.Util.Capability.AppM (AppM)
import App.Component.Page.Util.Image (ourImageRelativePath)
import App.Component.Util.Type (noOutputAction)
import Data.Array (mapWithIndex, replicate)
import Data.Maybe (Maybe(..), isNothing)
import Data.String (trim)
import Data.Symbol (class IsSymbol)
import Halogen (ComponentHTML)
import Halogen.HTML (HTML, div, slot, text)
import Html.Renderer.Halogen (render_)
import Prim.Row (class Cons)
import Record (get)
import Type.Prelude (Proxy)
import Util.String (slugify)
import Util.Style (class_, classes)

render :: State -> ComponentHTML Action Slots AppM
render s = text "home"