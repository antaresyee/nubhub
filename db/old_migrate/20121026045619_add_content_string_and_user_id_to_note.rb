class AddContentStringAndUserIdToNote < ActiveRecord::Migration
  def change
  	add_column :notes, :content, :string
  	add_column :notes, :user_id, :integer
  end
end
