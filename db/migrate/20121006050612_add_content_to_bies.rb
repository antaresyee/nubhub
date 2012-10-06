class AddContentToBies < ActiveRecord::Migration
  def change
  	add_column :uploaded_bies, :content, :string
  	add_column :downloaded_bies, :content, :string
  end
end
