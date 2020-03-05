defmodule Poker do
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