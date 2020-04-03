# review-debug

Provides [`elm-review`](https://package.elm-lang.org/packages/jfmengels/elm-review/latest/) rules to detect debug code.


## Provided rules

- [`NoDebug.Log`](./NoDebug-Log) - Reports uses of [`Debug.Log`](https://package.elm-lang.org/packages/elm/core/latest/Debug#log).


## Configuration

```elm
module ReviewConfig exposing (config)

import NoDebug.Log
import Review.Rule exposing (Rule)

config : List Rule
config =
    [ NoDebug.Log.rule
    ]
```
