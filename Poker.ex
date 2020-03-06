defmodule Poker do

    def baseHand(hand) do
        Enum.map(hand, &(rem(&1,13))) 
    end

    def is_royalFlush(hand) do
        is_flush(hand) &&
        is_straight(hand) &&
        baseHand(hand) == [0,1,10,11,12]
    end

    def is_straightFlush(hand) do
        is_flush(hand) &&
        is_straight(hand)
    end

    def is_fourOfKind(hand) do
        bHand = baseHand(hand) 
        length(Enum.uniq(bHand)) == 2
    end

    def is_fullHouse(hand) do
        is_threeOfKind(hand) &&
        is_twoPair(hand)
    end

    def is_flush(hand) do 
        Enum.all?(hand, &(&1 in 1..13))  ||
        Enum.all?(hand, &(&1 in 14..26)) ||
        Enum.all?(hand, &(&1 in 27..39)) ||
        Enum.all?(hand, &(&1 in 40..52)) 
    end

    def is_straight(hand) do
		hand_rem = Enum.sort(Enum.map(hand, fn(n) -> rem(n,13) end))
		hand_rem==[0,1,10,11,12] ||
		hand_rem
		|> Enum.chunk_every(2, 1, :discard)
		|> Enum.map(fn [x, y] -> y - x end)==[1,1,1,1]
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

    def getType(hand) do 
        cond do
            is_royalFlush(hand) -> 9
            is_straightFlush(hand) -> 8
            is_fourOfKind(hand) -> 7
            is_fullHouse(hand) -> 6
            is_flush(hand) -> 5
            is_straight(hand) -> 4
            is_threeOfKind(hand) -> 3
            is_twoPair(hand) -> 2
            is_pair(hand) -> 1
            true -> 0
        end
    end

    def deal(intList) do
        listWithIndexS = Stream.with_index(intList)
        hands = listWithIndexS
        |> Enum.reduce([[], []], fn ({x, i}, [evens, odds]) ->
            case rem(i, 2) do
                0 -> [evens ++ [x], odds]
                _ -> [evens, odds ++ [x]]
            end
        end)
        handOne = Enum.sort(hd(hands))
        handTwo = Enum.sort(hd(tl(hands)))
        handOneType = getType(handOne)
        handTwoType = getType(handTwo)

        ((handOneType > handTwoType) && handOne) ||
        ((handTwoType > handOneType) && handTwo) ||
        tieBreak(handOne, handTwo, handOneType, handTwoType)

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