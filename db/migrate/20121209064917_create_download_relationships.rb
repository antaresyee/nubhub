class CreateDownloadRelationships < ActiveRecord::Migration
  def change
    create_table :download_relationships do |t|

      t.timestamps
    end
  end
end
