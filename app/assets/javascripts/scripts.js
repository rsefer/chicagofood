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

jQuery(document).on('turbolinks:load', function() {

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

  $('#find-neighborhood-by-street').click(function(e) {
    e.preventDefault();
    if ($('input#venue_street').val().length > 2) {
      $(this).append('<i class="fa fa-refresh fa-spin fa-fw"></i>');
      $.ajax({
        url: '/venues_controller/find_nearby_neighborhoods',
        type: 'GET',
        dataType: 'json',
        data: {
          currentStreet: $('#venue_street').val(),
          currentCity: $('#venue_city').val(),
          currentState: $('#venue_state').val()
        },
        success: function(result, status, xhr) {
          $('#find-neighborhood-by-street .fa-refresh').remove();
          if (result.neighborhoods.length > 0) {
            var content = '<p>Suggestions: ';
            for (var i = 0; i < result.neighborhoods.length; i++) {
              content += '<a href="#" class="suggested-neighborhood-item" data-neighborhood-id="' + result.neighborhoods[i].id + '">' + result.neighborhoods[i].name + '</a>';
              if (i < result.neighborhoods.length - 1) {
                content += ', ';
              }
            }
            content += '</p>';
            $('.suggested-neighborhoods').html(content).promise().done(function() {
              $('.suggested-neighborhoods a').click(function(e) {
                e.preventDefault();
                var thisID = $(this).attr('data-neighborhood-id');
                $('#venue_neighborhood_id').val(thisID);
              });
            });
          } else {
            $('.suggested-neighborhoods').html('<p>No nearby neighborhoods found.</p>');
          }
        }
      });
    }
  });

});
