---
follows: ../data/dayOne.md

id: "litvis"
---

@import "../styles/litvis.less"

# Day One

Experimenting with Literate Elm. First task was to figure out how to get started with "hello world" and what custom styles I want to use.

```elm {l r}
message : String
message =
    "Hello, World"
```

It looks like type annotations are necessary for output to be shown. When removing `message: String` above, the output is not shown. This is likely something specific to `litvis`.


### Part One

This one is relatively simple. I will use the same strategy I used in my Swift version -> Creating a dictionary first, then iterating over the list to see if any item exists that is equal to the desired value (2020) minus that item.

```elm {l}
tuple : Int  -> (Int, Int)
tuple x = (x, x)

dictionary : Dict Int Int
dictionary =
    Dict.fromList (List.map tuple puzzleInput)

predicate : Int -> Bool
predicate input =
    Dict.member (2020 - input) dictionary
```

Above I am defining some helper functions for the final answer calculation below.

```elm {l r}
answer : Int
answer =
  List.filter predicate puzzleInput
  |> List.foldl (*) 1
```

### Part Two

This one is more difficult because the above strategy will not work. I need to iterate through the same loop twice, getting all pairs of values.

```elm {l}
combinations : Int -> List Int -> List (List Int)
combinations k items =
    if k <= 0 then
        [ [ ] ]

    else
        case items of
            [] ->
                []

            head :: tail ->
                List.map ((::) head) (combinations (k-1) tail) ++ combinations k tail
```

```elm {l}
allCombinations: Maybe Int
allCombinations =
  puzzleInput
    |> combinations 2
    >> List.filter (\twos -> List.sum twos < 2020)
    >> List.filter (\twos -> Dict.member (2020 - List.sum twos) dictionary)
    >> List.map (\item -> (List.product item) * (2020 - (List.sum item)))
    >> List.head
```

Whew! That wasn't so bad. In the end, it's very similar to how I would do it in Swift with the same functions (`filter`, `map`, etc). It seems a little bit tricker here because I'm not sure right now how to define interim values, and instead seems like I have to construct the entire pipeline at once. This is probably why I always hear about creating small functions that can plug in at the right time (see `combinations` and `predicate` above. The recursive statement for combinations makes more sense when I think of what I learned from the Scheme language.

The compiler was relatively helpful, but it's not as nice as Xcode + Swift where. That may be a limitation of the tooling in Atom. Overall, I was able to figure out type signatures with a combination of Elm's errors and keeping track of the types. The one thing I missed was having the `Cmd + Option` pattern for finding the type of a variable. Here instead what it seems I have to do is write the type signature and let the compiler tell me I'm wrong.
