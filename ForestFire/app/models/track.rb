class Track < ActiveRecord::Base
  has_many :coordinates, :dependent => :delete_all
  accepts_nested_attributes_for :coordinates

    def self.loadXml 
        doc = Nokogiri::XML(File.open("WCC_Tracks.kml")) 
        doc.css("Placemark").map do |placemark|
            parseTrack(placemark) 
        end 
    end 

    def self.parseTrack(xml)
        track = self.create!({
            name: xml.css("SimpleData[name=\"name_1\"]").first.text, 
            length: xml.css("SimpleData[name=\"Shape_Length\"]").first.text,
            comment: xml.css("SimpleData[name=\"comments\"]").first.text
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
    def estimated_time()
        return ((self.length.to_f.round(1)/5000))*60
    end

	
end
