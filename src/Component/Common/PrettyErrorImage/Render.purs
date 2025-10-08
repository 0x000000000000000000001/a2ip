module Component.Common.PrettyErrorImage.Component 
  ( render
  )
  where

import Prelude hiding (div)

import Capability.AppM (AppM)
import Component.Page.About.Style.About (classId)
import Component.Page.About.Style.Card.Card as Card
import Component.Page.About.Style.Card.Line as CardLine
import Component.Page.About.Style.Card.Names as CardNames
import Component.Page.About.Style.Card.Portrait as CardPortrait
import Component.Page.About.Style.Sheet (sheet)
import Component.Page.About.Type (Action, Member, Slots, State, email, job, phone, role)
import Data.Maybe (Maybe, fromMaybe, maybe)
import Halogen (ComponentHTML)
import Halogen.HTML (HTML, div, img, text)
import Halogen.HTML.Properties (src)
import Html.Renderer.Halogen (render_)
import Util.Style (class_, classes)

render :: State -> ComponentHTML Action Slots AppM
render state = text "pretty error image"