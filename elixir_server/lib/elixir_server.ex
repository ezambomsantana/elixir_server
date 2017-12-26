defmodule ElixirServer.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  def init(options) do
    IO.puts "teste"
    options
  end

  get("/save_car_position", do: save_car_position(conn))
  get("/get_car_position", do: get_car_position(conn))
  match(_, do: send_resp(conn, 404, "Oops!\n"))

  def save_car_position(conn) do
     send_resp(conn, 200, "save_car_position\n")
  end

  def get_car_position(conn) do
     send_resp(conn, 200, "get_car_position\n")
  end

end
