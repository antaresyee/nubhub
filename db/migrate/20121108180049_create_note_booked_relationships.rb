class CreateNoteBookedRelationships < ActiveRecord::Migration
  def change
    create_table :note_booked_relationships do |t|

      t.timestamps
    end
  end
end
