module Main (main) where

import Prelude hiding (div)

import AppM (runAppM)
import Component.Router.Component as RouterComponent
import Component.Router.Route (routeCodec)
import Component.Router.Type as RouterType
import Config (defaultConfig)
import Data.DateTime.Instant (toDateTime)
import Data.Either (either)
import Data.Formatter.DateTime (formatDateTime)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import Effect.Now (now)
import Halogen as H
import Halogen.Aff (awaitBody, runHalogenAff)
import Halogen.VDom.Driver (runUI)
import Routing.Duplex (parse)
import Routing.Hash (matchesWith)

main :: Effect Unit
main = do
  currentTime <- now
  let 
    dateTime = toDateTime currentTime
    formattedDateTime = formatDateTime "HH:mm:ss.SSS" dateTime
    errorMessage = "Unable to parse loading date."
  log $ "Loaded @ " <> either (const errorMessage) identity formattedDateTime
  
  runHalogenAff do 
    body <- awaitBody
    io <- runUI (H.hoist (runAppM defaultConfig) RouterComponent.component) unit body
    liftEffect $ matchesWith (parse routeCodec)
      \old' new -> when (old' /= Just new) $   
        launchAff_ $ void $ io.query $ H.mkTell $ RouterType.Navigate new
 