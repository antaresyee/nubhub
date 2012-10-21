class AddIndexToDownloadedBy < ActiveRecord::Migration
  def change
  	add_index :downloaded_bies, :user_email
  end
end
