#unit tests
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

games = [
    {[1,2,3,4,5,6,7,8,9,10], 1},
    {[40,1,38,12,48,35,43,30,15,28], 1},
    {[40,1,38,12,48,35,43,30,15,29], 2}
]

testFunc = fn({intList,winnerInt}) ->
    IO.puts(Tester.dealTest(intList, winnerInt))
end
Enum.each(games, testFunc)