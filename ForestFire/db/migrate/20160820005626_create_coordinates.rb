class CreateCoordinates < ActiveRecord::Migration
  def change
    create_table :coordinates do |t|
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
