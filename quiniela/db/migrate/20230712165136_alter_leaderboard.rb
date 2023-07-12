class AlterLeaderboard < ActiveRecord::Migration[7.0]
  def change
    add_column :leaderboards, :player_id, :integer
  end
end
