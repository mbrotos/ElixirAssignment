#unit tests  {cards, winningHand}
games = [
    {[1,2,3,4,5,6,7,8,9,10], 1}, #flush tie break
    {[40,1,38,12,48,35,43,30,15,28], 1}, #high card tie decided by suit
    {[40,1,38,12,48,35,43,30,15,29], 2}, #high card tie break
    {[1,2,14,30,27,45,40,10,13,52], 1}, #four of a kind vs high card
    {[2,15,3,16,4,17,5,18,1,19], 2}, #straight flush vs 
    {[1, 27, 14, 40, 52, 6, 45, 8, 29, 10], 1},
    {[1, 27, 40, 14, 52, 3, 45, 32, 29, 26],1},
    {[27, 12, 39, 13, 37, 1, 38, 10, 36, 11],1},
    {[31, 37, 45, 51, 17, 23, 3, 9, 28, 34], 2},
    {[29, 27, 43, 13, 15, 38, 1, 24, 18, 49],2}

]

testFunc = fn({intList,winnerInt}) ->
    IO.puts(Tester.dealTest(intList, winnerInt))
    IO.inspect Poker.deal(intList), charlists: :as_lists
end
Enum.each(games, testFunc)