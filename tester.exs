#unit tests  {cards, winningHand}
games = [
    {[1,2,3,4,5,6,7,8,9,10], 1}, 
    {[40,1,38,12,48,35,43,30,15,28], 1},
    {[40,1,38,12,48,35,43,30,15,29], 2}, 
    {[1,2,14,30,27,45,40,10,13,52], 1}, 
    {[2,15,3,16,4,17,5,18,1,19], 2}, 
    {[1, 27, 14, 40, 52, 6, 45, 8, 29, 10], 1},
    {[1, 27, 40, 14, 52, 3, 45, 32, 29, 26], 1},
    {[27, 12, 39, 13, 37, 1, 38, 10, 36, 11], 1},
    {[31, 37, 45, 51, 17, 23, 3, 9, 28, 34], 2},
    {[29, 27, 43, 13, 15, 38, 1, 24, 18, 49], 2},
    {[24, 40, 22, 48, 44, 8, 27, 32, 6, 23], 1},
    {[24, 16, 43, 27, 50, 11, 17, 49, 19, 45], 1},
    {[28, 33, 34, 31, 52, 30, 3, 39, 17, 40], 2},
    {[13, 9, 42, 29, 52, 20, 48, 47, 16, 27], 1},
    {[25, 1, 15, 12, 7, 45, 17, 44, 35, 29], 2},
    {[39, 27, 12, 21, 19, 18, 11, 23, 13, 44], 1},
    {[16, 23, 1, 36, 45, 41, 22, 11, 32, 47], 2},
    {[36, 31, 22, 39, 23, 25, 30, 45, 46, 3], 1},
    {[29, 21, 19, 39, 24, 43, 10, 28, 1, 5], 1},
    {[35, 48, 6, 1, 31, 17, 21, 30, 40, 29], 2},
    {[43, 36, 27, 24, 1, 3, 9, 33, 4, 32], 1},
    {[32, 25, 38, 24, 34, 39, 44, 2, 31, 42], 1},
    {[24, 40, 22, 48, 44, 8, 27, 32, 6, 23], 1},
    {[32, 16, 31, 44, 40, 4, 28, 43, 8, 3], 2},
    {[27, 5, 1, 49, 37, 16, 17, 15, 24, 25], 1},
    {[16, 18, 17, 37, 11, 52, 38, 50, 49, 40], 2},
    {[47, 19, 41, 51, 18, 27, 32, 7, 11, 46], 2},
    {[51, 10, 7, 49, 43, 52, 9, 8, 24, 4], 2},
    {[4, 31, 34, 3, 49, 23, 13, 33, 25, 5], 2},
    {[33, 52, 46, 38, 15, 18, 16, 44, 50, 51], 2},
    {[33, 19, 22, 9, 7, 20, 17, 18, 16, 36], 1},
    {[50, 34, 47, 17, 35, 52, 19, 21, 49, 16], 2},
    {[33, 38, 26, 14, 27, 42, 3, 52, 34, 11], 2},
    {[1, 26, 23, 18, 45, 36, 8, 49, 13, 12], 2},
    {[1, 4, 18, 17, 29, 30, 45, 52, 50, 41], 2},
    {[1, 2, 18, 16, 29, 30, 45, 44, 50, 32], 2},
    {[1, 15, 31, 16, 29, 18, 45, 19, 50, 20], 2},
    {[1, 4, 18, 17, 29, 30, 45, 52, 50, 39], 2},
    {[1, 16, 31, 17, 29, 18, 45, 19, 50, 20], 2},
    {[1, 23, 18, 24, 29, 25, 45, 26, 50, 14], 2},
    {[1, 4, 18, 17, 31, 30, 45, 52, 50, 41], 2},
    {[1, 2, 18, 16, 31, 30, 45, 44, 50, 32], 2},
    {[1, 41, 18, 42, 31, 45, 45, 46, 50, 47], 2},
    {[1, 4, 18, 17, 31, 30, 45, 52, 50, 39], 2},
    {[1, 4, 18, 17, 31, 30, 45, 52, 50, 43], 2},
    {[1, 41, 18, 42, 31, 43, 45, 44, 50, 45], 2},
    {[1, 23, 18, 24, 31, 25, 45, 26, 50, 14], 2},
    {[1, 4, 18, 17, 31, 39, 45, 52, 32, 41], 2},
    {[1, 4, 18, 17, 31, 30, 45, 52, 32, 41], 2},
    {[1, 6, 18, 20, 31, 34, 45, 48, 32, 23], 2},
    {[1, 6, 18, 8, 31, 7, 45, 2, 32, 3], 2},
    {[1, 4, 18, 17, 31, 30, 45, 52, 32, 39], 2},
    {[1, 4, 18, 17, 31, 30, 45, 52, 32, 43], 2},
    {[1, 19, 18, 20, 31, 21, 45, 22, 32, 23], 2},
    {[1, 36, 18, 37, 31, 38, 45, 39, 32, 27], 2},
    {[5, 4, 18, 17, 31, 30, 45, 52, 21, 41], 1},
    {[5, 2, 18, 16, 31, 30, 45, 44, 21, 32], 2},
    {[49,2,50,3,51,24,52,25,40,26], 1},
    {[10,2,11,3,12,4,13,5,1,6],1},
    {[10,2,11,15,12,28,13,41,1,6],1},
    {[8,2,21,3,34,4,47,5,1,6],2},
    {[2,3,15,16,28,29,41,42,34,6],2},
    {[2,3,15,16,28,29,41,42,34,6],2},
    {[49,2,50,15,51,28,52,3,40,16], 1},
    {[49,2,50,15,51,28,52,3,48,16], 1},
    {[9,2,22,15,35,28,48,3,1,16], 1},
    {[9,2,22,15,35,28,10,3,23,16], 1},
    {[49,2,50,3,51,5,52,6,40,7], 1},
    {[10,2,11,3,12,4,13,5,9,7],1},
    {[5,2,18,3,31,4,44,5,9,7],1},
    {[23,2,36,3,49,4,39,52,7],1},
    {[10,2,11,16,12,4,13,5,1,6],1},
    {[10,2,11,16,12,4,13,5,9,6],1},
    {[13,2,26,16,39,4,52,5,9,6],1},
    {[13,2,26,16,39,4,36,5,49,6],1},
    {[10,2,11,16,1,4,13,5,9,6],1},
    {[49,2,50,15,51,28,52,25,40,26], 1},
    {[49,2,50,15,51,28,52,25,48,26], 1},
    {[9,2,22,15,35,28,1,25,48,26], 1},
    {[9,2,22,15,35,28,33,25,46,26], 1},
    {[9,2,22,15,35,28,33,25,46,26], 1},
]

testFunc = fn({intList,winnerInt}) ->
    res = Tester.dealTest(intList, winnerInt)
    IO.puts(Tester.dealTest(intList, winnerInt))
    res || IO.inspect Poker.deal(intList), charlists: :as_lists
end
Enum.each(games, testFunc)