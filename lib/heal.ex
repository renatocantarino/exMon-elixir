defmodule ExMon.Heal do
  alias ExMon.{Game, Status}
  @increase_heal 18..25

  def execute(player) do
    player
    |> Game.get_current_player()
    |> Map.get(:life)
    |> calculate_life()
    |> handler(player)
  end

  defp calculate_life(life), do: life + Enum.random(@increase_heal)

  defp handler(life, player) when life >= 100, do: update_player(player, 100)
  defp handler(life, player), do: update_player(player, life)

  defp update_player(player, life) do
    player
    |> Game.get_current_player()
    |> Map.put(:life, life)
    |> update_game(player, life)
  end

  defp update_game(player_data, player, life) do
    Game.info()
    |> Map.put(player, player_data)
    |> Game.update()

    Status.print_move_message(player, :cure, life)
  end
end
