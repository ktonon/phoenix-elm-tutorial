# Phoenix with Elm

This repo follows a tutorial posted at http://www.cultivatehq.com/posts/phoenix-elm-1. The tutorial comes with an official repo at https://github.com/CultivateHQ/seat_saver. I chose not to fork because I wanted to follow along.

I followed the tutorial using:

* Elixir 1.3.1
* Phoenix 1.2.0
* Elm 0.17.1

As originally posted, the tutorial used

* Elixir 1.2.3
* Phoenix 1.1.4
* Elm 0.16.0

Due to version differences (mostly with Elm I think), some steps needed modification, which are outlined in the following sections.

## Part 2 Differences

__Adding Elm into Phoenix, Step 3__

The first line of `web/elm/SeatSaver.elm` should be:

```elm
module SeatSaver exposing (main)
```

and not (`module SeatSaver where`).

__Hooking up to the frontend, Step 3__

On the second line of `web/static/js/app.js`, the `embed` call should look like this:

```javascript
Elm.SeatSaver.embed(elmDiv)
```

and not (`Elm.embed(Elm.SeatSaver, elmDiv)`). See [Why am I getting "TypeError: Elm.embed is not a function?"](http://faq.elm-community.org/17.html#why-am-i-getting-typeerror-elmembed-is-not-a-function)
