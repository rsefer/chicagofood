var infowindow, map;
var markerList = [];

function initialize(latitude, longitude) {

	infowindow = new google.maps.InfoWindow({ content: 'Loading...' });

	var mapOptions = {
		center: new google.maps.LatLng(latitude, longitude),
		zoom: 13,
    minZoom: 11,
    maxZoom: 19
	};

	map = new google.maps.Map(document.getElementById('google-map'), mapOptions);
}
