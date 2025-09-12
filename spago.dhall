{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "halo"
, dependencies =
  [ "aff"
  , "console"
  , "const"
  , "css"
  , "datetime"
  , "effect"
  , "halogen"
  , "halogen-css"
  , "maybe"
  , "nonempty"
  , "now"
  , "prelude"
  , "routing"
  , "strings"
  , "transformers"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
