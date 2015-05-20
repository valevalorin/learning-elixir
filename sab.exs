#String And Binaries
defmodule SAB do

	def ascii?([head | []]) when head >= 32 and head <= 126 do
		true
	end
	
	def ascii?([head | tail]) when head >= 32 and head <= 126 do
		ascii?(tail)
	end

	def ascii?(_str) do
		false
	end

	def anagram?(str) when is_list(str) do
		str == Enum.reverse(str)
	end

	def anagram?(_str) do 
		false
	end

	def number_digits([ digit | tail ], value) when digit in '0123456789' do
		number_digits(tail, value*10 + digit - ?0)
	end

	def column_print(list) do
		max = Enum.max_by(list, &String.length/1) |> String.length
		Enum.map(list, &IO.puts(String.rjust(&1, (div(max-String.length(&1), 2))+String.length(&1))))
	end

	# def capitalize_sentences(<< head :: utf8, tail :: binary >>) do
	# 	String.capitalize(<<head>>) <> _capitalize_sentences(tail)
	# end

	# defp _capitalize_sentences(<<>>) do
	# 	<<>>
	# end

	# defp _capitalize_sentences(<< "." :: utf8, " " :: utf8, << head :: utf8, tail :: binary  >> >>) do
	# 	". " <> String.capitalize(<<head>>) <> _capitalize_sentences(tail)
	# end

	# defp _capitalize_sentences(<< head :: utf8, tail :: binary >>) do
	# 	<<head>> <> _capitalize_sentences(tail)
	# end

	#@tax_string = "123,:NC,100.00\n"

	def capitalize_sentences(str) do
		String.split(str, ". ") 
		|> Stream.reject(&(String.length(&1) == 0))
		|> Stream.map( &(String.capitalize(&1 <> ". ")) ) 
		|> Enum.reduce("", &(&2 <> &1))
	end

	def process_tax_file(file) do
		Stream.resource(
			fn -> File.open(file) end,
			fn {status, file} -> 
				case IO.read(file, :line) do
					line when is_binary(line) -> { process_tax_line(line), {status, file} }
					_ -> {:halt, file}
				end
			end,
			fn file -> File.close(file) end)
			|> Enum.to_list #|> other processing function
	end

	def process_tax_line(<< id_num :: integer, "," :: utf8, ":" :: utf8, state  :: binary-size(2), "," :: utf8, amount :: float, "\n" :: utf8 >>) do 
		[id: id_num, ship_to: String.to_atom(state), net_amount: amount]
	end





	
end