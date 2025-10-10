{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "halo"
, dependencies =
  [ "aff"
  , "aff-promise"
  , "affjax"
  , "affjax-node"
  , "affjax-web"
  , "ansi"
  , "arraybuffer-types"
  , "arrays"
  , "colors"
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
  , "lists"
  , "maybe"
  , "node-buffer"
  , "node-fs"
  , "node-process"
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
, sources =
  [ "bin/purs/**/*.purs", "conf/**/*.purs", "src/**/*.purs", "test/**/*.purs" ]
}
