class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :random_track

  def random_track
    offset = rand(Track.count)-1
    # Rails 3
    @track = Track.first(offset)

    puts "TEST: " + @track.to_s
    puts "offset: " + Track.count.to_s
  end
end
