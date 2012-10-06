class CreateUploadedBies < ActiveRecord::Migration
  def change
    create_table :uploaded_bies do |t|
      t.string :user_email
      t.integer :note_id

      t.timestamps
    end
  end
end
