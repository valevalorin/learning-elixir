defmodule Airport.Weather do

  import SweetXml

  def get_weather_data(url) do
    url
    |> HTTPoison.get
    |> validate
  end

  def validate({:ok, %{status_code: 200, body: body}}) do 
    {:ok, body}
  end

  def validate({:ok, %{status_code: code, body: body}}) do 
    {:error, "Returned Status Code: #{code}~n#{body}"}
  end

  def validate({_, reason}) do 
    {:error, "Critical Error!: #{reason}"}
  end

  def parse(xml) do
    station = xml |> xpath(~x"//current_observation/station_id/text()")
    datetime = xml |> xpath(~x"//current_observation/observation_time/text()")
    temp = xml |> xpath(~x"//current_observation/temperature_string/text()")
    wind = xml |> xpath(~x"//current_observation/wind_string/text()")
    {station, datetime, temp, wind}
  end

end