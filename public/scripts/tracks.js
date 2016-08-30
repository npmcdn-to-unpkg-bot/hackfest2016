function changeImage() {
	// XXX: lat and lon may be around the wrong way on the database.
	var url = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=6d26b3085b2ce2e5d8f6400c044792df&lat=" +
			<%= @track.coordinates[0].longitude.to_s %> + "&lon=" + <%= @track.coordinates[0].latitude.to_s %> + "&radius=0.2&format=json&nojsoncallback=1";
	$.getJSON(url,
		function(result) {

			// console.log(url);
			// console.log(result);
			// $("span.test").html(result.photos.photo[0].title);
			var photo1 = result.photos.photo[0];
			var image_url = "https:\/\/farm" + photo1.farm + ".staticflickr.com\/" + photo1.server + "\/" + photo1.id + "_" + photo1.secret + ".jpg";
			// image_url format
			// "https:\/\/farm9.staticflickr.com\/8102\/8475556512_beca454079.jpg"
			// Set that image shit maaaaaannn
			document.getElementById("chill").src = image_url;
		})
}

function nextTrack(){
		window.location.href = '/';
}
function toggleDetail(){
	$("#draggable").toggle();
	$("#like").toggle();
	$("#second").toggle();
}

$(document).ready(function(){

	changeImage();

	$( "#draggable" ).draggable({
		axis: "x",
		stop: function( event, ui ) {
	    console.log(ui.position.left);
			if (ui.position.left < -110){
				nextTrack();
			}
			else if (ui.position.left > 110) {
				toggleDetail();
			}
	  }
	});

	//pos = ;
	navigator.geolocation.getCurrentPosition(function(pos) { load(pos) }, function(error) {load()});
	function load(pos){
		var geo_lat = -41.306802;
		var geo_lng = 174.776874;
		if (pos) {
			geo_lat = (pos.coords.latitude = null) ? -41 : pos.coords.latitude;
			geo_lng = (pos.coords.longitude = null) ? 174 : pos.coords.longitude;
		}

		var coords = [
		<% @track.coordinates.map do |c| %>
			[<%= c.longitude.to_s %>, <%= c.latitude.to_s  %>],
		<% end %>]

		var midpoint_lat = (coords[0][0] + geo_lat) / 2;
		var midpoint_lng = (coords[0][1] + geo_lng) / 2;

		var mymap = L.map('mapid',{dragging:false}).setView([midpoint_lat, midpoint_lng], 12);

		L.marker([geo_lat, geo_lng]).addTo(mymap).bindPopup("You're here homeslice");

		console.log(geo_lng + ", " + geo_lat);

		L.marker([coords[0][0], coords[0][1]]).addTo(mymap).bindPopup("Path start. Or end. It is more the destination than the journey...");
		L.marker([coords[coords.length - 1][0], coords[coords.length - 1][1]]).addTo(mymap).bindPopup("One side of this winding path we call life. Or as we call it at hackfest <%= @track.name %>!");
		L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoiY2RlaWdodG9uIiwiYSI6ImNpczJrNGV6dDAxM3gyemxrNWlzd3Njbm8ifQ.vv_McJTtMa2DmJNmDVypNA', {
			maxZoom: 18,
			attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
				'<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
				'Imagery © <a href="http://mapbox.com">Mapbox</a>',
			id: 'mapbox.streets'
		}).addTo(mymap);

		var polygon = L.polyline(coords, {color: 'green'}).addTo(mymap)

		console.log(pos);

		// if (pos != null)
		//	mymap.setView({lat: pos.coords.latitude, lng: pos.coords.longitude}, 18);
	};
});
