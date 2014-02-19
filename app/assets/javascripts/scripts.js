jQuery(document).ready(function($) {
	
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
	
});

function changeRatingStars(whichStars, starNum) {
	var thisStar = $(whichStars + ' i.fa:eq(' + starNum + ')');
	thisStar.removeClass().addClass('fa fa-star');
	thisStar.prevAll(whichStars + ' i.fa').removeClass().addClass('fa fa-star');
	thisStar.nextAll(whichStars + ' i.fa').removeClass().addClass('fa fa-star-o');
}