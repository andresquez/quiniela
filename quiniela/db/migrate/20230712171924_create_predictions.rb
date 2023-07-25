class CreatePredictions < ActiveRecord::Migration[7.0]
  def change
    create_table :predictions do |t|
      t.integer :player_id
      t.integer :match_id
      t.integer :goals1
      t.integer :goals2
      t.integer :points_awarded
      t.timestamps
    end
  end
end
