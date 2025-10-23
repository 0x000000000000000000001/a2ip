module Bin.Util.Capability.BinM
  ( BinM
  , runBinAff
  , runBinM
  )
  where

import Proem

import Bin.Util.Exit (exitError, exitSuccess)
import Config.Config (Config)
import Control.Monad.Error.Class (class MonadError, class MonadThrow)
import Control.Monad.Reader (class MonadAsk, ReaderT, runReaderT)
import Control.Monad.Reader.Class (ask)
import Data.Either (Either(..))
import Effect (Effect)
import Effect.Aff (Aff, runAff_)
import Effect.Aff.Class (class MonadAff)
import Effect.Class (class MonadEffect)
import Effect.Console as Console
import Effect.Exception (Error)
import Util.Capability.ReadConfig (class ReadConfig)

newtype BinM a = BinM (ReaderT Config Aff a)

runBinM :: Config -> BinM Unit -> Effect Unit
runBinM config (BinM r) = runBinAff $ runReaderT r config

runBinAff :: Aff Unit -> Effect Unit
runBinAff action = runAff_ handleResult action
  where
  handleResult :: Either Error Unit -> Effect Unit
  handleResult (Right _) = exitSuccess
  handleResult (Left e) = do 
    Console.error $ "🧨 " <> show e
    exitError

derive newtype instance functorBinM :: Functor BinM
derive newtype instance applyBinM :: Apply BinM
derive newtype instance applicativeBinM :: Applicative BinM
derive newtype instance bindBinM :: Bind BinM
derive newtype instance monadBinM :: Monad BinM
derive newtype instance monadEffectBinM :: MonadEffect BinM
derive newtype instance monadAffBinM :: MonadAff BinM
derive newtype instance monadAskBinM :: MonadAsk Config BinM
derive newtype instance monadErrorBinM :: MonadError Error BinM
derive newtype instance monadThrowBinM :: MonadThrow Error BinM

instance readConfigBinM :: MonadAsk Config BinM => ReadConfig BinM where
  readConfig = ask