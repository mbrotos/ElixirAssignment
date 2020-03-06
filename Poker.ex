defmodule Poker do
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