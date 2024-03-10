defmodule ExMon.Actions do
  alias ExMon.{Attack, Game, Heal}

  def fetch_move(move) do
    Game.player()
    |> Map.get(:moves)
    |> find(move)
  end

  defp find(moves, move) do
    Enum.find_value(moves, {:error, move}, fn {key, value} ->
      if value == move, do: {:ok, key}
    end)
  end

  def attack(move) do
    case Game.turn() do
      :player -> Attack.execute(:computer, move)
      :computer -> Attack.execute(:player, move)
    end
  end

  def cure do
    case Game.turn() do
      :player -> Heal.execute(:computer)
      :computer -> Heal.execute(:player)
    end
  end
end
