module Component.Menu.Component (component) where

import Prelude hiding (top, div)

import CSS (Selector, alignItems, alignSelf, backgroundColor, borderRadius, borderRight, boxShadow, color, column, cursor, display, fixed, flex, flexDirection, flexGrow, flexStart, fromString, graytone, height, hover, justifyContent, key, left, margin, marginLeft, minWidth, opacity, padding, position, rem, rgba, solid, top, vh, visibility, white, width, zIndex, (&), (?), (|*))
import CSS as CSS
import CSS.Box (bsColor, shadow)
import CSS.Common (center, visible, hidden)
import CSS.Cursor (pointer)
import CSS.Overflow (overflow)
import CSS.Overflow as Overflow
import Data.NonEmpty (singleton)
import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Halogen.HTML (HTML, div, img, nav, text)
import Halogen.HTML.CSS as HCSS
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP
import Utils (class_, ourRed)
import Component.Menu.Type (State)
import Component.Menu.Render (render)

component :: forall q o m. MonadAff m => H.Component q Unit o m
component = H.mkComponent
  { initialState: \_ -> { isUnfold: false }
  , render
  , eval: H.mkEval H.defaultEval { handleAction = handleAction }
  }