class AddIndexToUploadedBy < ActiveRecord::Migration
  def change
  	add_index :uploaded_bies, :user_email
  end
end
