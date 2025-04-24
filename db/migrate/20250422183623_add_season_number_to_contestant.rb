class AddSeasonNumberToContestant < ActiveRecord::Migration[8.0]
  def change
    add_column :contestants, :season_number, :integer
  end
end
