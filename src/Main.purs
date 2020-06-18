module Main where

import Prelude

import Concur.Core (Widget)
import Concur.VDom (HTML)
import Concur.VDom.DOM as D
import Concur.VDom.Props as P
import Concur.VDom.Run (runWidgetInDom)
import Effect (Effect)

hello :: forall a. Widget HTML a
hello = do
  void $ D.node "button" [P.handle "click"] [D.text "Say Hello"]
  D.text "Hello Sailor!"

main :: Effect Unit
main = runWidgetInDom "root" hello
