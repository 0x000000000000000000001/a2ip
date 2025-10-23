module App.Util.Capability.Navigate where

import Proem

class Monad m <= Navigate m where
  navigate :: Route -> m Unit

