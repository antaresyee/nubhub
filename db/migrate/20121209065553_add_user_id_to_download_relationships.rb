class AddUserIdToDownloadRelationships < ActiveRecord::Migration
  def change
    add_column :download_relationships, :user_id, :integer
  end
end
