module Main (main) where

import Proem hiding (div)

import Capability.AppM (runAppM)
import Component.Router.Component as RouterComponent
import Component.Router.Route (routeCodec)
import Component.Router.Type as RouterType
import Config.Config (config)
import Data.DateTime.Instant (toDateTime)
import Data.Either (either)
import Data.Formatter.DateTime (formatDateTime)
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import Effect.Now (now)
import Halogen (hoist, mkTell)
import Halogen.Aff (awaitBody, runHalogenAff)
import Halogen.VDom.Driver (runUI)
import Routing.Duplex (parse)
import Routing.PushState (makeInterface)

main :: Effect Unit
main = do
  currentTime <- now
  let 
    dateTime = toDateTime currentTime
    formattedDateTime = formatDateTime "HH:mm:ss.SSS" dateTime
    errorMessage = "Unable to parse loading date."
  log $ "Loaded @ " <> either (const errorMessage) identity formattedDateTime
  
  nav <- makeInterface
  
  runHalogenAff do 
    body <- awaitBody
    io <- runUI (hoist (runAppM config) RouterComponent.component) unit body
    
    -- Navigate to initial route
    initialLoc <- liftEffect nav.locationState
    parse routeCodec initialLoc.pathname
      ?! (void <<< io.query <<< mkTell <<< RouterType.Navigate)
      ⇿ const $ pure unit
    
    -- Listen for route changes
    void $ liftEffect $ nav.listen \loc -> 
      parse routeCodec loc.pathname
        ?! (launchAff_ <<< void <<< io.query <<< mkTell <<< RouterType.Navigate)
        ⇿ const $ pure unit
