defmodule ElixirServer.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  def init(options) do
    Application.put_env(App, :pid_data, options, [])
  end

  get("/save", do: save(conn))
  get("/get", do: get(conn))
  match(_, do: send_resp(conn, 404, "Oops!\n"))

  def save(conn) do
    pid = Application.get_env(App, :pid_data, nil) 
    send(pid, {:save, 1, "1"})
    send_resp(conn, 200, "save\n")
  end
	
  def get(conn) do
    pid = Application.get_env(App, :pid_data, nil) 
    send(pid, {:get, 1, self()})
    receive do
       {:value, value} -> send_resp(conn, 200, value)
    end
  end

end
