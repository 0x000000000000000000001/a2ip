module App.Main (main) where

import Proem hiding (div)

import App.Component.Router.Component as RouterComponent
import App.Component.Router.Type as RouterType
import App.Util.Capability.AppM (runAppM)
import App.Util.Capability.Navigate (routeCodec, routeTitle)
import Config.Config (config)
import Data.DateTime.Instant (toDateTime)
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
import Web.HTML (window)
import Web.HTML.HTMLDocument (setTitle)
import Web.HTML.Window (document)

main :: Effect Unit
main = do
  currentTime <- now
  let 
    dateTime = toDateTime currentTime
    formattedDateTime = formatDateTime "HH:mm:ss.SSS" dateTime
    errorMessage = "Unable to parse loading date."
  log $ "Loaded @ " <> formattedDateTime ?!⇽ (κ errorMessage)
  
  nav <- makeInterface
  
  runHalogenAff do 
    body <- awaitBody
    io <- runUI (hoist (runAppM config) RouterComponent.component) ι body
    
    -- Navigate to initial route
    initialLoc <- liftEffect nav.locationState
    parse routeCodec initialLoc.pathname
      ?! (\route -> do
        -- Update title for initial route
        liftEffect do
          doc <- window >>= document
          setTitle (routeTitle route) doc
        -- Navigate to route
        void $ io.query $ mkTell $ RouterType.Navigate route
      )
      ⇿ κηι
    
    -- Listen for route changes
    void $ liftEffect $ nav.listen \loc -> 
      parse routeCodec loc.pathname
        ?! (launchAff_ ◁ void ◁ io.query ◁ mkTell ◁ RouterType.Navigate)
        ⇿ κηι