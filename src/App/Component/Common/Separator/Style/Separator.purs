module App.Component.Common.Separator.Style.Separator
  ( staticClass
  , staticClassWhenLoading
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.Separator.Style.Text.Text as Text
import App.Component.Common.Separator.Style.Util (grey)
import CSS (borderBottom, borderColor, rem, solid)
import CSS as CSS
import Util.Proxy.Dictionary.Loading (loading_)
import Util.Style.Style (alignItemsCenter, backgroundColorWhite, displayFlex, justifyContentCenter, loading, loadingGrey, padding4, positionSticky, refineClass', reflectStaticClass, top0, widthPct100, (.?), (.|*.), (:?))

staticClass :: String
staticClass = reflectStaticClass ι

staticClassWhenLoading :: String
staticClassWhenLoading = refineClass' staticClass loading_

zIndex :: Int
zIndex = 100

style :: CSS.CSS
style = do
  staticClass .? do
    displayFlex
    justifyContentCenter
    alignItemsCenter
    widthPct100
    backgroundColorWhite
    positionSticky
    top0
    padding4 0.6 0.6 0.0 0.6
    borderBottom solid (rem 0.15) grey
    CSS.zIndex zIndex

  staticClassWhenLoading .? do
    borderColor loadingGrey
    
  __text :? do 
    loading

  where 
  __text = staticClassWhenLoading .|*. Text.staticClass

separator :: ∀ w i. Node HTMLdiv w i
separator props = div ([ class_ staticClass ] <> props)

separator_ :: ∀ w i. Array (HTML w i) -> HTML w i
separator_ = separator []