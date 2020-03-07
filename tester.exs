#unit tests  {cards, winningHand}
games = [
    {[1,2,3,4,5,6,7,8,9,10], 1},
    {[40,1,38,12,48,35,43,30,15,28], 1},
    {[40,1,38,12,48,35,43,30,15,29], 2}
]

testFunc = fn({intList,winnerInt}) ->
    IO.puts(Tester.dealTest(intList, winnerInt))
    IO.inspect Poker.deal(intList), charlists: :as_lists
end
Enum.each(games, testFunc)