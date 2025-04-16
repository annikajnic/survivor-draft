class AddSeasonNumberToContestants < ActiveRecord::Migration[7.1]
  def change
    add_column :contestants, :season_number, :integer, null: false, default: 1
  end
end
