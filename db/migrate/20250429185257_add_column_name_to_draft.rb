class AddColumnNameToDraft < ActiveRecord::Migration[8.0]
  def change
    add_column :drafts, :name, :string
  end
end
