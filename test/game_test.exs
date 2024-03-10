defmodule ExMon.GameTest do
  alias ExMon.Game
  alias ExMon.Player
  use ExUnit.Case

  describe "start/2" do
    test "start de state game" do
      one = Player.create("one", :chute, :soco, :cura)
      robot = Player.create("robot", :chute, :soco, :cura)

      assert {:ok, _AgentId} = Game.start(one, robot)
    end
  end

  describe "info/0" do
    test "returns the current game status" do
      player = Player.create("one", :chute, :soco, :cura)
      computer = Player.create("Robotnik", :chute, :soco, :cura)
      Game.start(player, computer)

      expected_response =
        %{
          computer: %Player{
            life: 100,
            moves: %{move_avg: :soco, move_cure: :cura, move_rnd: :chute},
            name: "Robotnik"
          },
          player: %Player{
            life: 100,
            moves: %{move_avg: :soco, move_cure: :cura, move_rnd: :chute},
            name: "one"
          },
          status: :started,
          turn: :player
        }

      assert Game.info() == expected_response
    end
  end

  describe "update/1" do
    test "returns the updated game state" do
      player = Player.create("one", :chute, :soco, :cura)
      computer = Player.create("Robotnik", :chute, :soco, :cura)
      Game.start(player, computer)

      expected_response =
        %{
          computer: %Player{
            life: 100,
            moves: %{move_avg: :soco, move_cure: :cura, move_rnd: :chute},
            name: "Robotnik"
          },
          player: %Player{
            life: 100,
            moves: %{move_avg: :soco, move_cure: :cura, move_rnd: :chute},
            name: "one"
          },
          status: :started,
          turn: :player
        }

      assert Game.info() == expected_response

      new_state =
        %{
          computer: %Player{
            life: 89,
            moves: %{move_avg: :soco, move_cure: :cura, move_rnd: :chute},
            name: "one"
          },
          player: %Player{
            life: 72,
            moves: %{move_avg: :soco, move_cure: :cura, move_rnd: :chute},
            name: "Robotnik"
          },
          status: :started,
          turn: :player
        }

      Game.update(new_state)

      expected_response = %{new_state | turn: :computer, status: :continue}

      assert Game.info() == expected_response
    end
  end
end
