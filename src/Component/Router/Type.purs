module Component.Router.Type where

import Prelude hiding (div)

import Component.Router.Route (Route)

type State = { route :: Route }

data Action

data Query a = Navigate Route a
