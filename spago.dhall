{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "halo"
, dependencies =
  [ "aff"
  , "affjax"
  , "affjax-node"
  , "affjax-web"
  , "arraybuffer-types"
  , "arrays"
  , "console"
  , "const"
  , "css"
  , "datetime"
  , "effect"
  , "either"
  , "exceptions"
  , "formatters"
  , "halogen"
  , "halogen-css"
  , "html-parser-halogen"
  , "integers"
  , "maybe"
  , "node-buffer"
  , "node-fs"
  , "nonempty"
  , "now"
  , "ordered-collections"
  , "prelude"
  , "routing"
  , "routing-duplex"
  , "spec"
  , "spec-node"
  , "strings"
  , "transformers"
  , "tuples"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
