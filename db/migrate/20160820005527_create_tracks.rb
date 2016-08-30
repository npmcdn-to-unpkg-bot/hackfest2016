class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :area_name
      t.string :name
      t.float :length

      t.timestamps null: false
    end
  end
end
