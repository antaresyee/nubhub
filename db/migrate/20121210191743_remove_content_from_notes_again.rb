class RemoveContentFromNotesAgain < ActiveRecord::Migration
  def up
  	remove_column :notes, :content
  end

  def down
  end
end
