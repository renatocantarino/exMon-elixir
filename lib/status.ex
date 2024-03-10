defmodule ExMon.Status do
  def get_status(%{status: :started} = info) do
    IO.puts("The game is started")
    IO.inspect(info)
    IO.puts("------------------------------------")
  end

  def get_status(%{status: :game_over} = info) do
    IO.puts("The game is over")
    IO.inspect(info)
    IO.puts("------------------------------------")
  end

  def get_status(%{status: :continue, turn: player} = info) do
    IO.puts("------------------------------------")
    IO.puts(" #{player} turns")
    IO.puts("------------------------------------")
    IO.inspect(info)
    IO.puts("------------------------------------")
  end

  def print_wrong_move(move) do
    IO.puts("Invalid move: #{move}")
  end

  def print_move_message(:computer, :attack, damage) do
    IO.puts("user attack pc. damage: #{damage}")
  end

  def print_move_message(:player, :attack, damage) do
    IO.puts("pc attack user. damage: #{damage}")
  end

  def print_move_message(player, :cure, life) do
    IO.puts("#{player} apply cure in itself #{life}")
  end
end
