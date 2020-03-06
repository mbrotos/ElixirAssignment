list = [1, 2, 3, 4, 5]

list 
|> Stream.with_index 
|> Enum.reduce([[], []], fn ({x, i}, [evens, odds]) ->
  case rem(i, 2) do
    0 -> [evens ++ [x], odds]
    _ -> [evens, odds ++ [x]]
  end
end)
|> IO.inspect 