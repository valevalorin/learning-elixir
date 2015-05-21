defmodule Airport.Table do
  def table({:ok, data}) do 
    {station, datetime, temp, wind} = Airport.Weather.parse(data)
    "#{station} - #{datetime}\n#{temp}\nWind blowing #{wind}"
  end

  def table({_status, data}) do 
    data
  end
end