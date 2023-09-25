module Main exposing (Model,Msg,update,init,view,onKeyDown,viewTodos,main)
import Browser
import Html exposing (Html, button, div, text, input, ul, li,Attribute,h1)
import Html.Events exposing (onClick,onInput,on,keyCode)
import Html.Attributes exposing (type_, placeholder, value,style)
import List exposing (map)
import Json.Decode as Json
import Html.Lazy


-- MODEL

type alias Model =
    { item : String
    , todos : List String
    }

init : Model
init =
    { item = ""
    , todos = []
    }

-- UPDATE

type Msg
    = Add
      |Change String
      |KeyDown Int

update : Msg -> Model -> Model
update msg model =
    case msg of
        Add->
            { model | todos = model.todos ++ [model.item], item = "" }
        Change newContent->
            {model| item=newContent}
        KeyDown key ->
          if key == 13 then
           { model | todos = model.todos ++ [model.item], item = "" }
          else
            model
            
onKeyDown : (Int -> msg) -> Attribute msg
onKeyDown tagger =
  on "keydown" (Json.map tagger keyCode)


-- VIEW



viewTodos : String -> Html Msg
viewTodos todo =
     li [] [text todo]

view : Model -> Html Msg
view model =
    div []
        
        [ h1[ style "margin" "10px",style "display" "block",style "color" "#6161FF"] [text "Todo list"]
          ,input [type_ "text", placeholder "Enter an item", value model.item, onInput Change, onKeyDown KeyDown] []

        ,button [onClick Add, style "margin-left" "10px" ,style "background-color" "#000000", style "color" "white",style "padding" "5px"] [text "Add item"]
        , ul [] (List.map viewTodos model.todos)
        ]

-- MAIN

main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
      
        }