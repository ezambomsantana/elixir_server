defmodule ElixirServer.Router do
  import Plug.Conn
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  @carid   "id"
  @lat     "lat"
  @lon     "lon"
  @vertexid "vertexid"

  def init(options) do
    Application.put_env(App, :pid_data, options, [])
  end

  get("/save", do: save(conn))
  get("/get", do: get(conn))
  get("/change_route", do: change_route(conn))
  get("/get_new_route", do: get_new_route(conn))
  match(_, do: send_resp(conn, 404, "Oops!\n"))

  def save(conn) do    
    conn = fetch_query_params(conn, []) # populates conn.params
    %{ @carid => id, @lat => lat, @lon => lon } = conn.params
    pid = Application.get_env(App, :pid_data, nil) 
    send(pid, {:save, id, { lat, lon }})
    send_resp(conn, 200, "save\n")
  end
	
  def get(conn) do
    conn = fetch_query_params(conn, []) # populates conn.params
    %{ @carid => id } = conn.params
    pid = Application.get_env(App, :pid_data, nil) 
    send(pid, {:get, id, self()})
    receive do
       {:value, value} -> send_resp(conn, 200, elem(value, 0) <> "," <> elem(value, 1))
    end
  end

  def change_route(conn) do
    conn = fetch_query_params(conn,[])
    %{ @carid => id , @vertexid => vertexid } = conn.params
    pid = Application.get_env(App, :pid_data, nil)  
    send(pid, {:save_new_destination, id, vertexid})
    send_resp(conn, 200, "change_route\n")
  end

  def get_new_route(conn) do
    conn = fetch_query_params(conn, []) # populates conn.params
    %{ @carid => id } = conn.params
    pid = Application.get_env(App, :pid_data, nil) 
    send(pid, {:get_new_destination, id, self()})
    receive do
       {:value, value} -> send_resp(conn, 200, value)
    end
  end

end
