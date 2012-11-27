class AddContentAndUserIdToNotesAgain < ActiveRecord::Migration
  def change
  	add_column :notes, :content, :string, default: "", null: false
  	add_column :notes, :user_id, :integer, default: -1, null: false
  end
end
