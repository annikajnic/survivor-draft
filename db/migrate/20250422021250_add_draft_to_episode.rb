class AddDraftToEpisode < ActiveRecord::Migration[8.0]
  def change
    add_column :episodes, :draft_id, :uuid
  end
end
