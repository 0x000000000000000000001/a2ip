module App.Util.Capability.AppM.AppM (AppM, runAppM) where

import Proem

import App.Util.Capability.Log (class Log)
import App.Util.Capability.Navigate (class Navigate)
import App.Util.Capability.Navigate (class Navigate, routePath, routeTitle)
import Config.Config (Config)
import Control.Monad.Error.Class (class MonadError, class MonadThrow)
import Control.Monad.Reader (class MonadAsk, ReaderT, ask, runReaderT)
import Control.Monad.Reader (class MonadAsk, ReaderT, runReaderT)
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Aff.Class (class MonadAff)
import Effect.Class (class MonadEffect)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Exception (Error)
import Foreign (unsafeToForeign)
import Util.Capability.ReadConfig (class ReadConfig)
import Util.Log (Level(..))
import Web.HTML (window)
import Web.HTML.HTMLDocument (setTitle)
import Web.HTML.History (DocumentTitle(..), URL(..), pushState)
import Web.HTML.Window (document, history)
import Control.Monad.Trans.Class (lift)
import Effect.Class.Console as Console

foreign import dispatchPopStateEvent :: Effect Unit

newtype AppM a = AppM (ReaderT Config Aff a)

runAppM :: ∀ a. Config -> AppM a -> Aff a
runAppM config (AppM app) = runReaderT app config

derive newtype instance functorAppM :: Functor AppM
derive newtype instance applyAppM :: Apply AppM
derive newtype instance applicativeAppM :: Applicative AppM
derive newtype instance bindAppM :: Bind AppM
derive newtype instance monadAppM :: Monad AppM
derive newtype instance monadEffectAppM :: MonadEffect AppM
derive newtype instance monadAffAppM :: MonadAff AppM
derive newtype instance monadAskAppM :: MonadAsk Config AppM
derive newtype instance monadErrorAppM :: MonadError Error AppM
derive newtype instance monadThrowAppM :: MonadThrow Error AppM

instance readConfigAppM :: MonadAsk Config AppM => ReadConfig AppM where
  readConfig = ask

instance navigateAppM :: Navigate AppM where
  navigate route = liftEffect do
    let path = routePath route
    let title = routeTitle route

    hist <- window >>= history
    pushState (unsafeToForeign {}) (DocumentTitle title) (URL path) hist
    -- Dispatch popstate event to trigger nav.listen in Main
    dispatchPopStateEvent

    doc <- window >>= document
    setTitle title doc

instance logAppM :: Log AppM where 
  log level message = liftEffect do
    let msg = show level <> ": " <> message
    case level of 
      Debug -> Console.debug msg
      Info -> Console.info msg
      Warn -> Console.warn msg
      Error -> Console.error msg
      
  logShow level a = liftEffect do
    let msg = show level <> ": " <> show a
    case level of 
      Debug -> Console.debug msg
      Info -> Console.info msg
      Warn -> Console.warn msg
      Error -> Console.error msg
  
  info message = liftEffect $ Console.info (show Info <> ": " <> message)
  infoShow a = liftEffect $ Console.info (show Info <> ": " <> show a)
  debug message = liftEffect $ Console.debug (show Debug <> ": " <> message)
  debugShow a = liftEffect $ Console.debug (show Debug <> ": " <> show a)
  warn message = liftEffect $ Console.warn (show Warn <> ": " <> message)
  warnShow a = liftEffect $ Console.warn (show Warn <> ": " <> show a)
  error message = liftEffect $ Console.error (show Error <> ": " <> message)
  errorShow a = liftEffect $ Console.error (show Error <> ": " <> show a)