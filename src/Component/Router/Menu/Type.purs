module Component.Router.Menu.Type
  ( Action(..)
  , Input
  , Output
  , Query
  , Slots
  , State
  , items
  )
  where

import Component.Common.Link.Type as Link
import Component.Router.Route (Route)
import Component.Util.Type (NoInput, NoOutput, NoQuery)
import Data.Maybe (Maybe)
import Data.Tuple (Tuple)
import Halogen (Slot)
import Type.Prelude (Proxy(..))

type Slots = 
  ( items :: Slot Link.Query Link.Output (Tuple String (Maybe Route))
  )

items = Proxy :: Proxy "items"

type State = { isUnfold :: Boolean }

data Action = ToggleFolding Boolean

type Input = NoInput

type Output = NoOutput

type Query :: ∀ k. k -> Type
type Query = NoQuery
