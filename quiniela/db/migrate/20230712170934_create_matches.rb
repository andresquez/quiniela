class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.date :date_played
      t.integer :team1_id
      t.integer :team2_id
      t.integer :goals1
      t.integer :goals2
      t.timestamps
    end
  end
end
