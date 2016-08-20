class Track < ActiveRecord::Base
  has_many :coordinates, :dependent => :delete_all
  accepts_nested_attributes_for :coordinates
end
