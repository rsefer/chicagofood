var infowindow, map;
var markerList = [];

function initialize(latitude, longitude) {

	infowindow = new google.maps.InfoWindow({ content: 'Loading...' });

	var mapOptions = {
		center: new google.maps.LatLng(latitude, longitude),
		zoom: 13,
    minZoom: 11,
    maxZoom: 19,
		mapTypeControl: false
	};

	map = new google.maps.Map(document.getElementById('google-map'), mapOptions);
}

jQuery(document).ready(function($) {

	$('.datepicker').datepicker({
		format: 'yyyy-mm-dd'
	});

});
