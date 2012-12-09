class AddNoteIdToDownloadRelationships < ActiveRecord::Migration
  def change
    add_column :download_relationships, :note_id, :integer
  end
end
