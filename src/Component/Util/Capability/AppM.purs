module Component.Util.Capability.AppM (AppM, runAppM) where

import Proem

import Config.Config (Config)
import Control.Monad.Error.Class (class MonadError, class MonadThrow)
import Control.Monad.Reader (class MonadAsk, ReaderT, runReaderT)
import Effect.Aff (Aff)
import Effect.Aff.Class (class MonadAff)
import Effect.Class (class MonadEffect)
import Effect.Exception (Error)

newtype AppM a = AppM (ReaderT Config Aff a)

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

runAppM :: ∀ a. Config -> AppM a -> Aff a
runAppM config (AppM app) = runReaderT app config
