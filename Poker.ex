defmodule Poker do

	def find_n_OfKind(list,num) do
		aceKingFn = fn
			e1 when e1==0 or e1==1 -> e1+13
			e1->e1
		end
		
		list
		|> Enum.map(aceKingFn)
		|> Enum.reduce(%{}, fn x, acc -> Map.update(acc, x, 1, &(&1 + 1)) end)
		|> Enum.find(fn {key, val} -> val == num  end) |> elem(0)

	end


	def tie_fourOfKind(hand1, hand2) do
		bhand1 = Enum.map(hand1, fn(n) -> rem(n,13) end)
		bhand2 = Enum.map(hand2, fn(n) -> rem(n,13) end)
		find_n_OfKind(bhand1, 4) > find_n_OfKind(bhand2, 4)&& hand1 || find_n_OfKind(bhand1, 4) < find_n_OfKind(bhand2, 4)&& hand2
	end

	def tie_threeOfKind(hand1, hand2) do
                bhand1 = Enum.map(hand1, fn(n) -> rem(n,13) end)
                bhand2 = Enum.map(hand2, fn(n) -> rem(n,13) end)
                find_n_OfKind(bhand1, 3) > find_n_OfKind(bhand2, 3)&& hand1 || find_n_OfKind(bhand1, 3) < find_n_OfKind(bhand2, 3)&& hand2
        end

end
