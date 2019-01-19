module Main where

import Prelude

import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D
import Concur.React.Run (runWidgetInDom)
import Effect (Effect)

rootWidget :: forall a. Widget HTML a
rootWidget = D.text "Hello World"

main :: Effect Unit
main = runWidgetInDom "root" rootWidget
