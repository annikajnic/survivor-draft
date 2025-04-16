class AddTribeToContestants < ActiveRecord::Migration[7.1]
  def change
    add_column :contestants, :tribe, :string, null: false, default: "Unknown"
  end
end
