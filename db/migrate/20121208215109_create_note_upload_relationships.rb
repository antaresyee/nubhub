class CreateNoteUploadRelationships < ActiveRecord::Migration
  def change
    create_table :note_upload_relationships do |t|

      t.timestamps
    end
  end
end
