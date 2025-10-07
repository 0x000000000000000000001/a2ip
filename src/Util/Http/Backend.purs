module Util.Http.Backend where

-- This module exists solely to tell Spago that we use these packages.
-- They are actually used in Util/Http.js (FFI) where they are dynamically imported.

import Affjax (AffjaxDriver)
import Affjax.Node as AffjaxNode
import Affjax.Web as AffjaxWeb

-- Re-export the drivers so the imports are not considered unused
nodeDriver :: AffjaxDriver
nodeDriver = AffjaxNode.driver

webDriver :: AffjaxDriver  
webDriver = AffjaxWeb.driver
