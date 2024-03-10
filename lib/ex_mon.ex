defmodule ExMon do
  alias ExMon.{Actions, Game, Player, Status}

  @name_opponent "Robot"
  @alleatory_moves Enum.random([:move_rnd, :move_avg, :move_cure])

  def start_game(name, rnd, avg, cure) do
    player = Player.create(name, rnd, avg, cure)
    pc = Player.create(get_name_opponent(), rnd, avg, cure)
    Game.start(player, pc)
    Status.get_status(Game.info())
  end

  defp get_name_opponent do
    "#{@name_opponent}-#{UUID.uuid4()}"
  end

  def make_move(move) do
    Game.info()
    |> Map.get(:status)
    |> handle_status(move)
  end

  defp execute({:ok, move}) do
    case move do
      :move_cure -> Actions.cure()
      move -> Actions.attack(move)
    end

    Status.get_status(Game.info())
  end

  defp handle_status(:game_over, _move), do: Status.get_status(Game.info())

  defp handle_status(_other, move) do
    move
    |> Actions.fetch_move()
    |> execute()

    computer_move(Game.info())
  end

  defp execute({:error, move}), do: Status.print_wrong_move(move)

  defp computer_move(%{turn: :computer, status: :continue}) do
    move = {:ok, @alleatory_moves}
    execute(move)
  end

  defp computer_move(_), do: :ok
end
