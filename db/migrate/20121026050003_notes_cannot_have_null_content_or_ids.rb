class NotesCannotHaveNullContentOrIds < ActiveRecord::Migration
  def up
  	remove_column :notes, :content
  	remove_column :notes, :user_id
  end

  def down
  end
end
