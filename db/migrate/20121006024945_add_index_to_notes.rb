class AddIndexToNotes < ActiveRecord::Migration
  def change
  	add_index :notes, [:class_num, :content, :department]
  end
end
