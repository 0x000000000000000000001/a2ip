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

type Config = 
  { dev :: Boolean
  , env :: Env
  }

config :: Config
config = 
  { dev: Dev == env
  , env
  }