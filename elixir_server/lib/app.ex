defmodule App do
  use Application

  def start() do
    start(:a,:b)
  end
 
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    pidCar = spawn(CarDatabase, :start, [])

    Plug.Adapters.Cowboy.http ElixirServer.Router, pidCar
  end
end
