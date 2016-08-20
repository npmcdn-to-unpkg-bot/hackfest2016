class AddTrackConstraints < ActiveRecord::Migration
  
  def change
  	change_column :tracks, :area_name, :string, null: false
  	change_column :tracks, :name, :string, null: false
  	change_column :tracks, :length, :float, null: false 
  end

  #execute <<-SQL
   #ALTER TABLE people ADD CONSTRAINT length CHECK (length > 0);
  #SQL

end
