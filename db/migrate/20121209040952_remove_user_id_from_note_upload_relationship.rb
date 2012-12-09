class RemoveUserIdFromNoteUploadRelationship < ActiveRecord::Migration
  def change
  	remove_column 	:note_upload_relationships, :user_id
  	add_column 		:note_upload_relationships, :note_id, :integer	
  end
end
