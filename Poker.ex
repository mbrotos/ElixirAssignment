defmodule Poker do
    @moduledoc """
    A poker game module implementing hand checking, tie breaking, and outputting.
    """

    @doc """
    Takes the remainder when divided by 13 for each element of a list.

    ## Parameters

        - hand: List representing a poker hand.

    """
    @spec baseHand(List.t()) :: List.t()
    def baseHand(hand) do
        Enum.map(hand, &(rem(&1,13))) 
    end

    @doc """
    Checks if a hand is a flush.

    ## Parameters

        - hand: List representing a poker hand.

    """
    @spec is_flush(List.t()) :: Boolean.t()
    def is_flush(hand) do 
        Enum.all?(hand, &(&1 in 1..13))  ||
        Enum.all?(hand, &(&1 in 14..26)) ||
        Enum.all?(hand, &(&1 in 27..39)) ||
        Enum.all?(hand, &(&1 in 40..52)) &&
        true
    end

    @doc """
    Checks if a hand is a straight.

    ## Parameters

        - hand: List representing a poker hand.

    """
    @spec is_straight(List.t()) :: Boolean.t()
    def is_straight(hand) do
        kingNorm = fn 
            el when el == 0 -> 13
            el -> el
        end
		hand_rem = Enum.sort(baseHand(hand))
		hand_rem==[0,1,10,11,12] ||
		hand_rem
        |> Enum.map(kingNorm)
        |> Enum.sort()
		|> Enum.chunk_every(2, 1, :discard)
		|> Enum.map(fn [x, y] -> y - x end)==[1,1,1,1] &&
        true
	end

    @doc """
    Checks if a hand is a three of a kind.

    ## Parameters

        - hand: List representing a poker hand.

    """
    @spec is_threeOfKind(List.t()) :: Boolean.t()
    def is_threeOfKind(hand) do
        bHand = baseHand(hand)
        uniqHand = Enum.uniq(bHand)
        (length(uniqHand) == 3) &&
        Enum.any?(uniqHand, fn(s) -> Enum.count(bHand, &(&1==s)) == 3 end)
    end

    @doc """
    Checks if a hand is a two pair.

    ## Parameters

        - hand: List representing a poker hand.

    """
    @spec is_twoPair(List.t()) :: Boolean.t()
    def is_twoPair(hand) do
        bHand = baseHand(hand)
        length(Enum.uniq(bHand)) == 3
    end

    @doc """
    Checks if a hand is a pair.

    ## Parameters

        - hand: List representing a poker hand.

    """
    @spec is_pair(List.t()) :: Boolean.t()
    def is_pair(hand) do
        bHand = baseHand(hand)
        length(Enum.uniq(bHand)) == 4
    end

    @doc """
    Checks if a hand is a royal flush.

    ## Parameters

        - hand: List representing a poker hand.

    """
    @spec is_royalFlush(List.t()) :: Boolean.t()
    def is_royalFlush(hand) do
        is_flush(hand) &&
        is_straight(hand) &&
        baseHand(hand) == [0,1,10,11,12]
    end

    @doc """
    Checks if a hand is a striaght flush.

    ## Parameters

        - hand: List representing a poker hand.

    """
    @spec is_straightFlush(List.t()) :: Boolean.t()
    def is_straightFlush(hand) do
        is_flush(hand) &&
        is_straight(hand)
    end

    @doc """
    Checks if a hand is a four of a kind.

    ## Parameters

        - hand: List representing a poker hand.

    """
    @spec is_fourOfKind(List.t()) :: Boolean.t()
    def is_fourOfKind(hand) do
        bHand = baseHand(hand)
        uniqHand = Enum.uniq(bHand)
        (length(uniqHand) == 2) &&
        Enum.any?(uniqHand, fn(s) -> Enum.count(bHand, &(&1==s)) == 4 end)
    end

    @doc """
    Checks if a hand is a full house.

    ## Parameters

        - hand: List representing a poker hand.

    """
    @spec is_fullHouse(List.t()) :: Boolean.t()
    def is_fullHouse(hand) do
        bHand = baseHand(hand)
        uniqHand = Enum.uniq(bHand)
        (length(uniqHand) == 2) &&
        Enum.any?(uniqHand, fn(s) -> Enum.count(bHand, &(&1==s)) == 3 end)
    end

    @doc """
    Adds 13 to each element of 1 or 0 in a list helping to evaluate highcards.

    ## Parameters

        - hand: List representing a poker hand.

    """
    @spec normalizeHand(List.t()) :: List.t()
    def normalizeHand(hand) do
        aceKingFn = fn
			e1 when e1==0 or e1==1 -> e1+13
			e1->e1
		end
        Enum.map(hand, aceKingFn)
    end

    @doc """
    Sorts a list in descending order helping to evaluate highcards and suits.

    ## Parameters

        - hand: List representing a poker hand.

    """
    @spec sortDesc(List.t()) :: List.t()
    def sortDesc(hand) do
        Enum.sort_by(hand, &(&1), :desc)
    end

    @doc """
    Finds the hand with the highest card value or suit.

    ## Parameters

        - hand1: List representing player one's poker hand.
        - hand2: List representing player two's poker hand.

    """
    @spec tie_highcard(List.t(), List.t()) :: List.t()
    def tie_highcard(hand1, hand2) do
        h1Base = baseHand(hand1)
        h2Base = baseHand(hand2)
        h1Base = sortDesc(normalizeHand(h1Base))
        h2Base = sortDesc(normalizeHand(h2Base))

        ((h1Base > h2Base) && hand1)    
        || ((h2Base > h1Base) && hand2)    
        || ((sortDesc(hand1) > sortDesc(hand2)) && hand1)      
        || hand2 

    end

    @doc """
    Extracts the duplicate elements of a list.

    ## Parameters

        - hand: List representing a poker hand.

    """
    @spec getPairList(List.t()) :: List.t()
    def getPairList(hand) do
        hand
        |> Enum.group_by(&(&1))
        |> Enum.filter(fn {_, [_,_|_]} -> true; _ -> false end)
        |> Enum.map(fn {x, _} -> x end)
        |> sortDesc
    end

    @doc """
    Tie brakes two one pair type hands.

    ## Parameters

        - hand1: List representing player one's poker hand.
        - hand2: List representing player two's poker hand.

    """
    @spec tie_pair(List.t(), List.t()) :: List.t()
    def tie_pair(hand1, hand2) do 
        h1Base = baseHand(hand1)
        h2Base = baseHand(hand2)
        pairList1 = Enum.sort_by(normalizeHand(h1Base), &(&1), :desc) |> getPairList
        pairList2 = Enum.sort_by(normalizeHand(h2Base), &(&1), :desc) |> getPairList
        #IO.inspect pairList1, charlists: :as_lists
        #IO.inspect pairList2, charlists: :as_lists
        ((pairList1 > pairList2) && hand1) 
        || ((pairList2 > pairList1) && hand2)
        || tie_highcard(hand1,hand2)
    end

    #add doc
    def find_n_OfKind(list,num) do	
		normalizeHand(list)
		|> Enum.reduce(%{}, fn x, acc -> Map.update(acc, x, 1, &(&1 + 1)) end)
		|> Enum.find(fn {_, val} -> val == num  end) |> elem(0)
	end

    @doc """
    Tie brakes two four of a kind type hands.

    ## Parameters

        - hand1: List representing player one's poker hand.
        - hand2: List representing player two's poker hand.

    """
    @spec tie_fourOfKind(List.t(), List.t()) :: List.t()
	def tie_fourOfKind(hand1, hand2) do
		bhand1 = baseHand(hand1)
		bhand2 = baseHand(hand2)
		find_n_OfKind(bhand1, 4) > find_n_OfKind(bhand2, 4) && hand1 || 
        find_n_OfKind(bhand1, 4) < find_n_OfKind(bhand2, 4) && hand2
	end

    @doc """
    Tie brakes two three of a kind type hands.

    ## Parameters

        - hand1: List representing player one's poker hand.
        - hand2: List representing player two's poker hand.

    """
    @spec tie_threeOfKind(List.t(), List.t()) :: List.t()
	def tie_threeOfKind(hand1, hand2) do
        bhand1 = baseHand(hand1)
        bhand2 = baseHand(hand2)
        find_n_OfKind(bhand1, 3) > find_n_OfKind(bhand2, 3) && hand1 || 
        find_n_OfKind(bhand1, 3) < find_n_OfKind(bhand2, 3) && hand2
    end

    @doc """
    Tie brakes two straight type hands.

    ## Parameters

        - hand1: List representing player one's poker hand.
        - hand2: List representing player two's poker hand.

    """
    @spec tie_straight(List.t(), List.t()) :: List.t()
    def tie_straight(hand1, hand2) do
        bDescHand1 = baseHand(sortDesc(hand1))
        bDescHand2 = baseHand(sortDesc(hand2))
        baseCase = [5,4,3,2,1]
        ((bDescHand1 != baseCase) && (bDescHand2 != baseCase)) && tie_highcard(hand1, hand2)
        || ((bDescHand1 > bDescHand2) && hand1)    
        || ((bDescHand2 > bDescHand1) && hand2)    
        || ((sortDesc(hand1) > sortDesc(hand2)) && hand1)      
        || hand2 
    end

    @doc """
    Uses hand checking functions to return the highest type.

    ## Parameters

        - hand: List representing a poker hand.

    """
    @spec getType(List.t()) :: Integer.t()
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

    @doc """
    Uses tie breaking functions to return winning hand

    ## Parameters

        - hand1: List representing player one's poker hand.
        - hand2: List representing player two's poker hand.
        - type: Integer representing the type of hand in common.

    """
    @spec tieBreak(List.t(), List.t(), Integer.t()) :: List.t()
    def tieBreak(hand1, hand2, type) do
        case type do
            x when x in [0,5] -> tie_highcard(hand1, hand2)
            x when x in [1,2] -> tie_pair(hand1, hand2) 
            x when x in [3,6] -> tie_threeOfKind(hand1, hand2)
            x when x in [4,8] -> tie_straight(hand1, hand2)
            7 -> tie_fourOfKind(hand1, hand2)
            9 -> ((sortDesc(hand1) > sortDesc(hand2)) && hand1) || hand2  #suit tie break
        end
    end

    @doc """
    Returns the properly formatted winning poker hand.

    ## Parameters

        - hand: List representing the winning poker hand.

    """
    @spec output(List.t()) :: List.t()
    def output(hand) do
        remString = fn 
            el when rem(el,13) == 0 -> to_string(13)
            el -> to_string(rem(el,13))
        end
        suitFunc = fn 
            el when el in 1..13 -> to_string(el) <> "C"
            el when el in 14..26 -> remString.(el) <> "D"
            el when el in 27..39 -> remString.(el) <> "H"
            el when el in 40..52 -> remString.(el) <> "S"
            _ -> :error
        end
        sortFunc = fn 
            el when rem(el,13) == 0 -> 13
            el -> rem(el,13)
        end
        Enum.sort(hand)
        |> Enum.sort_by(sortFunc)
        |> Enum.map(suitFunc)  
    end

    @doc """
    Deals cards based on input and sends winning hand to output function.

    ## Parameters

        - intList: List of 10 unique integers from 1-52 representing two poker hands.

    """
    @spec deal(List.t()) :: List.t()
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
        #IO.puts(handOneType)
        #IO.puts(handTwoType)
        #IO.inspect handOne, charlists: :as_lists
        #IO.inspect handTwo, charlists: :as_lists
        ((handOneType > handTwoType) && output(handOne))   ||
        ((handTwoType > handOneType) && output(handTwo))    ||
        tieBreak(handOne, handTwo, handOneType) |> output
    end  
end