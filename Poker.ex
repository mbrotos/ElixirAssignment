defmodule Poker do
    def baseHand(hand) do
        Enum.map(hand, &(rem(&1,13))) 
    end




    def is_straight(hand) do

    end

    def is_fourOfKind(hand) do
        bHand = baseHand(hand) 
        length(Enum.uniq(bHand)) == 2
    end
    def is_flush(hand) do 
        Enum.all?(hand, &(&1 in 1..13))  ||
        Enum.all?(hand, &(&1 in 14..26)) ||
        Enum.all?(hand, &(&1 in 27..39)) ||
        Enum.all?(hand, &(&1 in 40..52)) 
    end
    def is_threeOfKind(hand) do
        bHand = baseHand(hand)
        uniqHand = Enum.uniq(bHand)
        (length(uniqHand) == 3) &&
        Enum.any?(uniqHand, fn(s) -> Enum.count(bHand, &(&1==s)) == 3 end)
    end
    def is_twoPair(hand) do
        bHand = baseHand(hand)
        length(Enum.uniq(bHand)) == 3
    end
    def is_pair(hand) do
        bHand = baseHand(hand)
        length(Enum.uniq(bHand)) == 4
    end
    def deal(intList) do
        handOne = []
        handTwo = []
        listWithIndexS = Stream.with_index(intList)
        listWithIndexS
        |> Enum.reduce([[], []], fn ({x, i}, [evens, odds]) ->
            case rem(i, 2) do
                0 -> [evens ++ [x], odds]
                _ -> [evens, odds ++ [x]]
            end
        end)
        |> IO.inspect 
    end

    def output(intList) do
        remString = &(to_string(rem(&1,13)))
        eachFunc = fn 
            el when el in 1..13 -> to_string(el) <> "C"
            el when el in 14..26 -> remString.(el) <> "D"
            el when el in 27..39 -> remString.(el) <> "H"
            el when el in 40..52 -> remString.(el) <> "S"
            _ -> :error
        end
        intList = Enum.map(intList, eachFunc)
        Enum.sort(intList)
    end
end