
module PlayersHelper
    def leaderboard_position(player)
      leaderboard = Leaderboard.order(points: :desc)
      position = leaderboard.index { |entry| entry.player_id == player.id }
      position ? position + 1 : 'N/A' # Retorna la posición o 'N/A' si el jugador no está en la leaderboard.
    end
  end
  