var map;
var mapstyle = [
  {
    "featureType": "landscape",
    "stylers": [
      {
        "saturation": -100
      },
      {
        "lightness": 65
      },
      {
        "visibility": "on"
      }
    ]
  },
  {
    "featureType": "poi",
    "stylers": [
      {
        "saturation": -100
      },
      {
        "lightness": 51
      },
      {
        "visibility": "simplified"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "stylers": [
      {
        "saturation": -100
      },
      {
        "visibility": "simplified"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "stylers": [
      {
        "saturation": -100
      },
      {
        "lightness": 30
      },
      {
        "visibility": "on"
      }
    ]
  },
  {
    "featureType": "road.local",
    "stylers": [
      {
        "saturation": -100
      },
      {
        "lightness": 40
      },
      {
        "visibility": "on"
      }
    ]
  },
  {
    "featureType": "transit",
    "stylers": [
      {
        "saturation": -100
      },
      {
        "visibility": "simplified"
      }
    ]
  },
  {
    "featureType": "administrative.province",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels",
    "stylers": [
      {
        "visibility": "on"
      },
      {
        "lightness": -25
      },
      {
        "saturation": -100
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "hue": "#ffff00"
      },
      {
        "lightness": -25
      },
      {
        "saturation": -97
      }
    ]
  }
];

function initialize(latitude, longitude) {
	infowindow = new google.maps.InfoWindow({ content: 'Loading...' });
	map = new google.maps.Map(document.getElementById('google-map'), {
		center: new google.maps.LatLng(latitude, longitude),
		zoom: 13,
    minZoom: 11,
    maxZoom: 19,
		mapTypeControl: false,
		styles: mapstyle
	});
}

function changeRatingStars(whichStars, starNum) {
	var thisStar = $(whichStars + ' i.fa:eq(' + starNum + ')');
	thisStar.removeClass().addClass('fa fa-star');
	thisStar.prevAll(whichStars + ' i.fa').removeClass().addClass('fa fa-star');
	thisStar.nextAll(whichStars + ' i.fa').removeClass().addClass('fa fa-star-o');
}

jQuery(document).ready(function($) {

	$('.datepicker').datepicker({
		format: 'yyyy-mm-dd'
	});

	var myratingHTML = $('#myrating').html();

	$('#myrating i.fa').click(function() {
		var thisClickIndex = $('#myrating i.fa').index(this) + 1;
		$('input#rating_rating').val(thisClickIndex);
		$('form.edit_rating, form.new_rating').submit();
		$('form.edit_rating, form.new_rating').bind('ajax:complete', function() {
			$.get(window.location.pathname + '/rating_average', function(data) {
				var newRatingIndex = $('#ourrating i.fa').index(data.rating_average);
				changeRatingStars('#ourrating', data.rating_average - 1);
			});
		});

		myratingHTML = $('#myrating').html();

	});

	$('#myrating i.fa').hover(function() {
		var thisClickIndex = $('#myrating i.fa').index(this);
		changeRatingStars('#myrating', thisClickIndex);
	}, function() {
	});

	$('#totrysubmit').click(function(e) {
		e.preventDefault();
		$('form#new_try').submit();
	});

  $('#manual-entry-toggle').click(function(e) {
    e.preventDefault();
    $('#list_item_venue_id').remove();
    $('#list-item-auto-entry').hide();
    $(this).hide();
    $('#list-item-manual-entry').removeClass('hidden');
    $('#list_item_manual_entry').attr('value', 'true');
  });

});
