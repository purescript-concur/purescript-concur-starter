module Widgets.SimpleCalculatorWidget where

import Control.Bind (bind)
import Data.Function (($))
import Data.Functor ((<$))
import Concur.Core (Widget)
import Concur.React (HTML)
import Concur.React.Props as Props
import Concur.React.DOM (div, text, table, tbody, tr, td)

import SimpleCalculator as SimpleCalculator

calculatorWidget :: SimpleCalculator.Status -> Widget HTML SimpleCalculator.Key
calculatorWidget status = div [] [
    div [Props.className "display"] [text status.display],
    table [] [
        tbody [] [
            tr [] [
                key 1 ""          SimpleCalculator.K_7        "7",
                key 1 ""          SimpleCalculator.K_8        "8",
                key 1 ""          SimpleCalculator.K_9        "9",
                key 1 "operator"  SimpleCalculator.K_Divide   "/"
            ],
            tr [] [
                key 1 ""          SimpleCalculator.K_4        "4",
                key 1 ""          SimpleCalculator.K_5        "5",
                key 1 ""          SimpleCalculator.K_6        "6",
                key 1 "operator"  SimpleCalculator.K_Multiple "*"
            ],
            tr [] [
                key 1 ""          SimpleCalculator.K_1        "1",
                key 1 ""          SimpleCalculator.K_2        "2",
                key 1 ""          SimpleCalculator.K_3        "3",
                key 1 "operator"  SimpleCalculator.K_Subtract "-"
            ],
            tr [] [
                key 2 ""          SimpleCalculator.K_0        "0",
                key 1 "decimal"   SimpleCalculator.K_Dot      ".",
                key 1 "operator"  SimpleCalculator.K_Add      "+"
            ],
            tr [] [
                key 3 "result"    SimpleCalculator.K_Equal    "=",
                key 1 "cancel"    SimpleCalculator.K_C        "C"
            ]
        ]
    ]
]
    where
        key :: Int -> String -> SimpleCalculator.Key -> String -> Widget HTML SimpleCalculator.Key
        key colSpan className action label = action <$ td [Props.colSpan colSpan, Props.className className, Props.onClick] [text label]

widget :: forall a. Widget HTML a
widget = go SimpleCalculator.initialState
    where
        go :: SimpleCalculator.Status -> Widget HTML a
        go status = do
            key <- calculatorWidget status
            go $ SimpleCalculator.handleKey status key
