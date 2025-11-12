module App.Component.Page.About.Style.Card.Portrait
  ( portrait
  , portrait_
  , prettyErrorImageStyle
  , staticClass
  , style
  )
  where

import Proem hiding (div, top)

import App.Component.Common.PrettyErrorImage.Type (Style, defaultStyle)
import App.Component.Util.Type (Size(..))
import CSS as CSS
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import Data.Lens ((.~))
import Data.Maybe (Maybe(..))
import Util.Proxy.Dictionary.Border (_border)
import Util.Proxy.Dictionary.Color (_color)
import Util.Proxy.Dictionary.Errored (_errored)
import Util.Proxy.Dictionary.Fit (_fit)
import Util.Proxy.Dictionary.Height (_height)
import Util.Proxy.Dictionary.Hover (_hover)
import Util.Proxy.Dictionary.QuestionMark (_questionMark)
import Util.Proxy.Dictionary.Radius (_radius)
import Util.Proxy.Dictionary.When (_when)
import Util.Proxy.Dictionary.Width (_width)
import Util.Proxy.Dictionary.With (_with)
import Util.Style.Image (cover)
import Util.Style.Style (class_, marginTop, red, reflectStaticClass, textRed, (.?))

staticClass :: String 
staticClass = reflectStaticClass ι

width :: Number
width = 12.0

style :: CSS.CSS
style = do
  staticClass .? do
    marginTop 0.4

portrait :: ∀ w i. Node HTMLdiv w i
portrait props = div ([ class_ staticClass ] <> props)

portrait_ :: ∀ w i. Array (HTML w i) -> HTML w i
portrait_ = portrait []

prettyErrorImageStyle :: Style
prettyErrorImageStyle = 
  defaultStyle
    # _fit .~ Just cover
    # _width .~ (Just $ Rem width)
    # _height .~ (Just $ Rem width)
    # _border .~ 
        { radius: Just $ Pct 50.0
        , width: Just 0.3
        , color: Just red 
        }
    # _questionMark ◁ _when ◁ _errored ◁ _color .~ Just textRed
    # _with ◁ _hover ◁ _border ◁ _radius .~ (Just $ Rem 0.5)
