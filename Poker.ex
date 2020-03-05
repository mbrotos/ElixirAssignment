defmodule Poker do

        def deal_hand_1([], res) do IO.inspect res, charlists: :as_lists end
        def deal_hand_1(card_list) when length(card_list)==10  do deal_hand_1(card_list, []) end
        def deal_hand_1(card_list, hand) do
                if rem(length(card_list), 2)==0 do
                        hand=hand++[hd(card_list)]                
                        deal_hand_1(tl(card_list), hand)
                else 
                        deal_hand_1(tl(card_list), hand)
                end
        end
        def deal_hand_1(_) do :error end

        def deal_hand_2([], res) do res end
        def deal_hand_2(card_list) when length(card_list)==10  do deal_hand_2(card_list, []) end
        def deal_hand_2(card_list, hand) do
                if rem(length(card_list), 2)==1 do
                        hand=hand++[hd(card_list)]
                        deal_hand_2(tl(card_list), hand)
                else
                        deal_hand_2(tl(card_list), hand)
                end
        end
        def deal_hand_2(_) do :error end

        def num_ocurrences(list) do
                new_list = list |> Enum.reduce(%{}, fn x, acc -> Map.update(acc, x, 1, &(&1 + 1)) end)
                new_list
        end
end
