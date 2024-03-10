defmodule ExMon.Player do
  @required_fields [:name, :moves, :life]
  @enforce_keys @required_fields

  defstruct @required_fields

  # const
  @max_life 100

  def create(name, move_rnd, move_avg, move_cure) do
    %ExMon.Player{
      life: @max_life,
      name: name,
      moves: %{
        move_avg: move_avg,
        move_cure: move_cure,
        move_rnd: move_rnd
      }
    }
  end
end
