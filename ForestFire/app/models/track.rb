class Track < ActiveRecord::Base

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