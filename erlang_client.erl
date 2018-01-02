-module(erlang_client).

-export( [
            call_save_coordinates/2,
            call_get_coordinates/1,
            call_change_route/2,
            call_get_new_route/1
         ]).

call_save_coordinates( Car , Coordinates ) ->

   inets:start(),

   URL = "http://localhost:4000/save?id=" ++ Car ++ "&lat=" ++ element(1, Coordinates) ++ "&lon=" ++ element(2, Coordinates),

   case httpc:request(get, {URL, []}, [], []) of
      {ok, {{_Version, 200, _ReasonPhrase}, _Headers, Body}} ->
         io:format("saida: ~s", [ Body]);
      _ -> io:format("erro")
   end.

call_get_coordinates( Car ) ->

   inets:start(),

   URL = "http://localhost:4000/get?id=" ++ Car,

   case httpc:request(get, {URL, []}, [], []) of
      {ok, {{_Version, 200, _ReasonPhrase}, _Headers, Body}} ->
         io:format("saida: ~s", [ Body ]);
      _ -> io:format("erro")
   end.

call_change_route( Car , VertexId ) ->

   inets:start(),

   URL = "http://localhost:4000/change_route?id=" ++ Car ++ "&vertexid=" ++ VertexId,

   case httpc:request(get, {URL, []}, [], []) of
      {ok, {{_Version, 200, _ReasonPhrase}, _Headers, Body}} ->
         io:format("saida: ~s", [ Body]);
      _ -> io:format("erro")
   end.

call_get_new_route( Car ) ->

   inets:start(),

   URL = "http://localhost:4000/get_new_route?id=" ++ Car,

   case httpc:request(get, {URL, []}, [], []) of
      {ok, {{_Version, 200, _ReasonPhrase}, _Headers, Body}} ->
         io:format("saida: ~s", [ Body ]);
      _ -> io:format("erro")
   end.
