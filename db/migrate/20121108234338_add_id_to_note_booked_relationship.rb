class AddIdToNoteBookedRelationship < ActiveRecord::Migration
  def change
    add_column :note_booked_relationships, :user_id, :integer
    add_column :note_booked_relationships, :course_id, :integer
  end
end
