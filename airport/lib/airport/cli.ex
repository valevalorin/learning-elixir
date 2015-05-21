defmodule Airport.CLI do

  require Logger

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  def parse_args(argv) do
    Logger.debug("YOooooooo")
    parse = OptionParser.parse(argv)

    case parse do
      {_, url, _} -> url
      _ -> "Error processing arguments\n"
    end
  end

  def process(url) do
    url
    |> Airport.Weather.get_weather_data
    |> Airport.Table.table
    |> IO.puts
  end
    
end