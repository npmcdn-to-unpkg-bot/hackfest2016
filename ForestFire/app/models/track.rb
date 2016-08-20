class Track < ActiveRecord::Base
  has_many :coordinates, :dependent => :delete_all
  accepts_nested_attributes_for :coordinates

    def self.loadXml 
        doc = Nokogiri::XML(File.open("WCC_Tracks.kml")) 
        doc.css("Placemark").map do |placemark|
            puts placemark 
            parseTrack(placemark) 
        end 
    end 

    def self.parseTrack(xml)
        track = self.create!({
            name: xml.css("SimpleData[name=\"name_1\"]").first.text, 
            length: xml.css("SimpleData [name=\"Shape_Length\"]").first
        })

        parse_cord(xml.css("LineString coordinates").first).each do |cordinate|
            track.coordinates.create!(cordinate)
        end
    end

    def self.parse_cord(xml)
        xml.text.split(" ").map do |cordinate|
            cord = cordinate.split(",")
            {latitude: cord.first, longitude: cord.second}
        end

    end

	def load_xml

		@doc = Nokogiri::XML(File.open("app/assets/WCC_Tracks.kml"))

		@doc.css('Placemark').each do |placemark|

  			# data = placemark.css('SimpleData')
  			coords = placemark.at_css('coordinates')

  			if coords

  				coords.text.split(' ').each do |coord|
  					(lon, lat) = coord.split(',')
  					print "#{lat}, #{lon}"
  				end
  				puts "\n"
  			end
  		end
	end
end
