# review-debug

Provides [`elm-review`](https://package.elm-lang.org/packages/jfmengels/elm-review/latest/) rules to detect debug code.


## Provided rules

- [`NoDebug.Log`](https://package.elm-lang.org/packages/jfmengels/review-debug/2.0.1/NoDebug-Log) - Reports uses of [`Debug.Log`](https://package.elm-lang.org/packages/elm/core/latest/Debug#log).
- [`NoDebug.TodoOrToString`](https://package.elm-lang.org/packages/jfmengels/review-debug/2.0.1/NoDebug-TodoOrToString) - Reports uses of [`Debug.todo`](https://package.elm-lang.org/packages/elm/core/latest/Debug#todo) and [`Debug.toString`](https://package.elm-lang.org/packages/elm/core/latest/Debug#toString).


## Configuration

```elm
module ReviewConfig exposing (config)

import NoDebug.Log
import NoDebug.TodoOrToString
import Review.Rule exposing (Rule)

config : List Rule
config =
    [ NoDebug.Log.rule
    , NoDebug.TodoOrToString.rule
    ]
```
