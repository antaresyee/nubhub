class CreateDownloadedBies < ActiveRecord::Migration
  def change
    create_table :downloaded_bies do |t|
      t.string :user_email
      t.integer :note_id

      t.timestamps
    end
  end
end
