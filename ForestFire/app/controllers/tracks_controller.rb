class TracksController < ApplicationController
  before_filter :random_track
  def index

  end

  private
  def random_track
    offset = rand(Track.count)
    @track = Track.offset(offset).first #get random track
    @estimated_time = (Track.length / 5.0)
  end
end
