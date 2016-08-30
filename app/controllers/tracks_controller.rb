class TracksController < ApplicationController
  require 'net/http'

  def index
    source = 'http://quandyfactory.com/insult/json'
    resp = Net::HTTP.get_response(URI.parse(source))
    data = resp.body
    @insult = ActiveSupport::JSON.decode(data)["insult"]
  end

  def create
    puts "COORDS: " + params[:coord].to_s
    # puts "COORDS: " + coords.to_s
    puts "TRACKS: " + random_track.to_s
    render text:"/tracks/#{random_track.id}"
  end

  def show
    @track = Track.find(params[:id])
    @button = ButtonText.all().sample
  end

  def sandbox
    @track = Track.find(params[:id])
    @button = ButtonText.all().sample
  end

  private
  def random_track
    xy = [-41.306481, 174.777290]
    puts "Val : " + params[:coord].to_s
    radius = 0.00001
    @track = Coordinate.where(["longitude < ? and latitude < ? and longitude < ? and latitude < ?",
    	xy[0]-radius, xy[1]-radius,xy[0]+radius, xy[1]+radius]).sample.track
    offset = rand(Track.count)
    @track = Track.offset(offset).first #get random track
   # @estimated_time = (Track.length / 5.0)
  end
end
