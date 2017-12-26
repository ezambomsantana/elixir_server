defmodule CarDatabase do

  def start() do
    receive do
       {:save, key, value} -> store_data(key, value)
       {:get, key, pid} -> get_data(key, pid)
       _ -> :ok
    end
    start()
  end

  def store_data(car, data) do
    Process.put(car, data)
    :ok
  end

  def get_data(car, pid) do
    value = Process.get(car)
    send(pid, {:value, value})
  end

end
