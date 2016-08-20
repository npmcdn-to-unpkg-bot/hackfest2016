class AddCoordConstraints < ActiveRecord::Migration
  def change
  	change_column :coordinates, :latitude, :float, null: false
  	change_column :coordinates, :longitude, :float, null: false
  end
end
