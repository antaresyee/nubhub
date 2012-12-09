class AddCourseIdToNoteUploadRelationship < ActiveRecord::Migration
  def change
    add_column :note_upload_relationships, :course_id, :integer
  end
end
