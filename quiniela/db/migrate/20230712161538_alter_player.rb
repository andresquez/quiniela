class AlterPlayer < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :status, :string
  end
end
