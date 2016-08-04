module SeatSaver exposing (main)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


main : Program Never
main =
  Html.beginnerProgram
    { model = init
    , update = update
    , view = view
    }


-- MODEL


type alias Seat =
  { seatNo : Int
  , occupied : Bool
  }

type alias Model =
  List Seat


init : Model
init =
  [ { seatNo = 1, occupied = False}
  , { seatNo = 2, occupied = False}
  , { seatNo = 3, occupied = False}
  , { seatNo = 4, occupied = False}
  , { seatNo = 5, occupied = False}
  , { seatNo = 6, occupied = False}
  , { seatNo = 7, occupied = False}
  , { seatNo = 8, occupied = False}
  , { seatNo = 9, occupied = False}
  , { seatNo = 10, occupied = False}
  , { seatNo = 11, occupied = False}
  , { seatNo = 12, occupied = False}
  ]


-- UPDATE


type Action = Toggle Seat

update : Action -> Model -> Model
update action model =
  case action of
    Toggle seatToToggle ->
      let
        updateSeat seatFromModel =
          if seatFromModel.seatNo == seatToToggle.seatNo then
            { seatFromModel | occupied = not seatFromModel.occupied }
          else seatFromModel
      in
        List.map updateSeat model


-- VIEW


view : Model -> Html Action
view model =
  ul [ class "seats" ] (List.map seatItem model)


seatItem : Seat -> Html Action
seatItem seat =
  let
    occupiedClass =
      if seat.occupied then "occupied" else "available"
  in
    li
      [ class ("seat " ++ occupiedClass)
      , onClick (Toggle seat)]
      [ text (toString seat.seatNo) ]
