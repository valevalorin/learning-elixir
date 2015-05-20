defmodule CF do

  def fizzbuzz(n) do 
    _fizzbuzz(1..n, [])
  end  

  defp _fizzbuzz(x..n, current) when x == n+1 do
    []
  end

  defp _fizzbuzz(x..n, current) do
      case {rem(x, 3), rem(x, 5)} do
        {0, 0} -> ["FizzBuzz" | _fizzbuzz(x+1..n, current)]
        {0, _} -> ["Fizz" | _fizzbuzz(x+1..n, current)]
        {_, 0} -> ["Buzz" | _fizzbuzz(x+1..n, current)]
        {_, _} -> [x | _fizzbuzz(x+1..n, current)]
      end
  end  

  def ok!({status, data}) when status == :ok do
    data
  end

  def ok!({status, _data}) do
    raise "Status from ok call was #{status}, not :ok."
  end
end