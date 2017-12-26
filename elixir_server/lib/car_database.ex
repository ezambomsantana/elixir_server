defmodule CarDatabase do

  def create() do
    :ok
  end

  def store_data(Car, Data) do
    Process.put(Car, Data)
  end

  def get_data(Car) do
    Process.get(Car)
  end

end
