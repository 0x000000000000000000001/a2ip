{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "halo"
, dependencies =
  [ "aff"
  , "affjax"
  , "affjax-web"
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
  , "integers"
  , "maybe"
  , "nonempty"
  , "now"
  , "prelude"
  , "routing"
  , "routing-duplex"
  , "strings"
  , "transformers"
  , "tuples"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
