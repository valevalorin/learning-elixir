defmodule Issues.CLI do
  @default_count 4

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean],
      aliases: [h: :help])

    case parse do
      {[help: true], _, _} -> :help
      {_, [user, project, count], _} -> {user, project, String.to_integer(count)}
      {_, [user, project], _} -> {user, project, @default_count}
      _ -> :help
    end
  end

  def process(:help) do
    IO.puts """
    usage: issues <user> <project> [ count | #{@default_count} ]
    """
    System.halt(0)
  end

  def process({user, project, count}) do
    Issues.GithubIssues.fetch(user, project)
    |> decode_response
    |> convert_to_list_of_hashdicts
    |> sort_into_ascending_order
    |> Enum.take(count)
    |> print_table
  end

  def decode_response({:ok, body}), do: body

  def decode_response({:error, error}) do
    {_, message} = List.keyfind(error, "message", 0)
    IO.puts "Error fetching from Github: #{message}"
    System.halt(2)
  end

  def convert_to_list_of_hashdicts(list) do
    list
    |> Enum.map(&Enum.into(&1, HashDict.new))
  end

  def sort_into_ascending_order(list_of_issues) do
    Enum.sort list_of_issues,
    fn i1, i2 -> i1["created_at"] <= i2["created_at"] end
  end

  @doc """
  Takes a list of row data, where each row is a HashDict, and a list of
  headers. Prints a table to STDOUT of the data from each row
  identified by each header. That is, each header identifies a column,
  and those columns are extracted and printed from the rows.
  We calculate the width of each column to fit the longest element
  in that column.
  """

  def print_table(list) do 
    id_field_size = max_field_size(list, "number")
    title_field_size = max_field_size(list, "title")
    IO.puts(" " <> String.ljust("#", id_field_size) <> "| " <> String.ljust("created_at", 21) <> "| " <> String.ljust("title", title_field_size+1))
    IO.puts(String.duplicate("-", id_field_size+1) <> "+" <> String.duplicate("-", 22) <> "+" <> String.duplicate("-", title_field_size+1))
    Enum.map(list, &print_row(&1, id_field_size, title_field_size))
  end

  def test(list) do 
   Enum.map(list, &(HashDict.get(&1, "title") |> IO.inspect ))
  end

  def max_field_size(list, key) do
    list 
    |> Stream.map(&HashDict.get(&1, key)) 
    |> Stream.map(&convert_to_string(&1)) 
    |> Enum.max_by(&String.length(&1)) 
    |> String.length
  end

  def convert_to_string(x) when is_integer(x) do
    Integer.to_string(x)
  end

  def convert_to_string(x) do
    x
  end

  def print_row(row, id_field_size, title_field_size) do
    IO.puts(String.ljust(HashDict.get(row, "number") |> Integer.to_string, id_field_size) <> " | " <> String.ljust(HashDict.get(row, "created_at"), 21) <> "| " <> String.ljust(HashDict.get(row, "title"), title_field_size))
  end

end