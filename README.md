# review-debug

Provides [`elm-review`](https://package.elm-lang.org/packages/jfmengels/elm-review/latest/) rules to detect debug code.


## Provided rules

- [`NoDebug`](./NoDebug) - Reports uses or imports of the [`Debug` module](https://package.elm-lang.org/packages/elm/core/latest/Debug).


## Configuration

```elm
module ReviewConfig exposing (config)

import Review.Rule exposing (Rule)
import NoDebug

config : List Rule
config =
    [ NoDebug.rule
    ]
```
