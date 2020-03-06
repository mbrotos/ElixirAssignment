defmodule Poker do

	def is_straight(hand) do
		hand_rem = Enum.sort(Enum.map(hand, fn(n) -> rem(n,13) end))
		hand_rem==[0,1,10,11,12] or
		hand_rem
		|> Enum.chunk_every(2, 1, :discard)
		|> Enum.map(fn [x, y] -> y - x end)==[1,1,1,1]

	end

end
