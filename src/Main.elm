module Main exposing (..)

import Dict exposing (Dict)


{-| Get all k-length combinations of items in a list
-}
combinations : Int -> List Int -> List (List Int)
combinations k items =
    if k <= 0 then
        [ [] ]

    else
        case items of
            [] ->
                []

            head :: tail ->
                List.map ((::) head) (combinations (k - 1) tail) ++ combinations k tail
