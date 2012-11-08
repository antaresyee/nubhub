class AddFieldsToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :cid, :integer
    add_column :courses, :year, :integer
    add_column :courses, :term, :string
    add_column :courses, :department, :string
    add_column :courses, :number, :integer
    add_column :courses, :name, :string

    add_index :courses, :cid
  end
end
