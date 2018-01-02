defmodule CarDatabase do

  def start() do
    receive do
       {:save, key, value} -> store_data(key, value)
       {:get, key, pid} -> get_data(key, pid)
       {:save_new_destination, key, value} -> save_new_destination(key <> "_destination", value)
       {:get_new_destination, key, pid} -> get_new_destination(key <> "_destination", pid)
       _ -> :ok
    end
    start()
  end

  def save_new_destination(car, new_destination) do
    Process.put(car, new_destination)
    :ok
  end

  def get_new_destination(car, pid) do
    value = Process.get(car)
    send(pid, {:value, value})
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
