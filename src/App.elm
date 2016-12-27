module App exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Json.Decode as Json
import Json.Encode as Encode


tableData : List (List String)
tableData =
    [ [ "Col1", "Col2", "Col3" ]
    , [ "A2", "B2", "C2" ]
    , [ "A3", "B3", "C3" ]
    ]

encodeRow : List String -> Json.Value
encodeRow =
    List.map Encode.string >> Encode.list


encodeTable : List (List String) -> Json.Value
encodeTable =
    List.map encodeRow >> Encode.list


type alias Model =
    { table : Json.Value
    }


initModel : Model
initModel =
    { table = encodeTable tableData
    }


init : ( Model, Cmd Msg )
init =
    ( initModel, Cmd.none )


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



hotTable : List (Attribute a) -> List (Html a) -> Html a
hotTable =
    Html.node "hot-table"


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ text "hot-table example" ]
        , hotTable
            [ attribute "datarows" (Encode.encode 0 model.table) ]
            []
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
