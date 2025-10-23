module Config.Config
  ( Env(..)
  , Config
  , config
  )
  where

import Proem

import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)

foreign import _config :: 
  { env :: String
  , googleDriveApiKey :: String
  }

type Config = 
  { dev :: Boolean
  , env :: Env
  , test :: Boolean
  , stage :: Boolean
  , prod :: Boolean
  , googleDriveApiKey :: String
  }

config :: Config
config = 
  { dev: Dev == env
  , test: Test == env
  , stage: Stage == env
  , prod: Prod == env
  , env
  , googleDriveApiKey: _config.googleDriveApiKey
  }

data Env = Dev | Test | Stage | Prod

derive instance eqEnv :: Eq Env
derive instance genericEnv :: Generic Env _

instance showEnv :: Show Env where
  show = genericShow

env :: Env
env = 
  case _config.env of
    "dev" -> Dev
    "test" -> Test
    "stage" -> Stage
    "prod" -> Prod
    _ -> Dev