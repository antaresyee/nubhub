class ChangeFilenameToFile < ActiveRecord::Migration
  def up
  	rename_column :notes, :filename, :file
  end

  def down
  end
end
