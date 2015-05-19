defmodule MyList do
	@orders [
		[ id: 123, ship_to: :NC, net_amount: 100.00 ],
		[ id: 124, ship_to: :OK, net_amount: 35.50 ],
		[ id: 125, ship_to: :TX, net_amount: 24.00 ],
		[ id: 126, ship_to: :TX, net_amount: 44.80 ],
		[ id: 127, ship_to: :NC, net_amount: 25.00 ],
		[ id: 128, ship_to: :MA, net_amount: 10.00 ],
		[ id: 129, ship_to: :CA, net_amount: 102.00 ],
		[ id: 120, ship_to: :NC, net_amount: 50.00 ] 
	]

	@tax_rates [ NC: 0.075, TX: 0.08 ]

	def get_orders do
		@orders
	end

	def get_rates do
		@tax_rates
	end
	
	def span(from, to) when from > to do
		[]
	end 
	def span(from, to) do
	  [from | (span(from+1, to))]
	end

	def primes(n) do 
		p = span(2, n)
		p -- for x <- p, y <- p, do: x*y
	end

	def tax([], tax_rates) do
		[]
	end

	def tax([head | tail], tax_rates) do
		[add_tax(head, tax_rates) | tax(tail, tax_rates)]
	end

	def add_tax(order, tax_rates) do
		tax_rate = Keyword.get(tax_rates, Keyword.get(order, :ship_to), 0)
		tax = tax_rate * Keyword.get(order, :net_amount)
		total_amount = tax+Keyword.get(order, :net_amount)
		Keyword.put(order, :total_amount, total_amount)
	end

end

