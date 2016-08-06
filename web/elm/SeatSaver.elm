module SeatSaver exposing (main)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Json exposing ((:=))
import Task


main : Program Never
main =
  Html.program
    { init = init
    , update = update
    , view = view
    , subscriptions = (\_ -> Sub.none)
    }


-- MODEL


type alias Seat =
  { seatNo : Int
  , occupied : Bool
  }

type alias Model =
  List Seat


init : (Model, Cmd Msg)
init =
  ([], fetchSeats)


-- UPDATE


type Msg 
  = Toggle Seat
  | SetSeats (Maybe Model) 
  | GetSeatsFailed Http.Error


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Toggle seatToToggle ->
      let
        updateSeat seatFromModel =
          if seatFromModel.seatNo == seatToToggle.seatNo then
            { seatFromModel | occupied = not seatFromModel.occupied }
          else seatFromModel
      in
        (List.map updateSeat model, Cmd.none)
    SetSeats seats ->
      let
        newModel = Maybe.withDefault model seats
      in
        (newModel, Cmd.none)
    GetSeatsFailed _ ->
      (model, Cmd.none)


-- EFFECTS


fetchSeats: Cmd Msg
fetchSeats =
  Http.get decodeSeats "http://localhost:4000/api/seats"
    |> Task.toMaybe
    |> Task.perform GetSeatsFailed SetSeats


decodeSeats: Json.Decoder Model
decodeSeats =
  let
    seat =
      Json.object2 (\seatNo occupied -> (Seat seatNo occupied))
        ("seatNo" := Json.int)
        ("occupied" := Json.bool)
  in
    Json.at ["data"] (Json.list seat)


-- VIEW


view : Model -> Html Msg
view model =
  ul [ class "seats" ] (List.map seatItem model)


seatItem : Seat -> Html Msg
seatItem seat =
  let
    occupiedClass =
      if seat.occupied then "occupied" else "available"
  in
    li
      [ class ("seat " ++ occupiedClass)
      , onClick (Toggle seat)]
      [ text (toString seat.seatNo) ]
