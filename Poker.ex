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
        Enum.all?(hand, &(&1 in 40..52)) &&
        true
    end

    def is_straight(hand) do
		hand_rem = Enum.sort(baseHand(hand))
		hand_rem==[0,1,10,11,12] ||
		hand_rem
		|> Enum.chunk_every(2, 1, :discard)
		|> Enum.map(fn [x, y] -> y - x end)==[1,1,1,1] &&
        true
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

    def normalizeHand(hand) do
        aceKingFn = fn
			e1 when e1==0 or e1==1 -> e1+13
			e1->e1
		end
        Enum.map(hand, aceKingFn)
    end

    def tie_highcard(hand1, hand2) do
        h1Base = baseHand(hand1)
        h2Base = baseHand(hand2)
        h1Base = Enum.sort_by(normalizeHand(h1Base), &(&1), :desc)
        h2Base = Enum.sort_by(normalizeHand(h2Base), &(&1), :desc)

        ((h1Base > h2Base) && hand1)    ||
        ((h2Base > h1Base) && hand2)    ||
        ((hand1 > hand2) && hand1)      ||
        hand2 

    end

    def find_n_OfKind(list,num) do	
		normalizeHand(list)
		|> Enum.reduce(%{}, fn x, acc -> Map.update(acc, x, 1, &(&1 + 1)) end)
		|> Enum.find(fn {_, val} -> val == num  end) |> elem(0)

	end

	def tie_fourOfKind(hand1, hand2) do
		bhand1 = baseHand(hand1)
		bhand2 = baseHand(hand2)
		find_n_OfKind(bhand1, 4) > find_n_OfKind(bhand2, 4) && hand1 || 
        find_n_OfKind(bhand1, 4) < find_n_OfKind(bhand2, 4) && hand2
	end

	def tie_threeOfKind(hand1, hand2) do
        bhand1 = baseHand(hand1)
        bhand2 = baseHand(hand2)
        find_n_OfKind(bhand1, 3) > find_n_OfKind(bhand2, 3) && hand1 || 
        find_n_OfKind(bhand1, 3) < find_n_OfKind(bhand2, 3) && hand2
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

    def tieBreak(hand1, hand2, type) do
        case type do
            x when x in [0,4,5,8,9] -> tie_highcard(hand1, hand2)
            #pair 1 -> 
            #twopair 2 -> 
            3 -> tie_threeOfKind(hand1, hand2)
            6 -> tie_highcard(hand1, hand2) #idk if this works
            7 -> tie_fourOfKind(hand1, hand2)
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
        handOne = hd(hands)
        handTwo = hd(tl(hands))
        handOneType = getType(handOne)
        handTwoType = getType(handTwo)
        #IO.puts(handOneType) #debug
        #IO.puts(handTwoType) #debug
        ((handOneType > handTwoType) && output(handOne) )   ||
        ((handTwoType > handOneType) && output(handTwo))    ||
        tieBreak(handOne, handTwo, handOneType) |> output
    end

    def output(hand) do
        remString = &(to_string(rem(&1,13)))
        eachFunc = fn 
            el when el in 1..13 -> to_string(el) <> "C"
            el when el in 14..26 -> remString.(el) <> "D"
            el when el in 27..39 -> remString.(el) <> "H"
            el when el in 40..52 -> remString.(el) <> "S"
            _ -> :error
        end
        kingFn = fn
			e1 when e1==0 -> e1+13
			e1->e1
		end
        hand 
        |> Stream.map(eachFunc) 
        |> Stream.map(kingFn) 
        |> Enum.to_list
        |> Enum.sort
    end
end