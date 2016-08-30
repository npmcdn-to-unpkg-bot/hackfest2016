class Coordinate < ActiveRecord::Base
  belongs_to :track, dependent: :destroy
end
