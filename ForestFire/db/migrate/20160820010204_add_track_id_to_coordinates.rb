class AddTrackIdToCoordinates < ActiveRecord::Migration
  def change
    add_column :coordinates, :track_id, :integer
  end
end
