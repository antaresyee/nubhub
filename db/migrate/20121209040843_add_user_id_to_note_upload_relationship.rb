class AddUserIdToNoteUploadRelationship < ActiveRecord::Migration
  def change
    add_column :note_upload_relationships, :user_id, :integer
  end
end
