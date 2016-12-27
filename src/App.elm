port module App exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json
import Json.Encode as Encode


-- OUTGOING PORTS


{-| alterTable domId action index
-}
port alterTable : ( String, String, Int ) -> Cmd msg


{-| getData domId
-}
port getTableData : String -> Cmd msg



-- INCOMING PORTS


type alias TableDataVal =
    { domId : String
    , data : Json.Value
    }


port tableData : (TableDataVal -> msg) -> Sub msg



-- UTILITIES


initTableData : List (List String)
initTableData =
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


domId : String
domId =
    "table-1"



-- MODEL


type alias Model =
    { table : Json.Value
    , lastData : String
    }


initModel : Model
initModel =
    { table = encodeTable initTableData
    , lastData = ""
    }


init : ( Model, Cmd Msg )
init =
    ( initModel, Cmd.none )



-- UPDATE


type Msg
    = NoOp
    | AddRow
    | AddColumn
    | RemoveRow
    | RemoveColumn
    | ShowData
    | TableData TableDataVal


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        AddRow ->
            ( model, alterTable ( domId, "insert_row", -1 ) )

        AddColumn ->
            ( model, alterTable ( domId, "insert_col", -1 ) )

        RemoveRow ->
            ( model, alterTable ( domId, "remove_row", -1 ) )

        RemoveColumn ->
            ( model, alterTable ( domId, "remove_col", -1 ) )

        ShowData ->
            ( model, getTableData domId )

        TableData v ->
            let
                -- TODO: default null values in tables to empty strings
                decoded =
                    case Json.decodeValue (Json.list (Json.list Json.string)) v.data of
                        Ok lists ->
                            "Ok: " ++ (toString lists)
                        Err err ->
                            "Error: " ++ err
            in
                ( { model | lastData = decoded }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ text "hot-table example" ]
        , div []
            [ hotTable
                [ id domId
                , attribute "datarows" (Encode.encode 0 model.table)
                ]
                []
            ]
        , div []
            [ div [] [ text "Data:" ]
            , div [] [ text model.lastData ]
            ]
        , div []
            [ button [ onClick AddRow ] [ text "Add Row" ]
            , button [ onClick AddColumn ] [ text "Add Column" ]
            , button [ onClick RemoveRow ] [ text "Remove Row" ]
            , button [ onClick RemoveColumn ] [ text "Remove Column" ]
            , button [ onClick ShowData ] [ text "Show Data" ]
            ]
        ]


hotTable : List (Attribute a) -> List (Html a) -> Html a
hotTable =
    Html.node "hot-table"



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    tableData TableData
