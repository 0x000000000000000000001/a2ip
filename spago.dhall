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
  , "ansi"
  , "arraybuffer-types"
  , "arrays"
  , "avar"
  , "concurrent-queues"
  , "console"
  , "const"
  , "css"
  , "datetime"
  , "effect"
  , "either"
  , "exceptions"
  , "foldable-traversable"
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
  , "parallel"
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
, sources = [ "bin/**/*.purs", "src/**/*.purs", "test/**/*.purs" ]
}
