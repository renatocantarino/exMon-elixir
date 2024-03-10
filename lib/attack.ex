defmodule ExMon.Attack do
  alias ExMon.{Game, Status}
  @move_avg_pwr 18..25
  @move_rnd_pwr 10..35

  def execute(opponent, move) do
    damage = calcule_damage(move)

    opponent
    |> Game.get_current_player()
    |> Map.get(:life)
    |> calculate_life(damage)
    |> update_life(opponent, damage)
  end

  defp calculate_life(life, damage) when life - damage < 0, do: 0
  defp calculate_life(life, damage), do: life - damage

  defp calcule_damage(:move_avg), do: Enum.random(@move_avg_pwr)
  defp calcule_damage(:move_rnd), do: Enum.random(@move_rnd_pwr)

  defp update_life(life, opponent, damage) do
    opponent
    |> Game.get_current_player()
    |> Map.put(:life, life)
    |> update_game(opponent, damage)
  end

  defp update_game(player, opponent, damage) do
    Game.info()
    |> Map.put(opponent, player)
    |> Game.update()

    Status.print_move_message(opponent, :attack, damage)
  end
end
