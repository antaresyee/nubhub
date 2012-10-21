class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :department
      t.integer :class_num
      t.integer :nid
      t.string :content
      t.integer :number_downloads

      t.timestamps
    end
  end
end
