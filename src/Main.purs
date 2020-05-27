module Main where

import Concur.React.Run (runWidgetInDom)
import Control.Bind (discard)
import Data.Function (($))
import Data.Unit (Unit)
import Effect (Effect)
import Effect.Aff (Milliseconds(..), delay, launchAff_)
import Effect.Class (liftEffect)
import Widgets.SimpleCalculatorWidget (widget)

main :: Effect Unit
main = launchAff_ do
  delay (Milliseconds 0.0)
  liftEffect $ runWidgetInDom "concur" widget
