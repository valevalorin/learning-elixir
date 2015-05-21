defmodule SpawnN do
  def greet(num) do
    for x <- 1..num do
      spawn(SpawnN, :greet2, [x])
    end
  end

  def greet2(num) do
    for x <- 1..1000 do
      IO.puts "I am number #{num}! My iteration number is #{x}!"
    end
  end

end