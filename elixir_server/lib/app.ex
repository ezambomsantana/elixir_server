defmodule App do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args	) do
    import Supervisor.Spec, warn: false

    pidCar = spawn(CarDatabase, :create, [])

    Plug.Adapters.Cowboy.http ElixirServer.Router, [pidCar]
  end
end
