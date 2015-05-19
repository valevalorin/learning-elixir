#String And Binaries
defmodule SAB do

	def ascii?([head | []]) when head >= 32 and head <= 126 do
		true
	end
	
	def ascii?([head | tail]) when head >= 32 and head <= 126 do
		ascii?(tail)
	end

	def ascii?(str) do
		false
	end

end