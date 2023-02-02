module Main where

import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.DOM as D
import Concur.React.Props as P
import Concur.React.Run (runWidgetInDom)
import Control.Bind ((>>=))
import Control.Monad (class Monad)
import Data.CommutativeRing ((*), (+))
import Data.EuclideanRing ((-), (/))
import Data.Function (($))
import Data.Functor (($>), (<$>))
import Data.Semigroup ((<>))
import Data.Show (show)
import Data.Unit (Unit)
import Effect (Effect)


-- Let's build a simple program that lets us convert from feet to inches and vice versa.

-- We can build this program top-down or bottom-up.
-- Let's build it bottom up for a change of pace.

-- Step 1: Let's write the logic. The pure functions that convert between feet and inches.

type Feet = Int
type Inches = Int

feetToInches :: Feet -> Inches
feetToInches feet = feet * 12

inchesToFeet :: Inches -> Feet
inchesToFeet inches = inches / 12

-- Step 2: We'll need some way to get an integer (representing either feet or inches)
--         as an input from the user.
--   The normal method would be to use an input box, but that would be a very simple
--   widget, and not demonstrate composing widgets with many buttons etc.
--   Also, we would also need to deal with things like input validation.
--   So let's build a "counter" widget which has "increment" and "decrement" buttons.

-- This counter widget will have a state i.e. the current count. Stateful widgets in Concur
--   take the current state as input and return the modified state on user input.
--   i.e. the type is `State -> Widget HTML State`
-- We will also take a String label which would be shown at the top of the widget.

counter :: String -> Int -> Widget HTML Int
counter label count = D.pre'
  [ D.text $ label <> " : " <> show count <> "  "
  , D.button [P.onClick] [D.text "-"] $> count-1
  , D.button [P.onClick] [D.text "+"] $> count+1
  ]

-- That was easy!

-- Step 3: Now we can put together two of these counters to get our UI -
--   A bidirectional form which can convert between feet and inches (and vice versa).
--   This is also a stateful widget, where the state will be either feet or inches.
--   We'll choose inches since we want to change by lengths smaller than a foot..
--   Since we picked inches as our source of truth, we'll need to convert inches to feet
--   and vice versa when displaying the feet counter.
--
--   We also add some CSS
converter :: Int -> Widget HTML Int
converter inches = D.div [P.style {"font-family": "Roboto, Helvetica, Arial, sans-serif"}]
  [ D.h1' [D.text "Concur PureScript Starter"]
  , D.div [P.style { width: "fit-content", padding: "0 10px", background: "lightblue", border: "4px solid darkgray" }]
    [ D.h3'  [D.text "Converter between feet and inches"]
    , feetToInches <$> counter "Feet  " (inchesToFeet inches)
    , counter "Inches" inches
    ]
  ]

-- Step 4: Now, we have a widget (converter) that converts between inches and feet.
--   However, it takes the current state as input and returns the updated state.
--   We now need some plumbing which will pipe the updated state back into the input.
--   This plumbing function is called `loopState'` in the concur-core library.
--   However, let's build this plumbing abstraction ourselves and use it!

-- Note that this abstraction is entirely built on monads! We don't even depend on widgets!
--   A loop takes a stateful monadic expression (s -> m s), and an initial state (s),
--   and loops them forever. Since the loop will never return, the return value is (forall a. a)
-- | Loop widget with localised state forever.
loop :: forall a m s. Monad m => (s -> m s) -> s -> m a
loop f s = f s >>= loop f

-- That's it! Note that this is a design pattern.
--   Building your own design patterns is super simple in monadic Concur!

-- Step 5. Loop our stateful converter UI.
--   We pass 0 (inches) as the initial state,
ui :: forall a. Widget HTML a
ui = loop converter 0

-- There you have it! A complete non-trivial Concur program. Built in an entirely composable way!

-- Let's run it
main :: Effect Unit
main = runWidgetInDom "root" ui
