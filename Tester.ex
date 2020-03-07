defmodule Tester do
    def dealTest(intList, winner) do
        listWithIndexS = Stream.with_index(intList)
        hands = listWithIndexS
        |> Enum.reduce([[], []], fn ({x, i}, [evens, odds]) ->
            case rem(i, 2) do
                0 -> [evens ++ [x], odds]
                _ -> [evens, odds ++ [x]]
            end
        end)
        winner = case winner do
            1 -> hd(hands)
            2 -> hd(tl(hands))
        end
        Poker.deal(intList) == Poker.output(winner)
    end  
end