module NoDebug.Log exposing (rule)

{-|

@docs rule

-}

import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node)
import Review.ModuleNameLookupTable as ModuleNameLookupTable exposing (ModuleNameLookupTable)
import Review.Rule as Rule exposing (Error, Rule)


{-| Forbid the use of [`Debug.log`](https://package.elm-lang.org/packages/elm/core/latest/Debug) before it goes into production or fails in the CI.

`Debug.log` is useful to debug your code, but should not be pushed to production.

    config =
        [ NoDebug.Log.rule
        ]


## Fail

    if Debug.log "condition" condition then
        a

    else
        b


## Success

    if condition then
        a

    else
        b


# When (not) to use this rule

You should use this rule if you're developing a package meant to be published,
or an application that is put into production, and wish to know about the use of
[`Debug.log`](https://package.elm-lang.org/packages/elm/core/latest/Debug#log)
module before committing your changes.

You should not use this rule if you are developing an application that is not
put into production, and you do not care about having stray debug logs, and you
do not ship to production.


## Try it out

You can try this rule out by running the following command:

```bash
elm-review --template jfmengels/elm-review-debug/example --rules NoDebug.Log
```

-}
rule : Rule
rule =
    Rule.newModuleRuleSchemaUsingContextCreator "NoDebug.Log" initContext
        |> Rule.withExpressionEnterVisitor expressionVisitor
        |> Rule.fromModuleRuleSchema


type alias Context =
    ModuleNameLookupTable


initContext : Rule.ContextCreator () ModuleNameLookupTable
initContext =
    Rule.initContextCreator (\lookupTable () -> lookupTable)
        |> Rule.withModuleNameLookupTable


error : Node a -> Error {}
error node =
    Rule.error
        { message = "Remove the use of `Debug.log` before shipping to production"
        , details =
            [ "`Debug.log` is useful when developing, but is not meant to be shipped to production or published in a package. I suggest removing its use before committing and attempting to push to production."
            ]
        }
        (Node.range node)


expressionVisitor : Node Expression -> Context -> ( List (Error {}), Context )
expressionVisitor node lookupTable =
    case Node.value node of
        Expression.FunctionOrValue _ "log" ->
            case ModuleNameLookupTable.moduleNameFor lookupTable node of
                Just [ "Debug" ] ->
                    ( [ error node ], lookupTable )

                _ ->
                    ( [], lookupTable )

        _ ->
            ( [], lookupTable )
