class AlterPlayer2 < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :role_id, :integer
  end
end
