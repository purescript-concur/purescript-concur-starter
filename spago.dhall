{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ sources = [ "src/**/*.purs", "test/**/*.purs" ]
, name = "purescript-concur-starter"
, dependencies = [ "effect", "console", "concur-core", "concur-vdom" ]
, packages = ./packages.dhall
}
